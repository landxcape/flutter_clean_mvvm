// to convert the response into a non nullable object (model)

import 'package:flutter_clean_mvvm/data/responses/responses.dart';
import 'package:flutter_clean_mvvm/domain/model/model.dart';
import '../../app/extensions.dart';

const emptyString = '';
const zeroInt = 0;

extension CustomerResponseMapper on CustomerResponse? {
  Customer toDomain() {
    return Customer(
      this?.id?.orEmpty() ?? emptyString,
      this?.name?.orEmpty() ?? emptyString,
      this?.numOfNotifications?.orZero() ?? zeroInt,
    );
  }
}

extension ContactsResponseMapper on ContactsResponse? {
  Contacts toDomain() {
    return Contacts(
      this?.email?.orEmpty() ?? emptyString,
      this?.phone?.orEmpty() ?? emptyString,
      this?.link?.orEmpty() ?? emptyString,
    );
  }
}

extension AuthenticationResponseMapper on AuthenticationResponse? {
  Authentication toDomain() {
    return Authentication(
      this?.customer?.toDomain(),
      this?.contacts?.toDomain(),
    );
  }
}

extension ForgotPasswordResponseMapper on ForgotPasswordResponse? {
  String toDomain() {
    return this?.support?.orEmpty() ?? emptyString;
  }
}
