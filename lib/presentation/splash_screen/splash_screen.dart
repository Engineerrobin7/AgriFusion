import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../core/app_export.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoAnimationController;
  late AnimationController _textAnimationController;
  late Animation<double> _logoScaleAnimation;
  late Animation<double> _logoFadeAnimation;
  late Animation<double> _textFadeAnimation;

  bool _isInitializing = true;
  String _initializationText = 'Initializing AgriFusion...';

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _startInitialization();
  }

  void _setupAnimations() {
    // Logo animation controller
    _logoAnimationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    // Text animation controller
    _textAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Logo scale animation (subtle entrance effect)
    _logoScaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: Curves.elasticOut,
    ));

    // Logo fade animation
    _logoFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoAnimationController,
      curve: const Interval(0.0, 0.8, curve: Curves.easeInOut),
    ));

    // Text fade animation
    _textFadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _textAnimationController,
      curve: Curves.easeInOut,
    ));

    // Start logo animation
    _logoAnimationController.forward();

    // Start text animation after a delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) {
        _textAnimationController.forward();
      }
    });
  }

  void _startInitialization() async {
    // Simulate initialization process with realistic steps
    await _performInitializationSteps();

    if (mounted) {
      // Navigate based on user state
      await _navigateToNextScreen();
    }
  }

  Future<void> _performInitializationSteps() async {
    final steps = [
      'Loading language packs...',
      'Checking network connectivity...',
      'Validating user session...',
      'Preparing agricultural data...',
      'Ready to grow!',
    ];

    for (int i = 0; i < steps.length; i++) {
      if (mounted) {
        setState(() {
          _initializationText = steps[i];
        });

        // Realistic delay for each step
        await Future.delayed(Duration(milliseconds: 600 + (i * 100)));
      }
    }

    setState(() {
      _isInitializing = false;
    });

    // Brief pause before navigation
    await Future.delayed(const Duration(milliseconds: 500));
  }

  Future<void> _navigateToNextScreen() async {
    // For now, navigate to language selection as the first screen
    // This can be modified to check user authentication status
    // and navigate to appropriate screen
    Navigator.of(context).pushReplacementNamed(AppRoutes.languageSelection);
  }

  @override
  void dispose() {
    _logoAnimationController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: _buildBackgroundDecoration(),
        child: SafeArea(
          child: Column(
            children: [
              // Top spacing
              SizedBox(height: 10.h),

              // Logo section
              Expanded(
                flex: 3,
                child: _buildLogoSection(),
              ),

              // Loading section
              Expanded(
                flex: 1,
                child: _buildLoadingSection(),
              ),

              // Version info
              _buildVersionInfo(),

              // Bottom spacing
              SizedBox(height: 4.h),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBackgroundDecoration() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: const [0.0, 0.4, 0.8, 1.0],
        colors: [
          const Color(0xFF4CAF50).withValues(alpha: 0.1), // Light green
          const Color(0xFF2E7D32).withValues(alpha: 0.05), // Darker green
          const Color(0xFFF57C00).withValues(alpha: 0.03), // Subtle amber
          Theme.of(context).scaffoldBackgroundColor,
        ],
      ),
    );
  }

  Widget _buildLogoSection() {
    return AnimatedBuilder(
      animation: _logoAnimationController,
      builder: (context, child) {
        return Transform.scale(
          scale: _logoScaleAnimation.value,
          child: Opacity(
            opacity: _logoFadeAnimation.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main logo
                Container(
                  width: 25.w,
                  height: 25.w,
                  padding: EdgeInsets.all(4.w),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(5.w),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context)
                            .colorScheme
                            .primary
                            .withValues(alpha: 0.2),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: SvgPicture.asset(
                    'assets/images/img_app_logo.svg',
                    width: 15.w,
                    height: 15.w,
                    colorFilter: ColorFilter.mode(
                      Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),

                SizedBox(height: 4.h),

                // App name
                Text(
                  'AgriFusion',
                  style: GoogleFonts.poppins(
                    fontSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: 1.2,
                  ),
                ),

                SizedBox(height: 1.h),

                // Tagline
                Text(
                  'Growing Smart Agriculture',
                  style: GoogleFonts.openSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.7),
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoadingSection() {
    return AnimatedBuilder(
      animation: _textAnimationController,
      builder: (context, child) {
        return Opacity(
          opacity: _textFadeAnimation.value,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Loading indicator
              if (_isInitializing) ...[
                SizedBox(
                  width: 8.w,
                  height: 8.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
              ],

              // Initialization text
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: Text(
                  _initializationText,
                  key: ValueKey(_initializationText),
                  style: GoogleFonts.openSans(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                    letterSpacing: 0.3,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildVersionInfo() {
    return Positioned(
      bottom: 2.h,
      child: Text(
        'Version 1.0.0',
        style: GoogleFonts.roboto(
          fontSize: 10.sp,
          fontWeight: FontWeight.w400,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.4),
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}