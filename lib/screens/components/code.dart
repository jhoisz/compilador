import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class Code extends StatelessWidget {
  const Code({
    super.key,
    required CodeController? codeController,
  }) : _codeController = codeController;

  final CodeController? _codeController;

  @override
  Widget build(BuildContext context) {
    return CodeField(
      controller: _codeController!,
      horizontalScroll: true,
      expands: true,
      lineNumberStyle: LineNumberStyle(
        textStyle: TextStyle(color: AppTheme.myColors.normal),
      ),
      cursorColor: AppTheme.myColors.secondaryColor,
      textStyle: TextStyle(
        fontFamily: 'FiraCode',
        color: AppTheme.myColors.normal,
      ),
      background: AppTheme.myColors.background,
    );
  }
}