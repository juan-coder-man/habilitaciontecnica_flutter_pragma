class UserEntity {
  const UserEntity({
    required this.id,
    required this.email,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.phone,
  });

  final int id;
  final String email;
  final String username;
  final String firstName;
  final String lastName;
  final String phone;

  String get fullName => '$firstName $lastName'.trim();
}
