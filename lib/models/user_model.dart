class UserModel {
  final String uid;
  final String name;
  final String email;
  final bool status;
  final String? profileImage;

  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.status,
    this.profileImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'status': status,
      'profileImage': profileImage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      status: map['status'] as bool,
      profileImage:
          map['profileImage'] != null ? map['profileImage'] as String : null,
    );
  }
}
