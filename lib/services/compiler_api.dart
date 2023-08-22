import 'dart:convert';

import 'package:download/download.dart';
import 'package:http/http.dart' as http;

import '../utils/local_path.dart';

class CompilerApi {
  final url = 'http://127.0.0.1:8000/compile';

  Future<List<dynamic>?> postEntry(String input) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          'input': input,
        },
      );

      if (response.statusCode == 200) {
        final stream = Stream.fromIterable(
          response.body.codeUnits,
        );

        final path = await localPath;

        download(stream, '$path/Program.class');
        return [true, response.body];
      } else if (response.statusCode == 400) {
        final json = jsonDecode(response.body);
        return [false, 'Error: ${json['error']}'];
      }
    } catch (e) {
      // print(e);
    }
    return null;
  }
}
