import 'package:equatable/equatable.dart';
import 'package:miicon_protocol/business_logic/auth_bloc/auth_state.dart';

class AuthenticationEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthenticationStateChange extends AuthenticationEvent {
  AuthenticationStateChange({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<Object?> get props => [];
}

class AuthenticationLogoutRequested extends AuthenticationEvent {
  @override
  List<Object?> get props => [];
}

//Forget password email states
class CheckingMailForForgetPasswordEvent extends AuthenticationEvent {
  final String email;
  CheckingMailForForgetPasswordEvent({required this.email});
}

class CheckedMailForForgetPasswordEvent extends AuthenticationEvent {}

//Forget password otp states
class CheckingOTPForForgetPasswordEvent extends AuthenticationEvent {
  final String otp;
  final String email;
  CheckingOTPForForgetPasswordEvent({required this.otp, required this.email});
}

class CheckedOTPForForgetPasswordEvent extends AuthenticationEvent {}

//Forget password reset password states
class SettingPasswordForForgetPasswordEvent extends AuthenticationEvent {
  final String password;
  final String email;
  SettingPasswordForForgetPasswordEvent(
      {required this.password, required this.email});
}

class SetedPasswordForForgetPasswordEvent extends AuthenticationEvent {}
