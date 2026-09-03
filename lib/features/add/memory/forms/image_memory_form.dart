import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../shared/inputs/app_date_field.dart';
import '../../../../shared/inputs/app_text_field.dart';
import '../../../../shared/inputs/multiline_field.dart';

import '../controllers/memory_controller.dart';
import '../models/memory_type.dart';
import '../services/media_picker_service.dart';

class ImageMemoryForm extends StatefulWidget {
  const ImageMemoryForm({
    super.key,
  });

  @override
  State<ImageMemoryForm> createState() =>
      _ImageMemoryFormState();
}

class _ImageMemoryFormState
    extends State<ImageMemoryForm> {
  late final MemoryController controller;

  final MediaPickerService _mediaPicker =
  MediaPickerService();

  final titleController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  final locationController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    controller = MemoryController(
      type: MemoryType.image,
    );

    controller.addListener(() {
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();

    titleController.dispose();
    descriptionController.dispose();
    locationController.dispose();

    super.dispose();
  }

  Future<void> _pickImage() async {
    try {
      final path = await _mediaPicker.pickMedia(
        MemoryType.image,
      );

      if (path == null) {
        return;
      }

      controller.setMediaPath(path);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to select image: $e',
          ),
        ),
      );
    }
  }

  Widget _buildImagePicker() {
    final hasMedia =
        controller.draft.hasMedia;

    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(20),
          border: Border.all(
            color: Colors.grey.shade300,
          ),
        ),
        child: hasMedia
            ? ClipRRect(
          borderRadius:
          BorderRadius.circular(
            20,
          ),
          child: Image.file(
            File(
              controller
                  .draft.mediaPath!,
            ),
            fit: BoxFit.cover,
          ),
        )
            : const Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate,
              size: 54,
            ),
            SizedBox(height: 12),
            Text(
              'Select Image',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildImagePicker(),

        const SizedBox(height: 24),

        AppTextField(
          controller: titleController,
          hintText: 'Memory title',
          onChanged:
          controller.setTitle,
        ),

        const SizedBox(height: 18),

        AppMultilineField(
          controller:
          descriptionController,
          label: 'Description',
          hintText:
          'Describe this memory...',
          maxLength: 500,
          onChanged:
          controller.setDescription,
        ),

        const SizedBox(height: 18),

        AppTextField(
          controller:
          locationController,
          hintText: 'Location',
          onChanged:
          controller.setLocation,
        ),

        const SizedBox(height: 18),

        AppDateField(
          label: 'Capture date',
          initialDate:
          controller.draft.capturedDate,
          onChanged:
          controller.setDate,
        ),

        const SizedBox(height: 24),

        Container(
          padding:
          const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(
              16,
            ),
            color: Colors.green.shade50,
          ),
          child: const Row(
            children: [
              Icon(
                Icons.family_restroom,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Member tagging will be added in the next step.',
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 40),
      ],
    );
  }
}