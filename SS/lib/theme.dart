import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LightModeColors {
  static const lightPrimary = Color(0xFFE91E63); // Festive pink
  static const lightOnPrimary = Color(0xFFFFFFFF);
  static const lightPrimaryContainer = Color(0xFFFFF3F7);
  static const lightOnPrimaryContainer = Color(0xFF2D1B21);
  static const lightSecondary = Color(0xFFFF9800); // Festive orange
  static const lightOnSecondary = Color(0xFFFFFFFF);
  static const lightTertiary = Color(0xFF9C27B0); // Purple
  static const lightOnTertiary = Color(0xFFFFFFFF);
  static const lightError = Color(0xFFE17055);
  static const lightOnError = Color(0xFFFFFFFF);
  static const lightErrorContainer = Color(0xFFFDCB6E);
  static const lightOnErrorContainer = Color(0xFF2D3436);
  static const lightInversePrimary = Color(0xFFFF4081);
  static const lightShadow = Color(0xFF000000);
  static const lightSurface = Color(0xFFFFFBFF);
  static const lightOnSurface = Color(0xFF1C1B1F);
  static const lightAppBarBackground = Color(0xFFFFFFFF);
  
  // Gradient colors - Festive gradients
  static const gradientStart = Color(0xFFE91E63); // Pink to Orange
  static const gradientEnd = Color(0xFFFF9800);
  static const accentGradientStart = Color(0xFF9C27B0); // Purple to Pink
  static const accentGradientEnd = Color(0xFFE91E63);
  static const splashGradientStart = Color(0xFFFFE0B2); // Light festive gradient
  static const splashGradientEnd = Color(0xFFFFF3E0);
}

class DarkModeColors {
  static const darkPrimary = Color(0xFFFF4081); // Bright festive pink for dark mode
  static const darkOnPrimary = Color(0xFF2D1B21);
  static const darkPrimaryContainer = Color(0xFFAD1457);
  static const darkOnPrimaryContainer = Color(0xFFFFFFFF);
  static const darkSecondary = Color(0xFFFFB74D); // Warm orange for dark mode
  static const darkOnSecondary = Color(0xFF2D2317);
  static const darkTertiary = Color(0xFFBA68C8); // Light purple
  static const darkOnTertiary = Color(0xFF2D1C30);
  static const darkError = Color(0xFFFAB1A0);
  static const darkOnError = Color(0xFF2D3436);
  static const darkErrorContainer = Color(0xFFFDCB6E);
  static const darkOnErrorContainer = Color(0xFF2D3436);
  static const darkInversePrimary = Color(0xFFE91E63);
  static const darkShadow = Color(0xFF000000);
  static const darkSurface = Color(0xFF1C1B1F);
  static const darkOnSurface = Color(0xFFE6E1E5);
  static const darkAppBarBackground = Color(0xFF2D1B21);
  
  // Gradient colors - Festive gradients for dark mode
  static const gradientStart = Color(0xFFFF4081); // Pink to Orange
  static const gradientEnd = Color(0xFFFFB74D);
  static const accentGradientStart = Color(0xFFBA68C8); // Purple to Pink
  static const accentGradientEnd = Color(0xFFFF4081);
  static const splashGradientStart = Color(0xFF4A2C3A); // Dark festive gradient
  static const splashGradientEnd = Color(0xFF3E2723);
}

class FontSizes {
  static const double displayLarge = 57.0;
  static const double displayMedium = 45.0;
  static const double displaySmall = 36.0;
  static const double headlineLarge = 32.0;
  static const double headlineMedium = 28.0;
  static const double headlineSmall = 24.0;
  static const double titleLarge = 22.0;
  static const double titleMedium = 18.0;
  static const double titleSmall = 16.0;
  static const double labelLarge = 16.0;
  static const double labelMedium = 14.0;
  static const double labelSmall = 12.0;
  static const double bodyLarge = 16.0;
  static const double bodyMedium = 14.0;
  static const double bodySmall = 12.0;
}

ThemeData get lightTheme => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.light(
    primary: LightModeColors.lightPrimary,
    onPrimary: LightModeColors.lightOnPrimary,
    primaryContainer: LightModeColors.lightPrimaryContainer,
    onPrimaryContainer: LightModeColors.lightOnPrimaryContainer,
    secondary: LightModeColors.lightSecondary,
    onSecondary: LightModeColors.lightOnSecondary,
    tertiary: LightModeColors.lightTertiary,
    onTertiary: LightModeColors.lightOnTertiary,
    error: LightModeColors.lightError,
    onError: LightModeColors.lightOnError,
    errorContainer: LightModeColors.lightErrorContainer,
    onErrorContainer: LightModeColors.lightOnErrorContainer,
    inversePrimary: LightModeColors.lightInversePrimary,
    shadow: LightModeColors.lightShadow,
    surface: LightModeColors.lightSurface,
    onSurface: LightModeColors.lightOnSurface,
  ),
  brightness: Brightness.light,
  appBarTheme: AppBarTheme(
    backgroundColor: LightModeColors.lightAppBarBackground,
    foregroundColor: LightModeColors.lightOnSurface,
    elevation: 0,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: LightModeColors.lightOnSurface,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightModeColors.lightPrimary,
      foregroundColor: LightModeColors.lightOnPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: FontSizes.displayLarge,
      fontWeight: FontWeight.w700,
      color: LightModeColors.lightOnSurface,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: FontSizes.displayMedium,
      fontWeight: FontWeight.w600,
      color: LightModeColors.lightOnSurface,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: FontSizes.displaySmall,
      fontWeight: FontWeight.w600,
      color: LightModeColors.lightOnSurface,
    ),
    headlineLarge: GoogleFonts.poppins(
      fontSize: FontSizes.headlineLarge,
      fontWeight: FontWeight.w700,
      color: LightModeColors.lightOnSurface,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: FontSizes.headlineMedium,
      fontWeight: FontWeight.w600,
      color: LightModeColors.lightOnSurface,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: FontSizes.headlineSmall,
      fontWeight: FontWeight.w600,
      color: LightModeColors.lightOnSurface,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: FontSizes.titleLarge,
      fontWeight: FontWeight.w600,
      color: LightModeColors.lightOnSurface,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: FontSizes.titleMedium,
      fontWeight: FontWeight.w600,
      color: LightModeColors.lightOnSurface,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: FontSizes.titleSmall,
      fontWeight: FontWeight.w500,
      color: LightModeColors.lightOnSurface,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: FontSizes.labelLarge,
      fontWeight: FontWeight.w500,
      color: LightModeColors.lightOnSurface,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: FontSizes.labelMedium,
      fontWeight: FontWeight.w500,
      color: LightModeColors.lightOnSurface,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: FontSizes.labelSmall,
      fontWeight: FontWeight.w500,
      color: LightModeColors.lightOnSurface,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: FontSizes.bodyLarge,
      fontWeight: FontWeight.normal,
      color: LightModeColors.lightOnSurface,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: FontSizes.bodyMedium,
      fontWeight: FontWeight.normal,
      color: LightModeColors.lightOnSurface,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: FontSizes.bodySmall,
      fontWeight: FontWeight.normal,
      color: LightModeColors.lightOnSurface,
    ),
  ),
);

ThemeData get darkTheme => ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.dark(
    primary: DarkModeColors.darkPrimary,
    onPrimary: DarkModeColors.darkOnPrimary,
    primaryContainer: DarkModeColors.darkPrimaryContainer,
    onPrimaryContainer: DarkModeColors.darkOnPrimaryContainer,
    secondary: DarkModeColors.darkSecondary,
    onSecondary: DarkModeColors.darkOnSecondary,
    tertiary: DarkModeColors.darkTertiary,
    onTertiary: DarkModeColors.darkOnTertiary,
    error: DarkModeColors.darkError,
    onError: DarkModeColors.darkOnError,
    errorContainer: DarkModeColors.darkErrorContainer,
    onErrorContainer: DarkModeColors.darkOnErrorContainer,
    inversePrimary: DarkModeColors.darkInversePrimary,
    shadow: DarkModeColors.darkShadow,
    surface: DarkModeColors.darkSurface,
    onSurface: DarkModeColors.darkOnSurface,
  ),
  brightness: Brightness.dark,
  appBarTheme: AppBarTheme(
    backgroundColor: DarkModeColors.darkAppBarBackground,
    foregroundColor: DarkModeColors.darkOnSurface,
    elevation: 0,
    titleTextStyle: GoogleFonts.poppins(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      color: DarkModeColors.darkOnSurface,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: DarkModeColors.darkPrimary,
      foregroundColor: DarkModeColors.darkOnPrimary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      textStyle: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: GoogleFonts.poppins(
      fontSize: FontSizes.displayLarge,
      fontWeight: FontWeight.w700,
      color: DarkModeColors.darkOnSurface,
    ),
    displayMedium: GoogleFonts.poppins(
      fontSize: FontSizes.displayMedium,
      fontWeight: FontWeight.w600,
      color: DarkModeColors.darkOnSurface,
    ),
    displaySmall: GoogleFonts.poppins(
      fontSize: FontSizes.displaySmall,
      fontWeight: FontWeight.w600,
      color: DarkModeColors.darkOnSurface,
    ),
    headlineLarge: GoogleFonts.poppins(
      fontSize: FontSizes.headlineLarge,
      fontWeight: FontWeight.w700,
      color: DarkModeColors.darkOnSurface,
    ),
    headlineMedium: GoogleFonts.poppins(
      fontSize: FontSizes.headlineMedium,
      fontWeight: FontWeight.w600,
      color: DarkModeColors.darkOnSurface,
    ),
    headlineSmall: GoogleFonts.poppins(
      fontSize: FontSizes.headlineSmall,
      fontWeight: FontWeight.w600,
      color: DarkModeColors.darkOnSurface,
    ),
    titleLarge: GoogleFonts.poppins(
      fontSize: FontSizes.titleLarge,
      fontWeight: FontWeight.w600,
      color: DarkModeColors.darkOnSurface,
    ),
    titleMedium: GoogleFonts.poppins(
      fontSize: FontSizes.titleMedium,
      fontWeight: FontWeight.w600,
      color: DarkModeColors.darkOnSurface,
    ),
    titleSmall: GoogleFonts.poppins(
      fontSize: FontSizes.titleSmall,
      fontWeight: FontWeight.w500,
      color: DarkModeColors.darkOnSurface,
    ),
    labelLarge: GoogleFonts.poppins(
      fontSize: FontSizes.labelLarge,
      fontWeight: FontWeight.w500,
      color: DarkModeColors.darkOnSurface,
    ),
    labelMedium: GoogleFonts.poppins(
      fontSize: FontSizes.labelMedium,
      fontWeight: FontWeight.w500,
      color: DarkModeColors.darkOnSurface,
    ),
    labelSmall: GoogleFonts.poppins(
      fontSize: FontSizes.labelSmall,
      fontWeight: FontWeight.w500,
      color: DarkModeColors.darkOnSurface,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: FontSizes.bodyLarge,
      fontWeight: FontWeight.normal,
      color: DarkModeColors.darkOnSurface,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: FontSizes.bodyMedium,
      fontWeight: FontWeight.normal,
      color: DarkModeColors.darkOnSurface,
    ),
    bodySmall: GoogleFonts.inter(
      fontSize: FontSizes.bodySmall,
      fontWeight: FontWeight.normal,
      color: DarkModeColors.darkOnSurface,
    ),
  ),
);