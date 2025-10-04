import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/core/constants/app_constant.dart';
import 'package:flutter_ecom_api/features/authentication/data/models/user_model.dart';
import 'package:flutter_ecom_api/features/authentication/domain/repositories/user_repo.dart';

import 'package:flutter_ecom_api/features/authentication/presentation/bloc/user_event.dart';
import 'package:flutter_ecom_api/features/authentication/presentation/bloc/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on<LoadUserFromPrefsEvent>(_onLoadUserFromPrefs);
    on<RegisteredUserEvent>(registeredUserEvent);
    on<LoginUserEvent>(loginUserEvent);
    on<LogoutUserEvent>(logoutUserEvent);
  }

  FutureOr<void> registeredUserEvent(
    RegisteredUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    try {
      dynamic res = await userRepository.registerUser(
        name: event.name,
        email: event.email,
        password: event.password,
        mobileNo: event.mobileNo,
      );
      if (res['status']) {
        emit(SignupSuccessState());
      } else {
        emit(UserFailureState(errorMessage: res['message']));
      }
    } catch (e) {
      emit(UserFailureState(errorMessage: e.toString()));
    }
  }

  FutureOr<void> loginUserEvent(
    LoginUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    try {
      dynamic res = await userRepository.loginUser(
        email: event.email,
        password: event.password,
      );

      if (res['status']) {
        ///prefs
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(AppConstants.TOKENKEY, res["tokan"]);

        //fetch user List
        dynamic response = await userRepository.fetchUsers();

        if (res['status']) {
          List<UserModel> mUserList = UserDataModel.fromJson(response).data;
          final currentUser = mUserList.firstWhere(
            (user) => user.email == event.email,
          );

          await prefs.setString(
            AppConstants.USERDATAKEY,
            jsonEncode(currentUser.toJson()),
          );

          emit(LoginSuccessState(user: currentUser));
        } else {}
      } else {
        emit(UserFailureState(errorMessage: res['message']));
      }
    } catch (e) {
      emit(UserFailureState(errorMessage: e.toString()));
    }
  }

  // Clear all authentication data (logout)
  Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(AppConstants.TOKENKEY);
    await prefs.remove(AppConstants.USERDATAKEY);
  }

  FutureOr<void> logoutUserEvent(
    LogoutUserEvent event,
    Emitter<UserState> emit,
  ) {
    clearAuthData();
    emit(UserInitialState());
  }

  FutureOr<void> _onLoadUserFromPrefs(
    LoadUserFromPrefsEvent event,
    Emitter<UserState> emit,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(AppConstants.USERDATAKEY);

    if (userString != null) {
      final userMap = json.decode(userString);
      UserModel user = UserModel.fromJson(userMap);
      emit(LoginSuccessState(user: user));
    } else {
      emit(UserInitialState());
    }
  }
}
