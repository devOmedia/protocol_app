import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticatingState extends AuthenticationState {
  @override
  List<Object?> get props => [];
}

class AuthenticatedState extends AuthenticationState {
  @override
  List<Object?> get props => super.props;
}

class AuthenticationErrorState extends AuthenticatedState {
  AuthenticationErrorState(this.error);
  final String error;
  @override
  List<Object?> get props => super.props;
}

//forget password states
class CheckedMailForForgetPasswordState extends AuthenticatedState {}

class CheckedMailForForgetPasswordErrorState extends AuthenticatedState {
  final String errorMsg;
  CheckedMailForForgetPasswordErrorState({required this.errorMsg});
}

class CheckingMailForForgetPasswordState extends AuthenticatedState {}

// otp

class CheckedOTPForForgetPasswordState extends AuthenticatedState {}

class CheckedOTPForForgetPasswordErrorState extends AuthenticatedState {
  final String errorMsg;
  CheckedOTPForForgetPasswordErrorState({required this.errorMsg});
}

class CheckingOTPForForgetPasswordState extends AuthenticatedState {}

// reset password
class SetedPasswordForForgetPasswordState extends AuthenticatedState {}

class SetedPasswordForForgetPasswordErrorState extends AuthenticatedState {
  final String errorMsg;
  SetedPasswordForForgetPasswordErrorState({required this.errorMsg});
}

class SettingPasswordForForgetPasswordState extends AuthenticatedState {}
