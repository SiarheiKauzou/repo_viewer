class RestApiException implements Exception {
  const RestApiException(this.errorCode);

  final int? errorCode;
}
