import 'dart:convert';

List<UserProfile> userProfileFromJson(String str) =>
    List<UserProfile>.from(json.decode(str).map((x) => UserProfile.fromJson(x)));

String userProfileToJson(List<UserProfile> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserProfile {
  UserProfile({
    required this.name,
    required this.bio,
    required this.roleAuthor,
    required this.roleReader,
  
  });

  String name;
  String bio;
  bool roleAuthor;
  bool roleReader;

  factory UserProfile.fromJson(Map<String, dynamic> json) {
  return UserProfile(
    name: json["name"] ?? "", // Jika "name" null, gunakan string kosong
    bio: json["bio"] ?? "",   // Jika "bio" null, gunakan string kosong
    roleAuthor: json["role_author"] ?? false, // Jika "role_author" null, gunakan false
    roleReader: json["role_reader"] ?? false, // Jika "role_reader" null, gunakan false
  );
}

  Map<String, dynamic> toJson() => {
        "name": name,
        "bio": bio,
        "role_author": roleAuthor,
        "role_reader": roleReader,
      };
}
