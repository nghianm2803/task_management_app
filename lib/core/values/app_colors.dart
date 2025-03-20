import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color transparent = Colors.transparent;
  static const Color transparentBlack = Color(0x80000000);

  // Draft color
  static const Color gray8F8F8F = Color(0xFF8F8F8F);
  static const Color grayD4D4D4 = Color(0xFFD4D4D4);

  // Base color confirmed
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

  // Error
  static const Color error25 = Color(0xFFFFFBFA);
  static const Color error50 = Color(0xFFFEF3F2);
  static const Color error100 = Color(0xFFFEE4E2);
  static const Color error200 = Color(0xFFFECDCA);
  static const Color error300 = Color(0xFFFDA29B);
  static const Color error400 = Color(0xFFF97066);
  static const Color error500 = Color(0xFFF04438);
  static const Color error600 = Color(0xFFD92D20);
  static const Color error700 = Color(0xFFB42318);
  static const Color error800 = Color(0xFF912018);
  static const Color error900 = Color(0xFF7A271A);

  // Warning
  static const Color warning25 = Color(0xFFFFFCF5);
  static const Color warning50 = Color(0xFFFFFAEB);
  static const Color warning100 = Color(0xFFFEF0C7);
  static const Color warning200 = Color(0xFFFEDF89);
  static const Color warning300 = Color(0xFFFEC84B);
  static const Color warning400 = Color(0xFFFDB022);
  static const Color warning500 = Color(0xFFF79009);
  static const Color warning600 = Color(0xFFDC6803);
  static const Color warning700 = Color(0xFFB54708);
  static const Color warning800 = Color(0xFF93370D);
  static const Color warning900 = Color(0xFF7A2E0E);

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

  // Blue light color
  static const Color blueLight25 = Color(0xFFF5FBFF);
  static const Color blueLight50 = Color(0xFFF0F9FF);
  static const Color blueLight100 = Color(0xFFE0F2FE);
  static const Color blueLight200 = Color(0xFFB9E6FE);
  static const Color blueLight300 = Color(0xFF7CD4FD);
  static const Color blueLight400 = Color(0xFF36BFFA);
  static const Color blueLight500 = Color(0xFF0BA5EC);
  static const Color blueLight600 = Color(0xFF0086C9);
  static const Color blueLight700 = Color(0xFF026AA2);
  static const Color blueLight800 = Color(0xFF065986);
  static const Color blueLight900 = Color(0xFF0B4A6F);
  static const Color blueLight1000 = Color(0xFF0068FE);

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

  // Purple color
  static const Color purple25 = Color(0xFFFAFAFF);
  static const Color purple50 = Color(0xFFF4F3FF);
  static const Color purple100 = Color(0xFFEBE9FE);
  static const Color purple200 = Color(0xFFD9D6FE);
  static const Color purple300 = Color(0xFFBDB4FE);
  static const Color purple400 = Color(0xFF9B8AFB);
  static const Color purple500 = Color(0xFF7A5AF8);
  static const Color purple600 = Color(0xFF6938EF);
  static const Color purple700 = Color(0xFF5925DC);
  static const Color purple800 = Color(0xFF4A1FB8);
  static const Color purple900 = Color(0xFF3E1C96);

  // Pink color
  static const Color pink25 = Color(0xFFFEF6FB);
  static const Color pink50 = Color(0xFFFDF2FA);
  static const Color pink100 = Color(0xFFFCE7F6);
  static const Color pink200 = Color(0xFFFCCEEE);
  static const Color pink300 = Color(0xFFFAA7E0);
  static const Color pink400 = Color(0xFFF670C7);
  static const Color pink500 = Color(0xFFEE46BC);
  static const Color pink600 = Color(0xFFDD2590);
  static const Color pink700 = Color(0xFFC11574);
  static const Color pink800 = Color(0xFF9E165F);
  static const Color pink900 = Color(0xFF851651);

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
  static const LinearGradient linerBackgroundGreen1 = LinearGradient(
    colors: [
      Color(0xFFE9FCED),
      Color(0xFFFFFFFF),
    ],
    stops: [0.0, 1.0],
    begin: Alignment(0.95, 0.36),
    end: Alignment(0.13, 0.33),
  );

  static const LinearGradient linerBackgroundGreen2 = LinearGradient(
    colors: [
      Color(0xFFD6FBDA),
      Color(0xFFF6FFF7),
    ],
    stops: [0.0, 1.0],
    begin: Alignment(0.95, 0.36),
    end: Alignment(0.13, 0.33),
  );

  static const LinearGradient gradientRose = LinearGradient(
    colors: [
      Color(0xFFFFDEE3),
      Color(0xFFF6F7F9),
    ],
    stops: [0.0, 1.0],
    begin: Alignment(0.95, 0.36),
    end: Alignment(0.13, 0.33),
  );

  static const LinearGradient gradientRed = LinearGradient(
    colors: [
      Color(0xFFED9147),
      Color(0xFFEF1235),
    ],
    stops: [0.0, 1.0],
    begin: Alignment(0.95, 0.36),
    end: Alignment(0.13, 0.33),
  );

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
