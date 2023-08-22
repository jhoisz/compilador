import 'package:flutter/material.dart';

import '../../themes/app_theme.dart';

Future<void> showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: AppTheme.myColors.background,
        title: Text(
          'Successfully compiled',
          style: TextStyle(color: AppTheme.myColors.variant2, fontFamily: 'FiraSans'),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                'File downloaded in the Documents folder.',
                style: TextStyle(color: AppTheme.myColors.normal, fontFamily: 'FiraSans'),
              ),
              Text(
                'Open the terminal and run the command "java Program" to compile.',
                style: TextStyle(color: AppTheme.myColors.normal, fontFamily: 'FiraSans'),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK', style:  TextStyle(color: AppTheme.myColors.variant2, fontFamily: 'FiraSans')),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
