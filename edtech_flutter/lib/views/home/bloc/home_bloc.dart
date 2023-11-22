import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:edtech_flutter/views/auth/login/login_screen.dart';
import 'package:edtech_flutter/views/auth/register/register_screen.dart';
import 'package:edtech_flutter/views/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' as _get;
import 'package:get/get_navigation/get_navigation.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<HomeLoginChecker>(homeLoginChecker);
    on<HomeAuthNavigation>(homeAuthNavigation);
  }

  FutureOr<void> homeLoginChecker(
      HomeLoginChecker event, Emitter<HomeState> emit) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (sharedPreferences.getString("userId") != null) {
      _get.Get.offAll(() => DashboardScreen(),
          transition: _get.Transition.rightToLeft,
          duration: Duration(milliseconds: 500));
    }
  }

  FutureOr<void> homeAuthNavigation(
      HomeAuthNavigation event, Emitter<HomeState> emit) {
    _get.Get.to(
        () => event.routeName == "login" ? LoginScreen() : RegisterScreen(),
        transition: _get.Transition.rightToLeft,
        duration: Duration(milliseconds: 500));
  }
}
