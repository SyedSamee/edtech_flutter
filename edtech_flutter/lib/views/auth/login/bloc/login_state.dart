part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginMsgState extends LoginState {
  final String msg;
  final bool isError;
  LoginMsgState({required this.msg, required this.isError});
}
