import 'package:flutter/material.dart';

import '../controllers/family_tree_controller.dart';
import '../models/family_member_model.dart';

import 'family_branch_painter.dart';
import 'family_member_node.dart';

class FamilyTreeCanvas extends StatefulWidget {
  final FamilyTreeController controller;

  const FamilyTreeCanvas({
    super.key,
    required this.controller,
  });

  @override
  State<FamilyTreeCanvas> createState() =>
      _FamilyTreeCanvasState();
}

class _FamilyTreeCanvasState
    extends State<FamilyTreeCanvas> {
  final TransformationController
  _transformationController =
  TransformationController();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(
      _syncControllerTransform,
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(
      _syncControllerTransform,
    );
    _transformationController.dispose();
    super.dispose();
  }

  void _syncControllerTransform() {
    final scale = widget.controller.currentScale;
    final offset = widget.controller.currentOffset;

    final matrix = Matrix4.identity()
      ..translate(
        offset.dx,
        offset.dy,
      )
      ..scale(scale);

    _transformationController.value = matrix;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (context, child) {
        final members =
            widget.controller.visibleMembers;

        if (members.isEmpty) {
          return const SizedBox.shrink();
        }

        return InteractiveViewer(
          transformationController:
          _transformationController,
          constrained: false,
          boundaryMargin:
          const EdgeInsets.all(500),
          minScale: 0.5,
          maxScale: 3.5,
          onInteractionUpdate: (_) {
            final matrix =
                _transformationController.value;

            widget.controller.updateScale(
              matrix.getMaxScaleOnAxis(),
            );

            widget.controller.updateOffset(
              Offset(
                matrix.storage[12],
                matrix.storage[13],
              ),
            );
          },
          child: SizedBox(
            width: 1200,
            height: 1600,
            child: Stack(
              children: [
                ..._buildBranches(members),
                ..._buildNodes(members),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> _buildBranches(
      List<FamilyMemberModel> members,
      ) {
    return members
        .where((member) => member.hasChildren)
        .map((member) {
      return Positioned(
        left: member.position.dx,
        top: member.position.dy + 90,
        child: SizedBox(
          width: 280,
          height: 220,
          child: CustomPaint(
            painter: FamilyBranchPainter(
              childrenCount:
              member.children.length,
              progress: widget.controller
                  .isExpanded(member.id)
                  ? 1.0
                  : 0.0,
              isFocused: widget.controller
                  .highlightedNodeId ==
                  member.id,
            ),
          ),
        ),
      );
    }).toList();
  }

  List<Widget> _buildNodes(
      List<FamilyMemberModel> members,
      ) {
    return members.map((member) {
      return AnimatedPositioned(
        duration: const Duration(
          milliseconds: 450,
        ),
        curve: Curves.easeOutCubic,
        left: member.position.dx,
        top: member.position.dy,
        child: FamilyMemberNode(
          id: member.id,
          fullName: member.fullName,
          image: member.imageUrl,
          relationship: member.relationship,
          hasChildren:
          member.hasChildren,
          isExpanded: widget.controller
              .isExpanded(member.id),
          isSelected:
          widget.controller
              .selectedMember
              ?.id ==
              member.id,
          isDeceased:
          !member.isAlive,
          isInactive: false,
          onTap: () {
            widget.controller
                .selectMember(member);
          },
          onExpand: () {
            widget.controller
                .toggleNode(member);
          },
        ),
      );
    }).toList();
  }
}