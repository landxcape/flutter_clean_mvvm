// Project imports:
import 'package:flutter_clean_mvvm/data/network/error_handler.dart';

class Failure {
  int code; // 200, 400, etc.
  String message; // error or success

  Failure(
    this.code,
    this.message,
  );
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.defaultError, ResponseMessage.defaultError);
}
