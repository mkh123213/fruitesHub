// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserEntity {
  final String email;

  final String name;
  final String uid;
  final String? profilePicture;
  UserEntity({
    this.profilePicture,
    required this.email,
    required this.name,
    required this.uid,
  });

  UserEntity copyWith({
    String? email,
    String? name,
    String? uid,
    String? profilePicture,
  }) {
    return UserEntity(
      email: email ?? this.email,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      profilePicture: profilePicture,
    );
  }
}
