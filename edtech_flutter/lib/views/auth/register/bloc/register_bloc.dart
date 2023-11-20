import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:edtech_flutter/controllers/auth_controler/register_controller/register_controller.dart';
import 'package:edtech_flutter/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {});
    on<RegisterUserEvent>(registerUserEvent);
  }

  FutureOr<void> registerUserEvent(
      RegisterUserEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoadingState());
    if (event.name.isNotEmpty &&
        event.email.isNotEmpty &&
        event.password.isNotEmpty) {
      if (event.email.contains("@") && event.email.contains(".com")) {
        var registerResponse = await RegisterController()
            .registerUser(event.email, event.password);

        if (registerResponse == true) {
          // login successfully

          Navigator.pushAndRemoveUntil(
              event.context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
              (route) => false);
        } else if (registerResponse is String) {
          emit(RegisterInitial());
          emit(RegisterMsgState(msg: registerResponse, isError: true));
        }
      } else {
        emit(RegisterInitial());
        emit(RegisterMsgState(msg: "Email format is incorrect", isError: true));
      }
    } else {
      emit(RegisterInitial());
      emit(
          RegisterMsgState(msg: "One or more field's is empty", isError: true));
    }
  }
}
