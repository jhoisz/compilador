import 'dart:io';

import 'package:code_text_field/code_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../services/compiler_api.dart';
import '../themes/app_theme.dart';
import '../themes/my_colors.dart';
import '../utils/commands_color_map.dart';
import 'components/code.dart';
import 'components/dialog.dart';
import 'components/terminal_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final api = CompilerApi();
  CodeController? _codeController;
  String terminal = '';
  bool isError = false;
  final textUpload = TextEditingController();

  MaterialStateProperty<Icon?> get thumbIcon =>
      MaterialStateProperty.resolveWith<Icon?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return const Icon(FontAwesomeIcons.solidSun,
                color: Color(0XFFF2F2F2));
          }
          return const Icon(FontAwesomeIcons.solidMoon,
              color: Color(0XFF010440));
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
              await readFile();
            },
            icon: Icon(
              Icons.upload,
              color: AppTheme.myColors.secondaryColor,
              size: 28.0,
            ),
          ),
          Switch(
            value: AppTheme.myColors is MyColorsLight,
            thumbIcon: thumbIcon,
            activeColor: AppTheme.myColors.secondaryColor,
            inactiveThumbColor: AppTheme.myColors.secondaryColor,
            inactiveTrackColor: AppTheme.myColors.background,
            onChanged: (bool value) {
              setState(() {
                setStateTheme(value);
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Code(codeController: _codeController),
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              border: Border.all(color: AppTheme.myColors.secondaryColor),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              width: double.infinity,
              height: 50.0,
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
                          await sendRequest(context);
                        },
                        icon: Icon(
                          Icons.play_arrow,
                          color: AppTheme.myColors.secondaryColor,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            clear();
                          });
                        },
                        icon: Icon(
                          Icons.delete_outline,
                          color: AppTheme.myColors.secondaryColor,
                        ),
                      )
                    ],
                  ),
                  TerminalWidget(terminal: terminal, isError: isError)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void setStateTheme(bool value) {
    AppTheme.changeTheme(value);

    if (_codeController != null) {
      _codeController = CodeController(
        text: _codeController!.text,
        stringMap: commandsMap,
      );
    }
  }

  Future<void> readFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['txt'],
    );

    if (result != null) {
      if (result.files.first.extension == 'txt') {
        PlatformFile? file = result.files.first;
        if (file.path != null) {
          final content = File(file.path!);
          final text = await content.readAsString();

          setState(() {
            if (_codeController != null) {
              textUpload.text = text;
              _codeController!.value = textUpload.value;
            }
          });
        }
      }
    }
  }

  void clear() {
    if (_codeController != null) {
      terminal = '';
    }
  }

  Future<void> sendRequest(BuildContext context) async {
    if (_codeController != null) {
      final result = await api.postEntry(_codeController!.text);

      if (result != null && result[0]) {
        setState(() {
          isError = false;
          terminal = "successfully compiled";
        });
        if (mounted) {
          showMyDialog(context);
        }
      } else if (result != null && !result[0]) {
        setState(() {
          isError = true;
          terminal = result[1];
        });
      }
    }
  }
}
