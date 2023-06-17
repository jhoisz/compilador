class ResponseErrorInfo {
/*
{
  "errorType": "token_not_expected",
  "line": 1,
  "expected": "(",
  "received": "nome"
} 
*/

  String errorType;
  int line;
  String? expected;
  String received;

  ResponseErrorInfo({
    required this.errorType,
    required this.line,
    this.expected,
    required this.received,
  });

  ResponseErrorInfo.fromJson(Map<String, dynamic> json)
      : errorType = json['errorType'].toString(),
        line = json['line']?.toInt(),
        expected = json['expected'].toString(),
        received = json['received'].toString();

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['errorType'] = errorType;
    data['line'] = line;
    data['expected'] = expected;
    data['received'] = received;
    return data;
  }

  @override
  String toString() {
    String message = 'Error: $errorType\n';
    message += 'Line: $line\n';
    message += 'Received: $received\n';
    if (expected != null) {
      message += 'Expected: $expected\n';
    }
    return message;
  }
}
