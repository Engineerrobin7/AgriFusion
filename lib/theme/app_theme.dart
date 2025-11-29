import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that contains all theme configurations for the agricultural application.
class AppTheme {
  AppTheme._();

  // Agricultural color palette - Earth-Grounded Professional
  static const Color primaryLight =
      Color(0xFF2E7D32); // Deep agricultural green
  static const Color primaryVariantLight = Color(0xFF1B5E20);
  static const Color secondaryLight = Color(0xFFF57C00); // Warm amber
  static const Color secondaryVariantLight = Color(0xFFE65100);
  static const Color backgroundLight = Color(0xFFFAFAFA); // Soft off-white
  static const Color surfaceLight = Color(0xFFFFFFFF); // Pure white
  static const Color errorLight = Color(0xFFD32F2F); // Clear red
  static const Color successLight = Color(0xFF388E3C); // Confirmation green
  static const Color warningLight = Color(0xFFF9A825); // Golden yellow
  static const Color accentLight = Color(0xFF4CAF50); // Bright green for CTA
  static const Color onPrimaryLight = Color(0xFFFFFFFF);
  static const Color onSecondaryLight = Color(0xFFFFFFFF);
  static const Color onBackgroundLight =
      Color(0xFF212121); // High contrast dark gray
  static const Color onSurfaceLight = Color(0xFF212121);
  static const Color onErrorLight = Color(0xFFFFFFFF);

  static const Color primaryDark = Color(0xFF4CAF50);
  static const Color primaryVariantDark = Color(0xFF2E7D32);
  static const Color secondaryDark = Color(0xFFFFB74D);
  static const Color secondaryVariantDark = Color(0xFFF57C00);
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color errorDark = Color(0xFFEF5350);
  static const Color successDark = Color(0xFF66BB6A);
  static const Color warningDark = Color(0xFFFFCA28);
  static const Color accentDark = Color(0xFF81C784);
  static const Color onPrimaryDark = Color(0xFF000000);
  static const Color onSecondaryDark = Color(0xFF000000);
  static const Color onBackgroundDark = Color(0xFFFFFFFF);
  static const Color onSurfaceDark = Color(0xFFFFFFFF);
  static const Color onErrorDark = Color(0xFF000000);

  // Card and dialog colors
  static const Color cardLight = Color(0xFFFFFFFF);
  static const Color cardDark = Color(0xFF2D2D2D);
  static const Color dialogLight = Color(0xFFFFFFFF);
  static const Color dialogDark = Color(0xFF2D2D2D);

  // Shadow colors - Subtle elevation for outdoor visibility
  static const Color shadowLight = Color(0x0F000000); // 2dp shadows
  static const Color shadowMediumLight = Color(0x1A000000); // 4dp shadows
  static const Color shadowDark = Color(0x1FFFFFFF);
  static const Color shadowMediumDark = Color(0x2AFFFFFF);

  // Divider colors - Minimal borders
  static const Color dividerLight = Color(0x1F000000);
  static const Color dividerDark = Color(0x1FFFFFFF);

  // Text colors - Optimized for outdoor readability
  static const Color textPrimaryLight = Color(0xFF212121); // High contrast
  static const Color textSecondaryLight = Color(0xFF757575); // Medium gray
  static const Color textDisabledLight = Color(0x61000000); // 38% opacity

  static const Color textPrimaryDark = Color(0xFFFFFFFF);
  static const Color textSecondaryDark = Color(0xFFB0BEC5);
  static const Color textDisabledDark = Color(0x61FFFFFF);

  /// Light theme - Optimized for outdoor agricultural use
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: primaryLight,
      onPrimary: onPrimaryLight,
      primaryContainer: primaryVariantLight,
      onPrimaryContainer: onPrimaryLight,
      secondary: secondaryLight,
      onSecondary: onSecondaryLight,
      secondaryContainer: secondaryVariantLight,
      onSecondaryContainer: onSecondaryLight,
      tertiary: accentLight,
      onTertiary: onPrimaryLight,
      tertiaryContainer: accentLight.withValues(alpha: 0.1),
      onTertiaryContainer: primaryLight,
      error: errorLight,
      onError: onErrorLight,
      surface: surfaceLight,
      onSurface: onSurfaceLight,
      onSurfaceVariant: textSecondaryLight,
      outline: dividerLight,
      outlineVariant: dividerLight.withValues(alpha: 0.5),
      shadow: shadowLight,
      scrim: shadowLight,
      inverseSurface: surfaceDark,
      onInverseSurface: onSurfaceDark,
      inversePrimary: primaryDark,
    ),
    scaffoldBackgroundColor: backgroundLight,
    cardColor: cardLight,
    dividerColor: dividerLight,

    // AppBar theme - Clean and professional
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceLight,
      foregroundColor: textPrimaryLight,
      elevation: 2.0,
      shadowColor: shadowLight,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimaryLight,
      ),
      iconTheme: IconThemeData(color: textPrimaryLight, size: 24),
      actionsIconTheme: IconThemeData(color: textPrimaryLight, size: 24),
    ),

    // Card theme - Clean surfaces with subtle elevation
    cardTheme: CardTheme(
      color: cardLight,
      elevation: 2.0,
      shadowColor: shadowLight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.all(8.0),
    ),

    // Bottom navigation - Voice-first interaction support
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceLight,
      selectedItemColor: primaryLight,
      unselectedItemColor: textSecondaryLight,
      type: BottomNavigationBarType.fixed,
      elevation: 4.0,
      selectedLabelStyle: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // FAB theme - Prominent voice input button
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentLight,
      foregroundColor: onPrimaryLight,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),

    // Button themes - Large, tappable elements
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimaryLight,
        backgroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(120, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 2.0,
        textStyle: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(120, 48),
        side: const BorderSide(color: primaryLight, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryLight,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: const Size(88, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    // Typography - Optimized for agricultural content
    textTheme: _buildTextTheme(isLight: true),

    // Input decoration - Clear field definition
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceLight,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: dividerLight.withValues(alpha: 0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: dividerLight.withValues(alpha: 0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: primaryLight, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorLight, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorLight, width: 2.0),
      ),
      labelStyle: GoogleFonts.openSans(
        color: textSecondaryLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.openSans(
        color: textDisabledLight,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Switch theme
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return Colors.grey[300];
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight.withValues(alpha: 0.5);
        }
        return Colors.grey[400];
      }),
    ),

    // Checkbox theme
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(onPrimaryLight),
      side: const BorderSide(color: primaryLight, width: 2.0),
    ),

    // Radio theme
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryLight;
        }
        return textSecondaryLight;
      }),
    ),

    // Progress indicator theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryLight,
      linearTrackColor: Color(0xFFE8F5E8),
      circularTrackColor: Color(0xFFE8F5E8),
    ),

    // Slider theme
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryLight,
      thumbColor: primaryLight,
      overlayColor: primaryLight.withValues(alpha: 0.2),
      inactiveTrackColor: primaryLight.withValues(alpha: 0.3),
      trackHeight: 4.0,
    ),

    // Tab bar theme
    tabBarTheme: TabBarTheme(
      labelColor: primaryLight,
      unselectedLabelColor: textSecondaryLight,
      indicatorColor: primaryLight,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),

    // Tooltip theme
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: textPrimaryLight.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.openSans(
        color: surfaceLight,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),

    // SnackBar theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: textPrimaryLight,
      contentTextStyle: GoogleFonts.openSans(
        color: surfaceLight,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: accentLight,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
    ), dialogTheme: DialogThemeData(backgroundColor: dialogLight),
  );

  /// Dark theme - Adapted for low-light conditions
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: primaryDark,
      onPrimary: onPrimaryDark,
      primaryContainer: primaryVariantDark,
      onPrimaryContainer: onPrimaryDark,
      secondary: secondaryDark,
      onSecondary: onSecondaryDark,
      secondaryContainer: secondaryVariantDark,
      onSecondaryContainer: onSecondaryDark,
      tertiary: accentDark,
      onTertiary: onPrimaryDark,
      tertiaryContainer: accentDark.withValues(alpha: 0.2),
      onTertiaryContainer: accentDark,
      error: errorDark,
      onError: onErrorDark,
      surface: surfaceDark,
      onSurface: onSurfaceDark,
      onSurfaceVariant: textSecondaryDark,
      outline: dividerDark,
      outlineVariant: dividerDark.withValues(alpha: 0.5),
      shadow: shadowDark,
      scrim: shadowDark,
      inverseSurface: surfaceLight,
      onInverseSurface: onSurfaceLight,
      inversePrimary: primaryLight,
    ),
    scaffoldBackgroundColor: backgroundDark,
    cardColor: cardDark,
    dividerColor: dividerDark,
    appBarTheme: AppBarTheme(
      backgroundColor: surfaceDark,
      foregroundColor: textPrimaryDark,
      elevation: 2.0,
      shadowColor: shadowDark,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textPrimaryDark,
      ),
      iconTheme: IconThemeData(color: textPrimaryDark, size: 24),
      actionsIconTheme: IconThemeData(color: textPrimaryDark, size: 24),
    ),
    cardTheme: CardTheme(
      color: cardDark,
      elevation: 2.0,
      shadowColor: shadowDark,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      margin: const EdgeInsets.all(8.0),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: surfaceDark,
      selectedItemColor: primaryDark,
      unselectedItemColor: textSecondaryDark,
      type: BottomNavigationBarType.fixed,
      elevation: 4.0,
      selectedLabelStyle: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: accentDark,
      foregroundColor: onPrimaryDark,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: onPrimaryDark,
        backgroundColor: primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(120, 48),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 2.0,
        textStyle: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        minimumSize: const Size(120, 48),
        side: const BorderSide(color: primaryDark, width: 1.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        textStyle: GoogleFonts.openSans(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: primaryDark,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: const Size(88, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: GoogleFonts.openSans(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textTheme: _buildTextTheme(isLight: false),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: surfaceDark,
      filled: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: dividerDark.withValues(alpha: 0.5)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: dividerDark.withValues(alpha: 0.5)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: primaryDark, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorDark, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(color: errorDark, width: 2.0),
      ),
      labelStyle: GoogleFonts.openSans(
        color: textSecondaryDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: GoogleFonts.openSans(
        color: textDisabledDark,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return Colors.grey[600];
      }),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark.withValues(alpha: 0.5);
        }
        return Colors.grey[700];
      }),
    ),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return Colors.transparent;
      }),
      checkColor: WidgetStateProperty.all(onPrimaryDark),
      side: const BorderSide(color: primaryDark, width: 2.0),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryDark;
        }
        return textSecondaryDark;
      }),
    ),
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: primaryDark,
      linearTrackColor: Color(0xFF2E2E2E),
      circularTrackColor: Color(0xFF2E2E2E),
    ),
    sliderTheme: SliderThemeData(
      activeTrackColor: primaryDark,
      thumbColor: primaryDark,
      overlayColor: primaryDark.withValues(alpha: 0.2),
      inactiveTrackColor: primaryDark.withValues(alpha: 0.3),
      trackHeight: 4.0,
    ),
    tabBarTheme: TabBarTheme(
      labelColor: primaryDark,
      unselectedLabelColor: textSecondaryDark,
      indicatorColor: primaryDark,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      unselectedLabelStyle: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: textPrimaryDark.withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: GoogleFonts.openSans(
        color: surfaceDark,
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: textPrimaryDark,
      contentTextStyle: GoogleFonts.openSans(
        color: surfaceDark,
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
      actionTextColor: accentDark,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
    ), dialogTheme: DialogThemeData(backgroundColor: dialogDark),
  );

  /// Helper method to build text theme optimized for agricultural content
  static TextTheme _buildTextTheme({required bool isLight}) {
    final Color textPrimary = isLight ? textPrimaryLight : textPrimaryDark;
    final Color textSecondary =
        isLight ? textSecondaryLight : textSecondaryDark;
    final Color textDisabled = isLight ? textDisabledLight : textDisabledDark;

    return TextTheme(
      // Display styles - Poppins for headings
      displayLarge: GoogleFonts.poppins(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: -0.25,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        color: textPrimary,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        color: textPrimary,
      ),

      // Headline styles - Poppins for strong hierarchy
      headlineLarge: GoogleFonts.poppins(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: textPrimary,
      ),

      // Title styles - Poppins for section headers
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: textPrimary,
        letterSpacing: 0,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        letterSpacing: 0.15,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textPrimary,
        letterSpacing: 0.1,
      ),

      // Body styles - Open Sans for content readability
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: 0.5,
        height: 1.5,
      ),
      bodyMedium: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: textPrimary,
        letterSpacing: 0.25,
        height: 1.4,
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: textSecondary,
        letterSpacing: 0.4,
        height: 1.3,
      ),

      // Label styles - Roboto for captions and metadata
      labelLarge: GoogleFonts.roboto(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textPrimary,
        letterSpacing: 0.1,
      ),
      labelMedium: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textSecondary,
        letterSpacing: 0.5,
      ),
      labelSmall: GoogleFonts.roboto(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: textDisabled,
        letterSpacing: 0.5,
      ),
    );
  }

  /// Custom text styles for data display - Inter for numerical clarity
  static TextStyle dataLarge(bool isLight) => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: isLight ? textPrimaryLight : textPrimaryDark,
        letterSpacing: -0.5,
      );

  static TextStyle dataMedium(bool isLight) => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: isLight ? textPrimaryLight : textPrimaryDark,
        letterSpacing: -0.25,
      );

  static TextStyle dataSmall(bool isLight) => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: isLight ? textSecondaryLight : textSecondaryDark,
      );

  /// Custom colors for agricultural contexts
  static const Color cropHealthy = Color(0xFF4CAF50);
  static const Color cropWarning = Color(0xFFF9A825);
  static const Color cropDiseased = Color(0xFFD32F2F);
  static const Color weatherSunny = Color(0xFFFFB74D);
  static const Color weatherRainy = Color(0xFF42A5F5);
  static const Color weatherCloudy = Color(0xFF90A4AE);
}
