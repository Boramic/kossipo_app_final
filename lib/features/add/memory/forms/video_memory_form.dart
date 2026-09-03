import 'dart:io';

import 'package:flutter/material.dart';

import '../../../../shared/inputs/app_date_field.dart';
import '../../../../shared/inputs/app_text_field.dart';
import '../../../../shared/inputs/multiline_field.dart';

import '../controllers/memory_controller.dart';
import '../models/memory_type.dart';
import '../services/media_picker_service.dart';

class VideoMemoryForm extends StatefulWidget {
  const VideoMemoryForm({
    super.key,
  });

  @override
  State<VideoMemoryForm> createState() =>
      _VideoMemoryFormState();
}

class _VideoMemoryFormState
    extends State<VideoMemoryForm> {
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
      type: MemoryType.video,
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

  Future<void> _pickVideo() async {
    try {
      final path =
      await _mediaPicker.pickVideo();

      if (path == null) {
        return;
      }

      controller.setMediaPath(path);
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Unable to select video: $e',
          ),
        ),
      );
    }
  }

  Widget _buildVideoPicker() {
    final hasMedia =
        controller.draft.hasMedia;

    return GestureDetector(
      onTap: _pickVideo,
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
            ? Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration:
              BoxDecoration(
                borderRadius:
                BorderRadius
                    .circular(
                  20,
                ),
                color:
                Colors.black12,
              ),
              child: const Icon(
                Icons.movie,
                size: 80,
                color: Colors.black54,
              ),
            ),
            Container(
              width: 72,
              height: 72,
              decoration:
              const BoxDecoration(
                shape:
                BoxShape.circle,
                color:
                Colors.white,
              ),
              child: const Icon(
                Icons.play_arrow,
                size: 42,
              ),
            ),
            Positioned(
              bottom: 12,
              left: 12,
              right: 12,
              child: Text(
                File(
                  controller.draft
                      .mediaPath!,
                ).path
                    .split('/')
                    .last,
                maxLines: 1,
                overflow:
                TextOverflow
                    .ellipsis,
                textAlign:
                TextAlign.center,
              ),
            ),
          ],
        )
            : const Column(
          mainAxisAlignment:
          MainAxisAlignment
              .center,
          children: [
            Icon(
              Icons.video_library,
              size: 54,
            ),
            SizedBox(height: 12),
            Text(
              'Select Video',
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
        _buildVideoPicker(),

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
          controller.draft
              .capturedDate,
          onChanged:
          controller.setDate,
        ),

        const SizedBox(height: 24),

        Container(
          padding:
          const EdgeInsets.all(
            16,
          ),
          decoration: BoxDecoration(
            borderRadius:
            BorderRadius.circular(
              16,
            ),
            color:
            Colors.blue.shade50,
          ),
          child: const Row(
            children: [
              Icon(
                Icons.video_camera_back,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Family member tagging will be available in the next step.',
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