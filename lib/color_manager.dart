import 'package:flutter/material.dart';

class ColorsApp {
  static Color bgLight = HexColor.fromHex('#F5F7FA');
  static Color bgLight1 = HexColor.fromHex('#FBFBFB');
  static Color bgLight2 = HexColor.fromHex('#F5F7FA');
  static Color bgInput = HexColor.fromHex('#F1F5F8');
  static Color bgDisable = HexColor.fromHex('#EAEDF1');

  static Color greyPrimary = HexColor.fromHex('#2F3845');
  static Color greySecondary = HexColor.fromHex('#444F66');
  static Color greyTertiary = HexColor.fromHex('#909FB3');
  static Color greyIcon = HexColor.fromHex('#BCCCE0');
  static Color greyDivider = HexColor.fromHex('#DFE9F5');

  static Color blueBase = HexColor.fromHex('#3C73BD');
  static Color bluePrimary = HexColor.fromHex('#2265C6');
  static Color blueSecondary = HexColor.fromHex('#1C57AD');
  static Color blueTertiary = HexColor.fromHex('#8DB3EB');
  static Color blueQuaternary = HexColor.fromHex('#D9E7FA');
  static Color blueClick = HexColor.fromHex('#0B418F');
  static Color blueHover = HexColor.fromHex('#1258B0');

  static Color orangePrimary = HexColor.fromHex('#1CBA92');
  static Color orangeSecondary = HexColor.fromHex('#189F7D');
  static Color orangeTertiary = HexColor.fromHex('#7DD7C0');
  static Color orangeQuaternary = HexColor.fromHex('#DEF5EF');

  static Color success = HexColor.fromHex('#42C532');
  static Color successPrimary = HexColor.fromHex('#38A731');
  static Color successSecondary = HexColor.fromHex('#B4F8AC');
  static Color successTertiary = HexColor.fromHex('#E7FCE5');

  static Color attention = HexColor.fromHex('#F1A026');
  static Color attentionHover = HexColor.fromHex('#F29303');
  static Color attentionSecondary = HexColor.fromHex('#FAD398');
  static Color attentionTertiary = HexColor.fromHex('#FDEDD4');

  static Color error = HexColor.fromHex('#EC3D3D');
  static Color errorPrimary = HexColor.fromHex('#E12424');
  static Color errorSecondary = HexColor.fromHex('#FFC0C0');
  static Color errorTertiary = HexColor.fromHex('#FFF2F2');

  static Color white = HexColor.fromHex('#FFFFFF');
  static Color black = HexColor.fromHex('#000000');

  static Color cloudDark = HexColor.fromHex('#E8EDF1');
  static Color startGradient = HexColor.fromHex('#2265C6');
  static Color centerGradient = HexColor.fromHex('#2265C6').withOpacity(0.90);
  static Color endGradient = HexColor.fromHex('#2265C6').withOpacity(0.70);

  static Color blueTop = HexColor.fromHex('#296AC9');
  static Color hightLight = HexColor.fromHex('#444F66');
}

extension HexColor on Color {
  static Color fromHex(String hex) {
    hex = hex.replaceAll('#', '');
    if (hex.length == 6) {
      hex = "FF" + hex; // 8 char with opacity 100%
    }
    return Color(int.parse(hex, radix: 16));
  }
}
