import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/download_progress_widget.dart';
import './widgets/language_card_widget.dart';
import './widgets/offline_language_widget.dart';

class LanguageSelection extends StatefulWidget {
  const LanguageSelection({super.key});

  @override
  State<LanguageSelection> createState() => _LanguageSelectionState();
}

class _LanguageSelectionState extends State<LanguageSelection>
    with TickerProviderStateMixin {
  String? selectedLanguageCode;
  bool isDownloading = false;
  bool isDownloadPaused = false;
  double downloadProgress = 0.0;
  String? downloadingLanguage;
  bool isOfflineMode = false;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Mock data for supported languages
  final List<Map<String, dynamic>> supportedLanguages = [
    {
      "code": "hi",
      "nativeName": "हिन्दी",
      "romanizedName": "Hindi",
      "greeting": "नमस्ते, मैं आपकी कृषि सहायता करूंगा",
      "flagUrl":
          "https://images.unsplash.com/photo-1643968398457-b92028558fe2",
      "semanticLabel":
          "Indian flag with saffron, white and green horizontal stripes and blue chakra in center",
      "isDownloaded": true,
    },
    {
      "code": "mr",
      "nativeName": "मराठी",
      "romanizedName": "Marathi",
      "greeting": "नमस्कार, मी तुमच्या शेतीसाठी मदत करेन",
      "flagUrl":
          "https://images.unsplash.com/photo-1643968398457-b92028558fe2",
      "semanticLabel":
          "Indian flag with saffron, white and green horizontal stripes and blue chakra in center",
      "isDownloaded": true,
    },
    {
      "code": "ta",
      "nativeName": "தமிழ்",
      "romanizedName": "Tamil",
      "greeting": "வணக்கம், நான் உங்கள் விவசாயத்திற்கு உதவுவேன்",
      "flagUrl":
          "https://images.unsplash.com/photo-1643968398457-b92028558fe2",
      "semanticLabel":
          "Indian flag with saffron, white and green horizontal stripes and blue chakra in center",
      "isDownloaded": false,
    },
    {
      "code": "te",
      "nativeName": "తెలుగు",
      "romanizedName": "Telugu",
      "greeting": "నమస్కారం, నేను మీ వ్యవసాయానికి సహాయం చేస్తాను",
      "flagUrl":
          "https://images.unsplash.com/photo-1643968398457-b92028558fe2",
      "semanticLabel":
          "Indian flag with saffron, white and green horizontal stripes and blue chakra in center",
      "isDownloaded": false,
    },
    {
      "code": "pa",
      "nativeName": "ਪੰਜਾਬੀ",
      "romanizedName": "Punjabi",
      "greeting": "ਸਤ ਸ੍ਰੀ ਅਕਾਲ, ਮੈਂ ਤੁਹਾਡੀ ਖੇਤੀ ਵਿੱਚ ਮਦਦ ਕਰਾਂਗਾ",
      "flagUrl":
          "https://images.unsplash.com/photo-1643968398457-b92028558fe2",
      "semanticLabel":
          "Indian flag with saffron, white and green horizontal stripes and blue chakra in center",
      "isDownloaded": true,
    },
    {
      "code": "en",
      "nativeName": "English",
      "romanizedName": "English",
      "greeting": "Hello, I will help you with your farming needs",
      "flagUrl":
          "https://images.unsplash.com/photo-1643968398457-b92028558fe2",
      "semanticLabel":
          "Indian flag with saffron, white and green horizontal stripes and blue chakra in center",
      "isDownloaded": true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    ));
    _fadeController.forward();
    _checkConnectivity();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _checkConnectivity() {
    // Simulate connectivity check
    setState(() {
      isOfflineMode = false; // Set to true to test offline mode
    });
  }

  void _selectLanguage(String languageCode) {
    if (!mounted) return;

    HapticFeedback.selectionClick();
    setState(() {
      selectedLanguageCode = languageCode;
    });

    final language = supportedLanguages.firstWhere(
      (lang) => lang['code'] == languageCode,
    );

    if (!(language['isDownloaded'] as bool)) {
      _startDownload(languageCode);
    }
  }

  void _playAudioPreview(String languageCode) {
    if (!mounted) return;

    HapticFeedback.lightImpact();
    // Simulate audio preview - in real app, this would use text-to-speech
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Playing audio preview for ${supportedLanguages.firstWhere((lang) => lang['code'] == languageCode)['romanizedName']}',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _startDownload(String languageCode) {
    if (!mounted) return;

    final language = supportedLanguages.firstWhere(
      (lang) => lang['code'] == languageCode,
    );

    setState(() {
      isDownloading = true;
      isDownloadPaused = false;
      downloadProgress = 0.0;
      downloadingLanguage = language['romanizedName'] as String;
    });

    _simulateDownload();
  }

  void _simulateDownload() {
    if (!mounted) return;

    const duration = Duration(milliseconds: 100);
    const increment = 0.02;

    Future.doWhile(() async {
      if (!mounted || isDownloadPaused) return false;

      await Future.delayed(duration);

      if (!mounted) return false;

      setState(() {
        downloadProgress += increment;
      });

      if (downloadProgress >= 1.0) {
        _completeDownload();
        return false;
      }

      return isDownloading && !isDownloadPaused;
    });
  }

  void _completeDownload() {
    if (!mounted) return;

    setState(() {
      isDownloading = false;
      downloadProgress = 0.0;
      downloadingLanguage = null;

      // Mark language as downloaded
      final languageIndex = supportedLanguages.indexWhere(
        (lang) => lang['code'] == selectedLanguageCode,
      );
      if (languageIndex != -1) {
        supportedLanguages[languageIndex]['isDownloaded'] = true;
      }
    });

    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Language pack downloaded successfully!'),
        backgroundColor: AppTheme.successLight,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _pauseDownload() {
    if (!mounted) return;

    setState(() {
      isDownloadPaused = true;
    });
  }

  void _resumeDownload() {
    if (!mounted) return;

    setState(() {
      isDownloadPaused = false;
    });
    _simulateDownload();
  }

  void _cancelDownload() {
    if (!mounted) return;

    setState(() {
      isDownloading = false;
      isDownloadPaused = false;
      downloadProgress = 0.0;
      downloadingLanguage = null;
      selectedLanguageCode = null;
    });
  }

  void _continueToApp() {
    if (selectedLanguageCode == null) return;

    HapticFeedback.mediumImpact();

    // Navigate to voice query screen
    Navigator.pushReplacementNamed(context, '/voice-query');
  }

  List<Map<String, dynamic>> get _availableLanguages {
    return supportedLanguages
        .where((lang) => lang['isDownloaded'] as bool)
        .toList();
  }

  List<Map<String, dynamic>> get _downloadableLanguages {
    return supportedLanguages
        .where((lang) => !(lang['isDownloaded'] as bool))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            children: [
              // Header
              _buildHeader(),

              // Main Content
              Expanded(
                child: isOfflineMode
                    ? _buildOfflineContent()
                    : _buildOnlineContent(),
              ),

              // Continue Button
              _buildContinueButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
      child: Column(
        children: [
          // App Logo and Title
          Row(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: CustomIconWidget(
                    iconName: 'agriculture',
                    color: Colors.white,
                    size: 7.w,
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AgriAssist',
                      style:
                          AppTheme.lightTheme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.lightTheme.primaryColor,
                      ),
                    ),
                    Text(
                      'AI-Powered Agricultural Advisory',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: AppTheme.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 3.h),

          // Title
          Text(
            'Choose Your Language',
            style: AppTheme.lightTheme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.textPrimaryLight,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 1.h),
          Text(
            'भाषा चुनें • ভাষা নির্বাচন করুন • மொழியைத் தேர்ந்தெடுக்கவும்',
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textSecondaryLight,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildOnlineContent() {
    return Column(
      children: [
        // Download Progress (if downloading)
        if (isDownloading && downloadingLanguage != null)
          DownloadProgressWidget(
            languageName: downloadingLanguage!,
            progress: downloadProgress,
            isDownloading: isDownloading,
            isPaused: isDownloadPaused,
            onPause: _pauseDownload,
            onResume: _resumeDownload,
            onCancel: _cancelDownload,
          ),

        // Language List
        Expanded(
          child: ListView.builder(
            padding: EdgeInsets.symmetric(vertical: 1.h),
            itemCount: supportedLanguages.length,
            itemBuilder: (context, index) {
              final language = supportedLanguages[index];
              final isSelected = selectedLanguageCode == language['code'];

              return LanguageCardWidget(
                language: language,
                isSelected: isSelected,
                onTap: () => _selectLanguage(language['code'] as String),
                onAudioPreview: () =>
                    _playAudioPreview(language['code'] as String),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildOfflineContent() {
    return SingleChildScrollView(
      child: OfflineLanguageWidget(
        availableLanguages: _availableLanguages,
        downloadableLanguages: _downloadableLanguages,
        selectedLanguageCode: selectedLanguageCode,
        onLanguageSelect: _selectLanguage,
        onDownloadRequest: (languageCode) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Connect to internet to download language packs'),
              duration: Duration(seconds: 3),
              behavior: SnackBarBehavior.floating,
            ),
          );
        },
      ),
    );
  }

  Widget _buildContinueButton() {
    final isEnabled = selectedLanguageCode != null && !isDownloading;
    final selectedLanguage = selectedLanguageCode != null
        ? supportedLanguages
            .firstWhere((lang) => lang['code'] == selectedLanguageCode)
        : null;
    final isLanguageReady =
        selectedLanguage != null && (selectedLanguage['isDownloaded'] as bool);

    return Container(
      padding: EdgeInsets.all(4.w),
      child: Column(
        children: [
          // Selected Language Info
          if (selectedLanguageCode != null && selectedLanguage != null)
            Container(
              padding: EdgeInsets.all(3.w),
              margin: EdgeInsets.only(bottom: 2.h),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color:
                      AppTheme.lightTheme.primaryColor.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'check_circle',
                    color: AppTheme.lightTheme.primaryColor,
                    size: 5.w,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Selected: ${selectedLanguage['nativeName']}',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: AppTheme.lightTheme.primaryColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (!isLanguageReady)
                          Text(
                            'Download in progress...',
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                              color: AppTheme.textSecondaryLight,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

          // Continue Button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: isEnabled && isLanguageReady ? _continueToApp : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: isEnabled && isLanguageReady
                    ? AppTheme.lightTheme.primaryColor
                    : AppTheme.textDisabledLight,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 2.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: isEnabled && isLanguageReady ? 2 : 0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isDownloading)
                    Container(
                      width: 5.w,
                      height: 5.w,
                      margin: EdgeInsets.only(right: 2.w),
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  Text(
                    isDownloading
                        ? 'Downloading...'
                        : isEnabled && isLanguageReady
                            ? 'Continue'
                            : 'Select a Language',
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  if (isEnabled && isLanguageReady && !isDownloading) ...[
                    SizedBox(width: 2.w),
                    CustomIconWidget(
                      iconName: 'arrow_forward',
                      color: Colors.white,
                      size: 5.w,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
