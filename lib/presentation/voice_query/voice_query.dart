import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/ai_response_widget.dart';
import './widgets/conversation_history_widget.dart';
import './widgets/voice_recording_widget.dart';

class VoiceQuery extends StatefulWidget {
  const VoiceQuery({super.key});

  @override
  State<VoiceQuery> createState() => _VoiceQueryState();
}

class _VoiceQueryState extends State<VoiceQuery> with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  String _currentQuery = '';
  final String _currentResponse = '';
  bool _showResponse = false;
  bool _showHistory = false;

  final List<Map<String, dynamic>> _conversationHistory = [
    {
      'query': 'मेरी गेहूं की फसल में पीले पत्ते दिख रहे हैं',
      'response':
          'पीले पत्ते नाइट्रोजन की कमी या अधिक पानी के कारण हो सकते हैं। नाइट्रोजन युक्त उर्वरक डालें और जल निकासी सुधारें।',
      'timestamp': DateTime.now().subtract(const Duration(hours: 2)),
      'isBookmarked': true,
      'language': 'Hindi',
    },
    {
      'query': 'What is the best fertilizer for tomato plants?',
      'response':
          'For tomato plants, use a balanced NPK fertilizer (10-10-10) during early growth, then switch to high potassium fertilizer during fruiting stage.',
      'timestamp': DateTime.now().subtract(const Duration(days: 1)),
      'isBookmarked': false,
      'language': 'English',
    },
    {
      'query': 'ಬೆಳೆಗೆ ನೀರು ಎಷ್ಟು ಬಾರಿ ಕೊಡಬೇಕು?',
      'response':
          'ಬೆಳೆಯ ಪ್ರಕಾರ ಮತ್ತು ಹವಾಮಾನಕ್ಕೆ ತಕ್ಕಂತೆ ನೀರು ಕೊಡಬೇಕು। ಸಾಮಾನ್ಯವಾಗಿ ಬೇಸಿಗೆಯಲ್ಲಿ ದಿನಕ್ಕೆ 1-2 ಬಾರಿ ಮತ್ತು ಚಳಿಗಾಲದಲ್ಲಿ 2-3 ದಿನಕ್ಕೊಮ್ಮೆ.',
      'timestamp': DateTime.now().subtract(const Duration(days: 3)),
      'isBookmarked': true,
      'language': 'Kannada',
    },
  ];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeInOut,
    ));

    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  void _handleTranscriptionComplete(String transcription) {
    setState(() {
      _currentQuery = transcription;
      _showResponse = true;
      _showHistory = false;
    });

    // Add to conversation history
    _conversationHistory.insert(0, {
      'query': transcription,
      'response': '', // Will be filled by AI response widget
      'timestamp': DateTime.now(),
      'isBookmarked': false,
      'language': _detectLanguage(transcription),
    });

    // Provide haptic feedback
    HapticFeedback.lightImpact();
  }

  void _handleRecordingStart() {
    setState(() {
      _showResponse = false;
      _showHistory = false;
    });
    HapticFeedback.mediumImpact();
  }

  void _handleRecordingStop() {
    HapticFeedback.lightImpact();
  }

  void _handleFollowUpQuestion(String question) {
    setState(() {
      _currentQuery = question;
      _showResponse = true;
    });
  }

  void _handlePlayAudio() {
    HapticFeedback.selectionClick();
    // Audio playback handled in AI response widget
  }

  void _handleQuerySelect(String query) {
    setState(() {
      _currentQuery = query;
      _showResponse = true;
      _showHistory = false;
    });
  }

  void _handleBookmarkToggle(int index) {
    setState(() {
      _conversationHistory[index]['isBookmarked'] =
          !(_conversationHistory[index]['isBookmarked'] as bool);
    });
    HapticFeedback.selectionClick();
  }

  void _toggleHistoryView() {
    setState(() {
      _showHistory = !_showHistory;
      if (_showHistory) {
        _showResponse = false;
      }
    });
  }

  void _closeScreen() {
    _slideController.reverse().then((_) {
      Navigator.of(context).pop();
    });
  }

  void _navigateToScreen(String route) {
    Navigator.pushNamed(context, route);
  }

  String _detectLanguage(String text) {
    // Simple language detection based on script
    if (RegExp(r'[\u0900-\u097F]').hasMatch(text)) return 'Hindi';
    if (RegExp(r'[\u0C80-\u0CFF]').hasMatch(text)) return 'Kannada';
    if (RegExp(r'[\u0B80-\u0BFF]').hasMatch(text)) return 'Tamil';
    if (RegExp(r'[\u0C00-\u0C7F]').hasMatch(text)) return 'Telugu';
    if (RegExp(r'[\u0980-\u09FF]').hasMatch(text)) return 'Bengali';
    if (RegExp(r'[\u0A00-\u0A7F]').hasMatch(text)) return 'Punjabi';
    return 'English';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppTheme.lightTheme.colorScheme.surface.withValues(alpha: 0.95),
      body: SlideTransition(
        position: _slideAnimation,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.lightTheme.colorScheme.primaryContainer
                    .withValues(alpha: 0.1),
                AppTheme.lightTheme.colorScheme.surface,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Header
                _buildHeader(),

                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                        SizedBox(height: 4.h),

                        // Voice Recording Widget
                        if (!_showResponse && !_showHistory)
                          VoiceRecordingWidget(
                            onTranscriptionComplete:
                                _handleTranscriptionComplete,
                            onRecordingStart: _handleRecordingStart,
                            onRecordingStop: _handleRecordingStop,
                          ),

                        // AI Response Widget
                        if (_showResponse && _currentQuery.isNotEmpty)
                          AiResponseWidget(
                            query: _currentQuery,
                            onFollowUpQuestion: _handleFollowUpQuestion,
                            onPlayAudio: _handlePlayAudio,
                          ),

                        // Conversation History Widget
                        if (_showHistory)
                          ConversationHistoryWidget(
                            conversations: _conversationHistory,
                            onQuerySelect: _handleQuerySelect,
                            onBookmarkToggle: _handleBookmarkToggle,
                          ),

                        SizedBox(height: 4.h),
                      ],
                    ),
                  ),
                ),

                // Bottom Navigation
                _buildBottomNavigation(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: _closeScreen,
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primaryContainer
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: 'keyboard_arrow_down',
                color: AppTheme.lightTheme.colorScheme.primary,
                size: 6.w,
              ),
            ),
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Voice Query',
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Ask AgriAssist AI in your language',
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: _toggleHistoryView,
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                color: _showHistory
                    ? AppTheme.lightTheme.colorScheme.primary
                    : AppTheme.lightTheme.colorScheme.primaryContainer
                        .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: CustomIconWidget(
                iconName: 'history',
                color: _showHistory
                    ? AppTheme.lightTheme.colorScheme.onPrimary
                    : AppTheme.lightTheme.colorScheme.primary,
                size: 5.w,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color:
                AppTheme.lightTheme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavButton(
            icon: 'language',
            label: 'Language',
            onTap: () => _navigateToScreen('/language-selection'),
          ),
          _buildNavButton(
            icon: 'camera_alt',
            label: 'Camera',
            onTap: () => _navigateToScreen('/camera-diagnosis'),
          ),
          _buildNavButton(
            icon: 'wb_sunny',
            label: 'Weather',
            onTap: () => _navigateToScreen('/weather-insights'),
          ),
          _buildNavButton(
            icon: 'person',
            label: 'Profile',
            onTap: () => _navigateToScreen('/profile-settings'),
          ),
        ],
      ),
    );
  }

  Widget _buildNavButton({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomIconWidget(
              iconName: icon,
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 5.w,
            ),
            SizedBox(height: 0.5.h),
            Text(
              label,
              style: AppTheme.lightTheme.textTheme.labelSmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
