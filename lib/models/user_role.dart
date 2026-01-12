enum UserRole {
  admin,
  user;

  static UserRole fromString(String? value) {
    if (value == 'admin') return UserRole.admin;
    return UserRole.user;
  }

  String get value => name;
}
