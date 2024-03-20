class RestApiExcepton implements Exception {
  const RestApiExcepton(this.errorCode);

  final int? errorCode;
}
