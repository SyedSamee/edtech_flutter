import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edtech_flutter/controllers/auth_controler/login_controller/login_controller.dart';
import 'package:edtech_flutter/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:get/get.dart' as _get;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginEvent>((event, emit) {});
    on<LoginUser>(loginUser);
  }

  FutureOr<void> loginUser(LoginUser event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      if (event.email.contains("@") && event.email.contains(".com")) {
        var LoginResponse =
            await LoginController().loginUser(event.email, event.password);

        if (LoginResponse == true) {
          // login successfully
          _get.Get.offAll(() => DashboardScreen(),
              transition: _get.Transition.rightToLeft,
              duration: Duration(milliseconds: 500));
        } else if (LoginResponse is String) {
          emit(LoginInitial());
          emit(LoginMsgState(msg: LoginResponse, isError: true));
        }
      } else {
        emit(LoginInitial());
        emit(LoginMsgState(msg: "Email format is incorrect", isError: true));
      }
    } else {
      emit(LoginInitial());
      emit(LoginMsgState(msg: "One or more field's is empty", isError: true));
    }
  }
}
