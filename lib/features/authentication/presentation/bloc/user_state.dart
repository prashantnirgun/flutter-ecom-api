import 'package:flutter_ecom_api/features/authentication/data/models/user_model.dart';

abstract class UserState {}

class UserInitialState extends UserState {}

class UserLoadingState extends UserState {}

class AuthSuccessState extends UserState {}

class UserLoadedState extends UserState {
  List<UserModel> mUsersList;
  UserLoadedState({required this.mUsersList});
}

class UserFailureState extends UserState {
  String errorMessage;
  UserFailureState({required this.errorMessage});
}
