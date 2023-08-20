import 'dart:io';

import 'package:code_text_field/code_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/tokens_api.dart';
import '../themes/app_theme.dart';
import '../themes/my_colors.dart';
import '../utils/commands_color_map.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final api = TokensApi();
  CodeController? _codeController;
  String terminal = '';
  bool isError = false;

  final textUpload = TextEditingController();

  final MaterialStateProperty<Icon?> thumbIcon =
      MaterialStateProperty.resolveWith<Icon?>(
    (Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return const Icon(FontAwesomeIcons.solidMoon, color: Color(0XFF010440));
      }
      return const Icon(FontAwesomeIcons.solidSun, color: Color(0XFFF2F2F2));
    },
  );

  @override
  void initState() {
    super.initState();
    _codeController = CodeController(
      text: '',
      stringMap: commandsMap,
    );
  }

  @override
  void dispose() {
    _codeController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.myColors.background,
        actions: [
          IconButton(
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                allowMultiple: false,
                type: FileType.custom,
                allowedExtensions: ['txt'],
              );
              if (result != null) {
                if (result.files.first.extension == 'txt') {
                  File file = File.fromRawPath(result.files.first.bytes!);
                  setState(() {
                    if (_codeController != null) {
                      textUpload.text = file.path;
                      _codeController!.value = textUpload.value;
                    }
                  });
                }
              }
            },
            icon: Icon(
              Icons.upload,
              color: AppTheme.myColors.secondaryColor,
              size: 28.0,
            ),
          ),
          Switch(
            value: AppTheme.myColors is MyColorsDark,
            thumbIcon: thumbIcon,
            activeColor: AppTheme.myColors.secondaryColor,
            inactiveThumbColor: AppTheme.myColors.secondaryColor,
            onChanged: (bool value) {
              setState(() {
                AppTheme.changeTheme(value);
                if (_codeController != null) {
                  _codeController = CodeController(
                    text: _codeController!.text,
                    stringMap: commandsMap,
                  );
                }
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: CodeField(
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
            ),
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.myColors.secondaryColor),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              color: AppTheme.myColors.background,
              child: ListView(
                children: [
                  Row(
                    children: [
                      Text(
                        'TERMINAL',
                        style:
                            TextStyle(color: AppTheme.myColors.secondaryColor),
                      ),
                      IconButton(
                        onPressed: () async {
                          if (_codeController != null) {
                            String input = _codeController!.text;
                            if (input != '') {
                              input = input.replaceAll('\r', ' ');
                              final response = await api.postCommand(input);

                              setState(() {
                                terminal = response[0];
                                isError = response[1];
                              });
                            }
                          }
                        },
                        icon: Icon(
                          Icons.play_arrow,
                          color: AppTheme.myColors.secondaryColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (_codeController != null) {
                              terminal = '';
                            }
                          });
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: AppTheme.myColors.secondaryColor,
                        ),
                      )
                    ],
                  ),
                  Text(
                    terminal,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: isError
                          ? AppTheme.myColors.success
                          : AppTheme.myColors.error,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
