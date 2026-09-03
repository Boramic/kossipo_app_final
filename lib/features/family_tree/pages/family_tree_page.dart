import 'package:flutter/material.dart';

import '../../../shared/layouts/main_scaffold.dart';
import '../../../shared/inputs/app_search_field.dart';

import '../controllers/family_tree_controller.dart';
import '../models/family_member_model.dart';

import '../widgets/family_background.dart';
import '../widgets/family_member_bottom_sheet.dart';
import '../widgets/family_search_results.dart';
import '../widgets/family_tree_canvas.dart';

class FamilyTreePage extends StatefulWidget {
  const FamilyTreePage({super.key});

  @override
  State<FamilyTreePage> createState() =>
      _FamilyTreePageState();
}

class _FamilyTreePageState
    extends State<FamilyTreePage> {
  late final FamilyTreeController controller;

  @override
  void initState() {
    super.initState();

    controller = FamilyTreeController(
      rootMember: _mockMembers.first,
      allMembers: _mockMembers,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      drawerIndex: 1,
      bottomNavIndex: 0,
      showHeader: false,
      showBottomNav: false,

      child: AnimatedBuilder(
        animation: controller,
        builder: (context, _) {
          return Stack(
            children: [
              /// BACKGROUND
              const Positioned.fill(
                child: FamilyBackground(),
              ),

              /// TREE
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 90,
                    bottom: 110,
                  ),
                  child: AnimatedOpacity(
                    duration: const Duration(
                      milliseconds: 250,
                    ),
                    opacity:
                    controller.isSearching
                        ? 0
                        : 1,
                    child: IgnorePointer(
                      ignoring:
                      controller.isSearching,
                      child: FamilyTreeCanvas(
                        controller: controller,
                      ),
                    ),
                  ),
                ),
              ),

              /// SEARCH
              Positioned(
                top: 16,
                left: 20,
                right: 20,
                child: SearchField(
                  controller:
                  controller.searchController,
                  hintText:
                  "Search family member...",
                  onChanged:
                  controller.updateSearch,
                ),
              ),

              /// RESULTS
              Positioned.fill(
                top: 90,
                bottom: 110,
                child: FamilySearchResults(
                  controller: controller,
                ),
              ),

              /// MEMBER PANEL
              Positioned(
                left: 0,
                right: 0,
                bottom: 75,
                child:
                FamilyMemberBottomSheet(
                  controller: controller,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// ==========================================
/// MOCK DATA
/// ==========================================

final List<FamilyMemberModel> _mockMembers = [
  FamilyMemberModel(
    id: "1",
    familyId: "family_001",
    fullName: "Grand Father",
    imageUrl: "",
    gender: "Male",
    relationship: "Root",
    position: const Offset(500, 100),
    birthDate: DateTime(1940, 5, 10),
    maritalStatus: "Married",
    profession: "Farmer",
    biography:
    "Founder of the family lineage.",
    location: "Cameroon",
    generation: 0,
    children: [],
    isRoot: true,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  ),
];