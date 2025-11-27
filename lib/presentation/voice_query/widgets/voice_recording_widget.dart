import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class VoiceRecordingWidget extends StatefulWidget {
  final Function(String) onTranscriptionComplete;
  final VoidCallback onRecordingStart;
  final VoidCallback onRecordingStop;

  const VoiceRecordingWidget({
    super.key,
    required this.onTranscriptionComplete,
    required this.onRecordingStart,
    required this.onRecordingStop,
  });

  @override
  State<VoiceRecordingWidget> createState() => _VoiceRecordingWidgetState();
}

class _VoiceRecordingWidgetState extends State<VoiceRecordingWidget>
    with TickerProviderStateMixin {
  final AudioRecorder _audioRecorder = AudioRecorder();
  bool _isRecording = false;
  bool _isProcessing = false;
  String _transcribedText = '';
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _waveController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    _waveAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _waveController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    _audioRecorder.dispose();
    super.dispose();
  }

  Future<bool> _requestMicrophonePermission() async {
    if (kIsWeb) return true;

    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<void> _startRecording() async {
    try {
      if (!await _requestMicrophonePermission()) {
        _showPermissionDeniedMessage();
        return;
      }

      if (await _audioRecorder.hasPermission()) {
        setState(() {
          _isRecording = true;
          _transcribedText = '';
        });

        widget.onRecordingStart();
        _pulseController.repeat(reverse: true);
        _waveController.repeat();

        if (kIsWeb) {
          await _audioRecorder.start(
            const RecordConfig(encoder: AudioEncoder.wav),
            path: 'recording.wav',
          );
        } else {
          final dir = await getTemporaryDirectory();
          String path = '${dir.path}/recording.m4a';
          await _audioRecorder.start(
            const RecordConfig(),
            path: path,
          );
        }
      }
    } catch (e) {
      _showErrorMessage('Failed to start recording');
      setState(() => _isRecording = false);
    }
  }

  Future<void> _stopRecording() async {
    try {
      final path = await _audioRecorder.stop();

      setState(() {
        _isRecording = false;
        _isProcessing = true;
      });

      widget.onRecordingStop();
      _pulseController.stop();
      _waveController.stop();

      if (path != null) {
        await _processAudioFile(path);
      }
    } catch (e) {
      _showErrorMessage('Failed to stop recording');
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  Future<void> _processAudioFile(String filePath) async {
    // Simulate speech-to-text processing
    await Future.delayed(const Duration(seconds: 2));

    // Mock transcription result
    final mockTranscriptions = [
      'मेरी फसल में पीले पत्ते दिख रहे हैं, क्या करूं?',
      'What fertilizer should I use for wheat crop?',
      'ಬೆಳೆಗೆ ನೀರು ಎಷ್ಟು ಬಾರಿ ಕೊಡಬೇಕು?',
      'আমার ধানের ক্ষেতে পোকার আক্রমণ হয়েছে',
      'मला माझ्या भातशेतीसाठी सल्ला हवा',
    ];

    final transcription = mockTranscriptions[
        DateTime.now().millisecondsSinceEpoch % mockTranscriptions.length];

    setState(() => _transcribedText = transcription);
    widget.onTranscriptionComplete(transcription);
  }

  void _showPermissionDeniedMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Microphone permission is required for voice queries',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onError,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onError,
          ),
        ),
        backgroundColor: AppTheme.lightTheme.colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Voice recording button with animations
        GestureDetector(
          onTap: _isProcessing
              ? null
              : (_isRecording ? _stopRecording : _startRecording),
          child: Container(
            width: 35.w,
            height: 35.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: _isRecording
                    ? [
                        AppTheme.lightTheme.colorScheme.error,
                        AppTheme.lightTheme.colorScheme.error
                            .withValues(alpha: 0.7),
                      ]
                    : [
                        AppTheme.lightTheme.colorScheme.primary,
                        AppTheme.lightTheme.colorScheme.primaryContainer,
                      ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: (_isRecording
                          ? AppTheme.lightTheme.colorScheme.error
                          : AppTheme.lightTheme.colorScheme.primary)
                      .withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: AnimatedBuilder(
              animation: _pulseAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: _isRecording ? _pulseAnimation.value : 1.0,
                  child: Center(
                    child: _isProcessing
                        ? SizedBox(
                            width: 8.w,
                            height: 8.w,
                            child: CircularProgressIndicator(
                              color: AppTheme.lightTheme.colorScheme.onPrimary,
                              strokeWidth: 3,
                            ),
                          )
                        : CustomIconWidget(
                            iconName: _isRecording ? 'stop' : 'mic',
                            color: AppTheme.lightTheme.colorScheme.onPrimary,
                            size: 12.w,
                          ),
                  ),
                );
              },
            ),
          ),
        ),

        SizedBox(height: 4.h),

        // Recording status
        if (_isRecording) ...[
          AnimatedBuilder(
            animation: _waveAnimation,
            builder: (context, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 1.w),
                    width: 1.w,
                    height: (2 +
                            (3 *
                                _waveAnimation.value *
                                (index % 2 == 0 ? 1 : 0.7)))
                        .h,
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  );
                }),
              );
            },
          ),
          SizedBox(height: 2.h),
          Text(
            'Listening...',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
          ),
        ],

        if (_isProcessing) ...[
          Text(
            'Processing your query...',
            style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.secondary,
            ),
          ),
        ],

        // Transcribed text display
        if (_transcribedText.isNotEmpty) ...[
          SizedBox(height: 3.h),
          Container(
            width: 85.w,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.3),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.lightTheme.colorScheme.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'record_voice_over',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 5.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      'Your Query:',
                      style: AppTheme.lightTheme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
                Text(
                  _transcribedText,
                  style: AppTheme.lightTheme.textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],

        // Instructions
        if (!_isRecording && !_isProcessing && _transcribedText.isEmpty) ...[
          SizedBox(height: 4.h),
          Text(
            'Tap to start voice query',
            style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Text(
            'Speak in Hindi, English, or your regional language',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
