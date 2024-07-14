class CustomAuthException implements Exception {
  final String message;
  CustomAuthException(this.message);

  @override
  String toString() => message;
}
