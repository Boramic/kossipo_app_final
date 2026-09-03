import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class AudioRecorderService {
  AudioRecorderService({
    AudioRecorder? recorder,
  }) : _recorder = recorder ?? AudioRecorder();

  final AudioRecorder _recorder;

  String? _currentFilePath;

  // ---------------------------------------------------------------------------
  // GETTERS
  // ---------------------------------------------------------------------------

  String? get currentFilePath =>
      _currentFilePath;

  // ---------------------------------------------------------------------------
  // PERMISSIONS
  // ---------------------------------------------------------------------------

  Future<bool> requestPermission() async {
    final status =
    await Permission.microphone.request();

    return status.isGranted;
  }

  Future<bool> hasPermission() async {
    return Permission.microphone.isGranted;
  }

  // ---------------------------------------------------------------------------
  // RECORD
  // ---------------------------------------------------------------------------

  Future<String> startRecording() async {
    final granted =
    await requestPermission();

    if (!granted) {
      throw Exception(
        'Microphone permission denied.',
      );
    }

    final directory =
    await getTemporaryDirectory();

    final fileName =
        'voice_memory_${DateTime.now().millisecondsSinceEpoch}.m4a';

    final path =
        '${directory.path}/$fileName';

    await _recorder.start(
      const RecordConfig(
        encoder: AudioEncoder.aacLc,
        bitRate: 128000,
        sampleRate: 44100,
      ),
      path: path,
    );

    _currentFilePath = path;

    return path;
  }

  Future<String?> stopRecording() async {
    final path =
    await _recorder.stop();

    if (path == null) {
      return null;
    }

    _currentFilePath = path;

    return path;
  }

  Future<void> pauseRecording() async {
    final recording =
    await _recorder.isRecording();

    if (!recording) {
      return;
    }

    await _recorder.pause();
  }

  Future<void> resumeRecording() async {
    final paused =
    await _recorder.isPaused();

    if (!paused) {
      return;
    }

    await _recorder.resume();
  }

  Future<void> cancelRecording() async {
    final path = _currentFilePath;

    await _recorder.stop();

    if (path != null) {
      final file = File(path);

      if (await file.exists()) {
        await file.delete();
      }
    }

    _currentFilePath = null;
  }

  // ---------------------------------------------------------------------------
  // STATE
  // ---------------------------------------------------------------------------

  Future<bool> isRecording() async {
    return await _recorder.isRecording();
  }

  Future<bool> isPaused() async {
    return await _recorder.isPaused();
  }

  Future<bool> isCurrentlyRecording() async {
    return await _recorder.isRecording();
  }

  // ---------------------------------------------------------------------------
  // CLEANUP
  // ---------------------------------------------------------------------------

  Future<void> dispose() async {
    await _recorder.dispose();
  }
}