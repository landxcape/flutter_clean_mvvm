class Failure {
  int code; // 200, 400, etc.
  String message; // error or success

  Failure(
    this.code,
    this.message,
  );
}
