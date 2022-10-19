// extension on String
import 'package:flutter_clean_mvvm/data/mapper/mapper.dart';

extension NonNullString on String? {
  String orEmpty() {
    if (this == null) {
      return empty;
    }
    return this!;
  }
}

// extension on int
extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return zero;
    }
    return this!;
  }
}
