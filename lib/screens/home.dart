import 'package:analisador_sql/utils/commands_color_map.dart';
import 'package:code_text_field/code_text_field.dart';
import 'package:flutter/material.dart';

import '../services/tokens_api.dart';
import '../themes/my_colors.dart';

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

  @override
  void initState() {
    super.initState();

    const source = '';
    // Instantiate the CodeController
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
      body: Column(
        children: [
          Expanded(
            child: CodeField(
              controller: _codeController!,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                            final String input = _codeController!.text;
                            if (input != '') {
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
                    style:  TextStyle(fontWeight: FontWeight.bold, color: isError ? MyColors.success : MyColors.error),
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

