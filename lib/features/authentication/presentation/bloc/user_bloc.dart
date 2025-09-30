import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_ecom_api/features/authentication/domain/repositories/user_repo.dart';

import 'package:flutter_ecom_api/features/authentication/presentation/bloc/user_event.dart';
import 'package:flutter_ecom_api/features/authentication/presentation/bloc/user_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserRepository userRepository;
  UserBloc({required this.userRepository}) : super(UserInitialState()) {
    on<RegisteredUserEvent>(registeredUserEvent);
    on<LoginUserEvent>(loginUserEvent);
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
        emit(AuthSuccessState());
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
        //fetch user List
        // dynamic res = await userRepository.fetchUsers();
        // if (res['status']) {
        //   List<UserModel> mUserList = UserDataModel.fromJson(res).data;
        // final user = mUserList.firstWhere(
        //   (user) => user.email == event.email,
        // );
        //print('user is $user');
        // }

        ///prefs
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("token", res["tokan"]);
        emit(AuthSuccessState());
      } else {
        emit(UserFailureState(errorMessage: res['message']));
      }
    } catch (e) {
      emit(UserFailureState(errorMessage: e.toString()));
    }
  }

  /*
  FutureOr<void> fetchUserEvent(
    FetchUserEvent event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoadingState());
    try {
      dynamic res = userRepository.fetchUsers();
      if (res['status']) {
        List<UserModel> mUserList = UserDataModel.fromJson(res).data;
        emit(UserLoadedState(mUsersList: mUserList));
      }
    } catch (e) {
      emit(UserFailureState(errorMessage: e.toString()));
    }
  }
  */
}
