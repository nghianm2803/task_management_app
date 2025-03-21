import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;

  // Gray color
  static const Color gray25 = Color(0xFFFCFCFD);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF2F4F7);
  static const Color gray200 = Color(0xFFE4E7EC);
  static const Color gray300 = Color(0xFFD0D5DD);
  static const Color gray400 = Color(0xFF98A2B3);
  static const Color gray500 = Color(0xFF667085);
  static const Color gray600 = Color(0xFF475467);
  static const Color gray700 = Color(0xFF344054);
  static const Color gray800 = Color(0xFF1D2939);
  static const Color gray900 = Color(0xFF101828);

  // Brand 01
  static const Color green25 = Color(0xFFF7FFF7);
  static const Color green50 = Color(0xFFF4FFF4);
  static const Color green100 = Color(0xFFE7FFE8);
  static const Color green200 = Color(0xFFADF3A1);
  static const Color green250 = Color(0xFFC2EDC8);
  static const Color green300 = Color(0xFF64B657);
  static const Color green400 = Color(0xFF009230);
  static const Color green500 = Color(0xFF018701);
  static const Color green600 = Color(0xFF026434);
  static const Color green700 = Color(0xFF02582D);
  static const Color green800 = Color(0xFF01532A);
  static const Color green900 = Color(0xFF002D16);

  // Brand 02
  static const Color red25 = Color(0xFFFEF0F1);
  static const Color red50 = Color(0xFFFFE4E5);
  static const Color red100 = Color(0xFFFFC2C5);
  static const Color red200 = Color(0xFFFF9097);
  static const Color red300 = Color(0xFFFF5B64);
  static const Color red400 = Color(0xFFEA3B45);
  static const Color red500 = Color(0xFFD71E28);
  static const Color red600 = Color(0xFFB10710);
  static const Color red700 = Color(0xFF890108);
  static const Color red800 = Color(0xFF730308);
  static const Color red900 = Color(0xFF4B0306);

  // Success
  static const Color success25 = Color(0xFFF6FEF9);
  static const Color success50 = Color(0xFFECFDF3);
  static const Color success100 = Color(0xFFD1FADF);
  static const Color success200 = Color(0xFFA6F4C5);
  static const Color success300 = Color(0xFF6CE9A6);
  static const Color success400 = Color(0xFF32D583);
  static const Color success500 = Color(0xFF12B76A);
  static const Color success600 = Color(0xFF039855);
  static const Color success700 = Color(0xFF027A48);
  static const Color success800 = Color(0xFF05603A);
  static const Color success900 = Color(0xFF054F31);

  // Blue color
  static const Color blue25 = Color(0xFFF5FAFF);
  static const Color blue50 = Color(0xFFEFF8FF);
  static const Color blue100 = Color(0xFFD1E9FF);
  static const Color blue200 = Color(0xFFB2DDFF);
  static const Color blue300 = Color(0xFF84CAFF);
  static const Color blue400 = Color(0xFF53B1FD);
  static const Color blue500 = Color(0xFF2E90FA);
  static const Color blue600 = Color(0xFF1570EF);
  static const Color blue700 = Color(0xFF175CD3);
  static const Color blue800 = Color(0xFF1849A9);
  static const Color blue900 = Color(0xFF194185);

  // Orange color
  static const Color orange25 = Color(0xFFFFFAF5);
  static const Color orange50 = Color(0xFFFFF6ED);
  static const Color orange100 = Color(0xFFFFEAD5);
  static const Color orange200 = Color(0xFFFDDCAB);
  static const Color orange300 = Color(0xFFFEB273);
  static const Color orange400 = Color(0xFFFD853A);
  static const Color orange500 = Color(0xFFFB6514);
  static const Color orange600 = Color(0xFFEC4A0A);
  static const Color orange700 = Color(0xFFC4320A);
  static const Color orange800 = Color(0xFF9C2A10);
  static const Color orange900 = Color(0xFF7E2410);
}

abstract class GradientColors {
  static const LinearGradient gradientGreen = LinearGradient(
    colors: [
      Color(0xFF117B34),
      Color(0xFF17A948),
    ],
    stops: [0.0, 1.0],
    begin: Alignment(0.95, 0.36),
    end: Alignment(0.13, 0.33),
  );
}
