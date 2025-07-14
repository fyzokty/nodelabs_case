class User {
  const User({required this.token, required this.id, required this.name, required this.email, this.photoUrl});
  final String? token;
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
}
