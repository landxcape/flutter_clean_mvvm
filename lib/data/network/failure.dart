// Project imports:
import 'package:easy_localization/easy_localization.dart';

import '/data/network/error_handler.dart';

class Failure {
  int code; // 200, 400, etc.
  String message; // error or success

  Failure(
    this.code,
    this.message,
  );
}

class DefaultFailure extends Failure {
  DefaultFailure() : super(ResponseCode.defaultError, ResponseMessage.defaultError.tr());
}
