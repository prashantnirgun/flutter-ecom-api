abstract class UserEvent {}

class RegisteredUserEvent extends UserEvent {
  String name;
  String email;
  String password;
  String mobileNo;

  RegisteredUserEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.mobileNo,
  });
}

class LoginUserEvent extends UserEvent {
  String email;
  String password;

  LoginUserEvent({required this.email, required this.password});
}

class LogoutUserEvent extends UserEvent {}

class FetchUserEvent extends UserEvent {}
