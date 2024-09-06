class User {
  String? key;
  UserDTO? userDTO;

  User({required this.key, required this.userDTO});
}

class UserDTO {
  late final String email;
  late final String pictureUrl;
  late final String username;

  UserDTO({required this.email, this.pictureUrl = "", required this.username});

  UserDTO.fromJson(Map<dynamic, dynamic> json) {
    username = json['username'];
    email = json['email'];
    pictureUrl = json['picture_url'] ?? "";
  }

  toJson() {
    return {
      "email": email,
      "username": username,
      "pictureUrl": pictureUrl,
    };
  }
}
