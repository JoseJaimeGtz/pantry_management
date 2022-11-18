import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pantry_management/signIn_signUp/user_auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserAuthRepository _authRepo = UserAuthRepository();

  AuthBloc() : super(AuthInitial()) {
    on<VerifyAuthEvent>(_authVerfication);
    //on<AnonymousAuthEvent>(_authAnonymous);
    on<GoogleAuthEvent>(_authUser);
    on<SignInEvent>(_signIn);
    on<SignOutEvent>(_signOut);
  }

  FutureOr<void> _signIn(event, emit) async {
    emit(AuthAwaitingState());
    try {
      bool state = await _authRepo.signInWithEmail(event.email, event.password);
      if(state){
      emit(AuthSuccessState());
      }
      else{
        emit(WrongPasswordState());
      }
      //Navigator.pushNamed(event.context, '/yourFood');
    } catch (e) {
      print("Error al autenticar: $e");
    }
  }

  FutureOr<void> _authVerfication(event, emit) {
    // inicializar datos de la app
    if (_authRepo.isAlreadyAuthenticated()) {
      emit(AuthSuccessState());
    } else {
      emit(UnAuthState());
    }
  }

  FutureOr<void> _signOut(event, emit) async {
    //if (FirebaseAuth.instance.currentUser!.isAnonymous) {
    //await _authRepo.signOutFirebaseUser();
    //} else {
    try {
      await _authRepo.signOutFull();
      print("signed out");
      emit(SignOutSuccessState());
    } catch (e) {
      print(e);
      emit(AuthErrorState());
    }
    
    
      //await _authRepo.signOutGoogleUser();
      //await _authRepo.signOutFirebaseUser();
   // }
  }

  FutureOr<void> _authUser(event, emit) async {
    emit(AuthAwaitingState());
    try {
      await _authRepo.signInWithGoogle();
      emit(AuthSuccessState());
      //Navigator.pushNamed(event.context, '/yourFood');
    } catch (e) {
      print("Error al autenticar: $e");
      emit(AuthErrorState());
    }
  }

}