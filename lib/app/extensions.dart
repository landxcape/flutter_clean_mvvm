// extension on String
extension NonNullString on String? {
  String onEmpty() {
    if (this == null) {
      return '';
    }
    return this!;
  }
}

// extension on int
extension NonNullInteger on int? {
  int orZero() {
    if (this == null) {
      return 0;
    }
    return this!;
  }
}
