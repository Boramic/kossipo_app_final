import 'package:flutter/material.dart';

import '../../../../shared/inputs/app_date_field.dart';
import '../../../../shared/inputs/app_text_field.dart';
import '../../../../shared/inputs/multiline_field.dart';

import '../controllers/memory_controller.dart';
import '../models/memory_type.dart';
import '../services/audio_recorder_service.dart';

class VoiceMemoryForm extends StatefulWidget {
  const VoiceMemoryForm({
    super.key,
  });

  @override
  State<VoiceMemoryForm> createState() =>
      _VoiceMemoryFormState();
}

class _VoiceMemoryFormState
    extends State<VoiceMemoryForm> {
  late final MemoryController controller;

  final AudioRecorderService _audioRecorder =
  AudioRecorderService();

  final titleController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  final locationController =
  TextEditingController();

  bool _isRecording = false;

  bool _isPaused = false;

  @override
  void initState() {
    super.initState();

    controller = MemoryController(
      type: MemoryType.voice,
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

    _audioRecorder.dispose();

    super.dispose();
  }

  Future<void> _startRecording() async {
    try {
      await _audioRecorder.startRecording();

      setState(() {
        _isRecording = true;
        _isPaused = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to start recording: $e',
          ),
        ),
      );
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path =
      await _audioRecorder.stopRecording();

      if (path == null) {
        return;
      }

      controller.setMediaPath(path);

      setState(() {
        _isRecording = false;
        _isPaused = false;
      });
    } catch (e) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Unable to stop recording: $e',
          ),
        ),
      );
    }
  }

  Future<void> _pauseRecording() async {
    try {
      await _audioRecorder.pauseRecording();

      setState(() {
        _isPaused = true;
      });
    } catch (_) {}
  }

  Future<void> _resumeRecording() async {
    try {
      await _audioRecorder.resumeRecording();

      setState(() {
        _isPaused = false;
      });
    } catch (_) {}
  }

  Widget _buildRecorderCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          Icon(
            _isRecording
                ? Icons.mic
                : Icons.mic_none,
            size: 60,
            color: _isRecording
                ? Colors.red
                : Colors.grey,
          ),

          const SizedBox(height: 12),

          Text(
            _isRecording
                ? (_isPaused
                ? 'Recording Paused'
                : 'Recording...')
                : controller.draft.hasMedia
                ? 'Voice Recorded'
                : 'No Voice Recorded',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            alignment:
            WrapAlignment.center,
            children: [
              if (!_isRecording)
                ElevatedButton.icon(
                  onPressed:
                  _startRecording,
                  icon: const Icon(
                    Icons.mic,
                  ),
                  label: const Text(
                    'Record',
                  ),
                ),

              if (_isRecording &&
                  !_isPaused)
                ElevatedButton.icon(
                  onPressed:
                  _pauseRecording,
                  icon: const Icon(
                    Icons.pause,
                  ),
                  label: const Text(
                    'Pause',
                  ),
                ),

              if (_isRecording &&
                  _isPaused)
                ElevatedButton.icon(
                  onPressed:
                  _resumeRecording,
                  icon: const Icon(
                    Icons.play_arrow,
                  ),
                  label: const Text(
                    'Resume',
                  ),
                ),

              if (_isRecording)
                ElevatedButton.icon(
                  onPressed:
                  _stopRecording,
                  icon: const Icon(
                    Icons.stop,
                  ),
                  label: const Text(
                    'Stop',
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildRecorderCard(),

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