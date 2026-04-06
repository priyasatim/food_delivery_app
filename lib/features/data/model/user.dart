class User {
  final int? id;
  final String name;
  final String email;
  final String mobile;
  final String dob;
  final String gender;
  final String profileImage;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.dob,
    required this.gender,
    required this.profileImage,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'mobile': mobile,
    'dob': dob,
    'gender': gender,
    'profile_image': profileImage,
  };

  factory User.fromMap(Map<String, dynamic> map) => User(
    id: map['id'],
    name: map['name'],
    email: map['email'],
    mobile: map['mobile'],
    dob: map['dob'],
    gender: map['gender'],
    profileImage: map['profile_image'],
  );
}
