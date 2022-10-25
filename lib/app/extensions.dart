// extension on String

// Project imports:
import 'package:flutter_clean_mvvm/data/mapper/mapper.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return emptyString;
    }
    return this!;
  }
}

// extension on int
extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return zeroInt;
    }
    return this!;
  }
}
