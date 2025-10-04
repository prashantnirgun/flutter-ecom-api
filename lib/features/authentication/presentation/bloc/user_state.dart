import 'package:flutter_ecom_api/features/authentication/data/models/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class LoginSuccessState extends UserState {
  final UserModel user;
  LoginSuccessState({required this.user});
}

class SignupSuccessState extends UserState {}

class UserLoadedState extends UserState {
  List<UserModel> mUsersList;
  UserLoadedState({required this.mUsersList});
}

class UserFailureState extends UserState {
  String errorMessage;
  UserFailureState({required this.errorMessage});
}

// Extension for convenient getters
extension UserStateX on UserState {
  /// Returns the currently logged-in UserModel, or null if not logged in
  UserModel? get currentUser {
    if (this is LoginSuccessState) {
      return (this as LoginSuccessState).user;
    }
    return null;
  }

  /// Returns the logged-in user's ID as int, or null if not logged in
  int? get currentUserId {
    final user = currentUser;
    if (user != null) {
      return int.tryParse(user.id);
    }
    return null;
  }

  /// Returns the logged-in user's name, or null if not logged in
  String? get currentUserName => currentUser?.name;
}
