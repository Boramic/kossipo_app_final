import 'package:flutter/material.dart';

import '../models/family_member_model.dart';

class FamilyTreeController extends ChangeNotifier {
  FamilyTreeController({
    required this.rootMember,
    required this.allMembers,
  }) {
    _visibleMembers = [rootMember];
  }

  /// ROOT MEMBER
  FamilyMemberModel rootMember;

  /// ALL MEMBERS CACHE
  final List<FamilyMemberModel> allMembers;

  /// SEARCH
  final TextEditingController searchController =
  TextEditingController();

  String _searchQuery = '';

  /// TREE STATE
  final Map<String, bool> _expandedNodes = {};

  /// CURRENT VISIBLE NODES
  List<FamilyMemberModel> _visibleMembers = [];

  /// CURRENT SELECTED MEMBER
  FamilyMemberModel? _selectedMember;

  /// CURRENT ACTIVE GENERATION
  int? _focusedGeneration;

  /// CURRENT PATH (lineage)
  final List<String> _navigationPath = [];

  /// CURRENT FOCUSED MEMBER
  String? _focusedMemberId;

  /// BOTTOM SHEET
  bool _isBottomSheetOpen = false;

  /// ANIMATION STATES
  bool _isAnimating = false;

  /// ZOOM STATE
  double _currentScale = 1.0;

  Offset _currentOffset = Offset.zero;

  /// HIGHLIGHTED NODE
  String? _highlightedNodeId;

  /// ==========================
  /// GETTERS
  /// ==========================

  String get searchQuery => _searchQuery;

  bool get isSearching => _searchQuery.isNotEmpty;

  FamilyMemberModel? get selectedMember =>
      _selectedMember;

  List<FamilyMemberModel> get visibleMembers =>
      _visibleMembers;

  bool get isBottomSheetOpen =>
      _isBottomSheetOpen;

  bool get isAnimating => _isAnimating;

  double get currentScale => _currentScale;

  Offset get currentOffset => _currentOffset;

  String? get highlightedNodeId =>
      _highlightedNodeId;

  /// ==========================
  /// SEARCH LOGIC
  /// ==========================

  void updateSearch(String query) {
    _searchQuery = query.trim();
    notifyListeners();
  }

  void clearSearch() {
    searchController.clear();
    _searchQuery = '';
    notifyListeners();
  }

  List<FamilyMemberModel> get filteredMembers {
    if (_searchQuery.isEmpty) return [];

    return allMembers.where((member) {
      return member.fullName
          .toLowerCase()
          .contains(
        _searchQuery.toLowerCase(),
      );
    }).toList();
  }

  /// ==========================
  /// NODE EXPANSION
  /// ==========================

  bool isExpanded(String memberId) {
    return _expandedNodes[memberId] ?? false;
  }

  void toggleNode(FamilyMemberModel member) {
    final isOpen = isExpanded(member.id);

    if (isOpen) {
      collapseNode(member);
    } else {
      expandNode(member);
    }
  }

  void expandNode(FamilyMemberModel member) {
    _collapseGeneration(member.generation);

    _expandedNodes[member.id] = true;

    _visibleMembers = [
      member,
      ...member.children,
    ];

    _focusedGeneration = member.generation;
    _focusedMemberId = member.id;

    _navigationPath.add(member.id);

    notifyListeners();
  }

  void collapseNode(FamilyMemberModel member) {
    _expandedNodes[member.id] = false;

    _visibleMembers = [member];

    _navigationPath.remove(member.id);

    notifyListeners();
  }

  void _collapseGeneration(int generation) {
    final ids = _expandedNodes.keys.toList();

    for (final id in ids) {
      final member = allMembers.firstWhere(
            (m) => m.id == id,
      );

      if (member.generation == generation) {
        _expandedNodes[id] = false;
      }
    }
  }

  /// ==========================
  /// FOCUS LOGIC
  /// ==========================

  void focusOnMember(String memberId) {
    final member = allMembers.firstWhere(
          (m) => m.id == memberId,
    );

    _focusedMemberId = member.id;

    _highlightedNodeId = member.id;

    _visibleMembers = [member];

    notifyListeners();
  }

  /// ==========================
  /// MEMBER SELECTION
  /// ==========================

  void selectMember(FamilyMemberModel member) {
    _selectedMember = member;
    _highlightedNodeId = member.id;
    _isBottomSheetOpen = true;

    notifyListeners();
  }

  void clearSelection() {
    _selectedMember = null;
    _highlightedNodeId = null;
    _isBottomSheetOpen = false;

    notifyListeners();
  }

  /// ==========================
  /// TREE NAVIGATION
  /// ==========================

  void goBack() {
    if (_navigationPath.isEmpty) return;

    _navigationPath.removeLast();

    if (_navigationPath.isEmpty) {
      _visibleMembers = [rootMember];
    } else {
      final previousId =
          _navigationPath.last;

      final member = allMembers.firstWhere(
            (m) => m.id == previousId,
      );

      _visibleMembers = [
        member,
        ...member.children,
      ];
    }

    notifyListeners();
  }

  /// ==========================
  /// ZOOM / PAN
  /// ==========================

  void updateScale(double scale) {
    _currentScale = scale;
    notifyListeners();
  }

  void updateOffset(Offset offset) {
    _currentOffset = offset;
    notifyListeners();
  }

  void resetView() {
    _currentScale = 1.0;
    _currentOffset = Offset.zero;

    notifyListeners();
  }

  /// ==========================
  /// ANIMATIONS
  /// ==========================

  void startAnimation() {
    _isAnimating = true;
    notifyListeners();
  }

  void stopAnimation() {
    _isAnimating = false;
    notifyListeners();
  }

  /// ==========================
  /// ROOT SWITCH
  /// ==========================

  void changeRoot(FamilyMemberModel member) {
    rootMember = member;

    _expandedNodes.clear();
    _visibleMembers = [member];
    _navigationPath.clear();

    _focusedMemberId = member.id;

    notifyListeners();
  }

  /// ==========================
  /// DISPOSE
  /// ==========================

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}