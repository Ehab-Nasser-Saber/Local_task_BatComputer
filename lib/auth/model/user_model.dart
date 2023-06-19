class UserModel {
  final String email;
  final String password;
  final int count;

  UserModel({required this.email, required this.count, required this.password});

  UserModel.fromMap(Map<String, dynamic> user)
      : email = user["email"],
        password = user["password"],
        count = user["count"];

  Map<String, Object> toMap() {
    return {'email': email, 'password': password, "count": count};
  }
}
