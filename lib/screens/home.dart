import 'dart:io';

import 'package:code_text_field/code_text_field.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../services/tokens_api.dart';
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

  @override
  void initState() {
    super.initState();
    const source = '';
    _codeController = CodeController(
      text: source,
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
        backgroundColor: MyColors.background,
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
              icon:
                  const Icon(Icons.upload, color: MyColors.color3, size: 28.0)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CodeField(
              controller: _codeController!,
              horizontalScroll: true,
              expands: true,
              textStyle: const TextStyle(
                  fontFamily: 'FiraCode', color: MyColors.color4),
              background: MyColors.background,
            ),
          ),
          Container(
            height: 1,
            decoration: BoxDecoration(
              border: Border.all(color: MyColors.color3),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              color: MyColors.background,
              child: ListView(
                children: [
                  Row(
                    children: [
                      const Text(
                        'TERMINAL',
                        style: TextStyle(color: MyColors.color3),
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
                        icon: const Icon(Icons.play_arrow,
                            color: MyColors.color3),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            if (_codeController != null) {
                              terminal = '';
                            }
                          });
                        },
                        icon: const Icon(Icons.delete_outline,
                            color: MyColors.color3),
                      )
                    ],
                  ),
                  Text(
                    terminal,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: isError ? MyColors.success : MyColors.error),
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
