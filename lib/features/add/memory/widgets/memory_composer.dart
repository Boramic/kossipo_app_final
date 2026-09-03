import 'package:flutter/material.dart';
import '../forms/image_memory_form.dart';
import 'memory_type_card.dart';

enum MemoryType {
  none,
  image,
  video,
  voice,
}

class MemoryComposer extends StatefulWidget {
  const MemoryComposer({
    super.key,
  });

  @override
  State<MemoryComposer> createState() =>
      _MemoryComposerState();
}

class _MemoryComposerState
    extends State<MemoryComposer> {
  MemoryType _selectedType =
      MemoryType.none;

  void _selectType(
      MemoryType type,
      ) {
    setState(() {
      _selectedType = type;
    });
  }

  void _backToSelection() {
    setState(() {
      _selectedType = MemoryType.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (_selectedType) {
      case MemoryType.none:
        return _buildSelector();

      case MemoryType.image:
        return const ImageMemoryForm();

      case MemoryType.video:
        return _buildComingSoon();

      case MemoryType.voice:
        return _buildComingSoon();
    }
  }

  Widget _buildSelector() {
    return Column(
      children: [
        MemoryTypeCard(
          icon: Icons.photo_rounded,
          title: "Image Memory",
          description:
          "Capture smiles, places and unforgettable family moments.",
          onTap: () => _selectType(
            MemoryType.image,
          ),
        ),

        const SizedBox(height: 18),

        MemoryTypeCard(
          icon: Icons.videocam_rounded,
          title: "Video Memory",
          description:
          "Relive voices, emotions and precious celebrations.",
          onTap: () => _selectType(
            MemoryType.video,
          ),
        ),

        const SizedBox(height: 18),

        MemoryTypeCard(
          icon: Icons.mic_rounded,
          title: "Voice Memory",
          description:
          "Preserve stories exactly as they were told.",
          onTap: () => _selectType(
            MemoryType.voice,
          ),
        ),
      ],
    );
  }

  Widget _buildComingSoon() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.construction_rounded,
            size: 48,
          ),

          const SizedBox(height: 12),

          const Text(
            "Memory form coming soon",
          ),

          const SizedBox(height: 20),

          TextButton(
            onPressed: _backToSelection,
            child: const Text(
              "Back",
            ),
          ),
        ],
      ),
    );
  }
}