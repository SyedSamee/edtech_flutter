part of 'register_bloc.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoadingState extends RegisterState {}

final class RegisterMsgState extends RegisterState {
  final String msg;
  final bool isError;
  RegisterMsgState({required this.msg, required this.isError});
}
