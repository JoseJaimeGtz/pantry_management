part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSuccessState extends AuthState {}

class UnAuthState extends AuthState {}

class SignOutSuccessState extends AuthState {}

class AuthErrorState extends AuthState {}

class AuthAwaitingState extends AuthState {}

class WrongPasswordState extends AuthState {}

class CreateUserSuccess extends AuthState {}

class CreateUserError extends AuthState {}