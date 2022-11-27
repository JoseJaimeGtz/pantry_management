part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class VerifyAuthEvent extends AuthEvent {}

class AnonymousAuthEvent extends AuthEvent {}

class GoogleAuthEvent extends AuthEvent {
  final BuildContext context;

  GoogleAuthEvent({required this.context});
}

class SignInEvent extends AuthEvent {
  final String email;
  final String password;

  SignInEvent({required this.email, required this.password});

}

class SignOutEvent extends AuthEvent {}

class CreateUserEvent extends AuthEvent {
  final String email;
  final String password;

  CreateUserEvent({required this.email, required this.password});
}