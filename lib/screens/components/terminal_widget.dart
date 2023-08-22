import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

class TerminalWidget extends StatelessWidget {
  const TerminalWidget({
    super.key,
    required this.terminal,
    required this.isError,
  });

  final String terminal;
  final bool isError;

  @override
  Widget build(BuildContext context) {
    return Text(
      terminal,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16.0,
        color: isError
            ? AppTheme.myColors.error
            : AppTheme.myColors.success,
      ),
    );
  }
}
