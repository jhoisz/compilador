import 'package:flutter/material.dart';

import '../themes/app_theme.dart';

Map<String, TextStyle> get commandsMap => {
      'main': TextStyle(
          fontWeight: FontWeight.bold, color: AppTheme.myColors.variant1),
      // variáveis
      'int': TextStyle(
          fontWeight: FontWeight.bold, color: AppTheme.myColors.variant2),
      'float': TextStyle(
          fontWeight: FontWeight.bold, color: AppTheme.myColors.variant2),
      'bool': TextStyle(
          fontWeight: FontWeight.bold, color: AppTheme.myColors.variant2),
      'str': TextStyle(
          fontWeight: FontWeight.bold, color: AppTheme.myColors.variant2),
      // return
      'return': TextStyle(
          fontWeight: FontWeight.bold, color: AppTheme.myColors.variant4),

      //funções primitivas
      'scanf': TextStyle(
          fontWeight: FontWeight.bold, color: AppTheme.myColors.variant5),
      'print': TextStyle(
          fontWeight: FontWeight.bold, color: AppTheme.myColors.variant5),

      //end
      'end': TextStyle(
          fontWeight: FontWeight.bold, color: AppTheme.myColors.variant1),

      //comandos de controle
      'if': TextStyle(
          fontWeight: FontWeight.bold, color: AppTheme.myColors.variant3),
      'else': TextStyle(
          fontWeight: FontWeight.bold, color: AppTheme.myColors.variant3),
      'while': TextStyle(
          fontWeight: FontWeight.bold, color: AppTheme.myColors.variant3),
      //var
      'var': TextStyle(
          fontWeight: FontWeight.bold, color: AppTheme.myColors.variant6),
    };
