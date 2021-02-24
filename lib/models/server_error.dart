import 'package:dio/dio.dart' hide Headers;

class ServerError implements Exception {
  int _errorCode = 0;
  String _errorMessage = "";

  ServerError.withError({DioError error}) {
    _handleError(error);
  }

  int getErrorCode() {
    return _errorCode;
  }

  getErrorMessage() {
    return _errorMessage;
  }

  _handleError(DioError error) {
    try {
      _errorCode = int.parse(error.error.replaceAll(RegExp('[^0-9]'), ''));
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
    }
    switch (error.type) {
      case DioErrorType.CANCEL:
        _errorMessage = "Request was cancelled";
        break;
      case DioErrorType.CONNECT_TIMEOUT:
        _errorMessage = "Connection timeout";
        break;
      case DioErrorType.DEFAULT:
        _errorMessage =
        "Connection failed due to internet connection";
        break;
      case DioErrorType.RECEIVE_TIMEOUT:
        _errorMessage = "Receive timeout in connection";
        break;
      case DioErrorType.RESPONSE:
        _errorMessage =
        "Received invalid status code: ${error.response.statusCode}";
        break;
      case DioErrorType.SEND_TIMEOUT:
        _errorMessage = "Receive timeout in send request";
        break;
    }
    return _errorMessage;
  }
}