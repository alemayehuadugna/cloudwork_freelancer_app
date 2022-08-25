import 'package:json_annotation/json_annotation.dart';

part 'create_remote_user.g.dart';

@JsonSerializable()
class CreateUser {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String password;
  final bool isPolicyAgreed;

  CreateUser(
    this.firstName,
    this.lastName,
    this.phone,
    this.email,
    this.password,
    this.isPolicyAgreed,
  );

  factory CreateUser.fromJson(Map<String, dynamic> json) =>
      _$CreateUserFromJson(json);

  Map<String, dynamic> toJson() => _$CreateUserToJson(this);
}
