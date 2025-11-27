import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class AiResponseWidget extends StatefulWidget {
  final String query;
  final Function(String) onFollowUpQuestion;
  final VoidCallback onPlayAudio;

  const AiResponseWidget({
    super.key,
    required this.query,
    required this.onFollowUpQuestion,
    required this.onPlayAudio,
  });

  @override
  State<AiResponseWidget> createState() => _AiResponseWidgetState();
}

class _AiResponseWidgetState extends State<AiResponseWidget>
    with TickerProviderStateMixin {
  bool _isGenerating = true;
  String _response = '';
  List<String> _followUpQuestions = [];
  bool _isPlayingAudio = false;
  late AnimationController _typingController;
  late Animation<double> _typingAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _generateResponse();
  }

  void _initializeAnimations() {
    _typingController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _typingAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _typingController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _typingController.dispose();
    super.dispose();
  }

  Future<void> _generateResponse() async {
    _typingController.repeat();

    // Simulate AI processing time
    await Future.delayed(const Duration(seconds: 3));

    final mockResponses = _getMockResponse(widget.query);

    setState(() {
      _isGenerating = false;
      _response = mockResponses['response'] as String;
      _followUpQuestions = mockResponses['followUp'] as List<String>;
    });

    _typingController.stop();
  }

  Map<String, dynamic> _getMockResponse(String query) {
    // Mock AI responses based on query content
    if (query.toLowerCase().contains('पीले पत्ते') ||
        query.toLowerCase().contains('yellow leaves')) {
      return {
        'response':
            '''पीले पत्ते आमतौर पर नाइट्रोजन की कमी या अधिक पानी के कारण होते हैं।

समाधान:
• नाइट्रोजन युक्त उर्वरक (यूरिया 20-25 किग्रा/एकड़) डालें
• पानी की मात्रा कम करें और जल निकासी सुधारें
• मिट्टी की जांच कराएं
• जिंक सल्फेट का छिड़काव करें (2 ग्राम/लीटर)

यदि समस्या बनी रहे तो स्थानीय कृषि विशेषज्ञ से संपर्क करें।''',
        'followUp': [
          'मिट्टी की जांच कैसे कराएं?',
          'नाइट्रोजन उर्वरक कब डालना चाहिए?',
          'जल निकासी कैसे सुधारें?'
        ]
      };
    } else if (query.toLowerCase().contains('fertilizer') ||
        query.toLowerCase().contains('wheat')) {
      return {
        'response': '''For wheat crop, use balanced fertilization:

Base Application (at sowing):
• DAP: 100-125 kg/acre
• Potash: 25-30 kg/acre

Top Dressing:
• Urea: 65-75 kg/acre (split in 2-3 doses)
• First dose: 20-25 days after sowing
• Second dose: 45-50 days after sowing

Micronutrients:
• Zinc Sulphate: 10-12 kg/acre
• Apply based on soil test results

Always conduct soil testing for precise recommendations.''',
        'followUp': [
          'When to apply first urea dose?',
          'How to conduct soil testing?',
          'Signs of nutrient deficiency in wheat?'
        ]
      };
    } else if (query.contains('ನೀರು') || query.contains('water')) {
      return {
        'response': '''ಬೆಳೆಗೆ ನೀರು ಕೊಡುವ ಸಮಯ ಮತ್ತು ಪ್ರಮಾಣ:

ಸಾಮಾನ್ಯ ನಿಯಮಗಳು:
• ಬೆಳಿಗ್ಗೆ 6-8 ಗಂಟೆ ಅಥವಾ ಸಂಜೆ 4-6 ಗಂಟೆಗೆ ನೀರು ಕೊಡಿ
• ಮಣ್ಣಿನ ತೇವಾಂಶ ಪರೀಕ್ಷಿಸಿ (2-3 ಇಂಚು ಆಳದಲ್ಲಿ)
• ಬೆಳೆಯ ಹಂತಕ್ಕೆ ತಕ್ಕಂತೆ ನೀರಿನ ಪ್ರಮಾಣ ಬದಲಾಯಿಸಿ

ಬೇಸಿಗೆಯಲ್ಲಿ: ದಿನಕ್ಕೆ 1-2 ಬಾರಿ
ಮಳೆಗಾಲದಲ್ಲಿ: ಅಗತ್ಯಕ್ಕೆ ತಕ್ಕಂತೆ
ಚಳಿಗಾಲದಲ್ಲಿ: 2-3 ದಿನಕ್ಕೊಮ್ಮೆ''',
        'followUp': [
          'ಮಣ್ಣಿನ ತೇವಾಂಶ ಹೇಗೆ ಪರೀಕ್ಷಿಸುವುದು?',
          'ಡ್ರಿಪ್ ಇರಿಗೇಷನ್ ಬಗ್ಗೆ ತಿಳಿಸಿ',
          'ನೀರಿನ ಕೊರತೆಯ ಲಕ್ಷಣಗಳು ಯಾವುವು?'
        ]
      };
    } else {
      return {
        'response':
            '''আপনার প্রশ্নের জন্য ধন্যবাদ। কৃষি সংক্রান্ত সমস্যার সমাধানের জন্য আমি এখানে আছি।

সাধারণ পরামর্শ:
• নিয়মিত মাটি পরীক্ষা করান
• সময়মতো সার প্রয়োগ করুন
• সেচের সঠিক ব্যবস্থাপনা করুন
• রোগ ও পোকামাকড়ের জন্য নিয়মিত পর্যবেক্ষণ করুন

আরও নির্দিষ্ট পরামর্শের জন্য আপনার ফসল ও সমস্যার বিস্তারিত বলুন।''',
        'followUp': [
          'মাটি পরীক্ষা কোথায় করাবো?',
          'জৈব সার সম্পর্কে জানতে চাই',
          'ফসলের রোগ চিহ্নিতকরণ'
        ]
      };
    }
  }

  void _toggleAudioPlayback() {
    setState(() => _isPlayingAudio = !_isPlayingAudio);
    widget.onPlayAudio();

    // Simulate audio playback
    if (_isPlayingAudio) {
      Future.delayed(const Duration(seconds: 5), () {
        if (mounted) {
          setState(() => _isPlayingAudio = false);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.w,
      margin: EdgeInsets.symmetric(vertical: 2.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI Response Header
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: CustomIconWidget(
                  iconName: 'psychology',
                  color: AppTheme.lightTheme.colorScheme.primary,
                  size: 5.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Text(
                  'AgriAssist AI Response',
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (!_isGenerating) ...[
                GestureDetector(
                  onTap: _toggleAudioPlayback,
                  child: Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: _isPlayingAudio
                          ? AppTheme.lightTheme.colorScheme.secondary
                          : AppTheme.lightTheme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.outline
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: CustomIconWidget(
                      iconName: _isPlayingAudio ? 'pause' : 'volume_up',
                      color: _isPlayingAudio
                          ? AppTheme.lightTheme.colorScheme.onSecondary
                          : AppTheme.lightTheme.colorScheme.secondary,
                      size: 4.w,
                    ),
                  ),
                ),
              ],
            ],
          ),

          SizedBox(height: 2.h),

          // Response Content
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: AppTheme.lightTheme.colorScheme.surface,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppTheme.lightTheme.colorScheme.outline
                    .withValues(alpha: 0.2),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.lightTheme.colorScheme.shadow,
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: _isGenerating
                ? _buildTypingIndicator()
                : _buildResponseContent(),
          ),

          // Follow-up Questions
          if (!_isGenerating && _followUpQuestions.isNotEmpty) ...[
            SizedBox(height: 3.h),
            Text(
              'Related Questions:',
              style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 1.h),
            Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              children: _followUpQuestions.map((question) {
                return GestureDetector(
                  onTap: () => widget.onFollowUpQuestion(question),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.primaryContainer
                          .withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: AppTheme.lightTheme.colorScheme.primary
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      question,
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return Row(
      children: [
        Text(
          'AI is analyzing your query',
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(width: 2.w),
        AnimatedBuilder(
          animation: _typingAnimation,
          builder: (context, child) {
            return Row(
              children: List.generate(3, (index) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.5.w),
                  width: 2.w,
                  height: 2.w,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.primary.withValues(
                      alpha: (_typingAnimation.value + index * 0.3) % 1.0,
                    ),
                    shape: BoxShape.circle,
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }

  Widget _buildResponseContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _response,
          style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
            height: 1.5,
          ),
        ),
        if (_isPlayingAudio) ...[
          SizedBox(height: 2.h),
          Row(
            children: [
              CustomIconWidget(
                iconName: 'graphic_eq',
                color: AppTheme.lightTheme.colorScheme.secondary,
                size: 4.w,
              ),
              SizedBox(width: 2.w),
              Text(
                'Playing audio response...',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.secondary,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
