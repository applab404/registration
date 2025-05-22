class UserModel {
  final String uid;
  final String name;
  final String email;
  final String gender;
  final DateTime dob;
  final String? profileImageUrl;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.gender,
    required this.dob,
    this.profileImageUrl,
  });

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    return UserModel(
      uid: uid,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      gender: map['gender'] ?? '',
      dob: DateTime.parse(map['dob'] ?? ''),
      profileImageUrl: map['profileImageUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'gender': gender,
      'dob': dob.toIso8601String(),
      'profileImageUrl': profileImageUrl,
    };
  }
}
