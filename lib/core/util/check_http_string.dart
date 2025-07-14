String checkHttpsString(String value) {
  final ishttp = value.startsWith('http:');
  if (ishttp) {
    final replaced = value.replaceFirst('http:', 'https:');
    return replaced;
  }
  return value;
}
