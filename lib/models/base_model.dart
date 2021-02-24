import 'package:sbercloud_flutter/models/server_error.dart';

class BaseModel<T> {
  ServerError error;
  T data;

  setException(ServerError err) {
    error = err;
  }

  setData(T data) {
    this.data = data;
  }
}