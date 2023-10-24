import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SignupState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitSignupState extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupingState extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupCompetedState extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupErrorState extends SignupState {
  SignupErrorState(this.errorMsg);
  final String errorMsg;
  @override
  List<Object?> get props => [];
}

class SignupTokenValidateSuccessState extends SignupState {
  @override
  List<Object?> get props => [];
}

class SignupTokenValidateErrorState extends SignupState {
  @override
  List<Object?> get props => [];
}

class CheckEmailState extends SignupState {}

class EmailValidState extends SignupState {
  final bool isEmailRegistered;
  EmailValidState(this.isEmailRegistered);
}

class EmailValidatingState extends SignupState {}
