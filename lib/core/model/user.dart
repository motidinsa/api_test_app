class User {
  late String firstname;
  late String lastname;
  late String email;
  late String avatar;

  User({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.avatar,
  });

  User.fromJson(Map<String, dynamic> json) {
    firstname = json['first_name'];
    lastname = json['last_name'];
    email = json['email'];
    avatar = json['avatar'];
  }
}
