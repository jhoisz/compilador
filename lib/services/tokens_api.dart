import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/response.dart';

class TokensApi {
  final url = 'https://projeto-compiladores.vercel.app/parser';
  String text =
      'create table pres (nome varchar, pena int);\ncreate table pres1 (nome1 varchar, pena1 int);';

  Future<List<dynamic>> postCommand(String input) async {
    try {
      final response = await http.post(Uri.parse(url), body: {
        'input': input,
      });

      final json = jsonDecode(response.body);
      final message = Response.fromJson(json);

      return [message.toString(), message.success];
    } catch (e) {
      return ['', false];
    }
  }
}
