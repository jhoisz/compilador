import 'response_error_info.dart';

class Response {
/*
{
  "success": false,
  "errorInfo": [
    {
      "errorType": "token_not_expected",
      "line": 1,
      "expected": "(",
      "received": "nome"
    }
  ]
} 
*/
  bool? success;
  List<ResponseErrorInfo?>? errorInfo;

  Response({
    this.success,
    this.errorInfo,
  });
  Response.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['errorInfo'] != null) {
      final v = json['errorInfo'];
      final arr0 = <ResponseErrorInfo>[];
      v.forEach((v) {
        arr0.add(ResponseErrorInfo.fromJson(v));
      });
      errorInfo = arr0;
    }
  }
  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['success'] = success;
    if (errorInfo != null) {
      final v = errorInfo;
      final arr0 = [];
      for (var v in v!) {
        arr0.add(v!.toJson());
      }
      data['errorInfo'] = arr0;
    }
    return data;
  }

  @override
  String toString() {
    String message = success == true
        ? "successfully compiled code\n"
        : "Compilation error\n";

    for (final error in errorInfo ?? []) {
      message += '$error\n';
    }

    return message;
  }
}
