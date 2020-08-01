class APIException implements Exception {
  final int code;
  final String message;

  APIException(Map data) : this.code = data['code'] ?? 500, this.message = data['error_message'] ?? 'unknown error';


  @override
    String toString() {
      return code.toString() + ":" + message;
    }
}