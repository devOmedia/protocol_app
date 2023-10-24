import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miicon_protocol/data/repository/auth_repository.dart';
import 'auth.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({required this.authenticationRepository})
      : super(AuthenticationState()) {
    on<AuthenticationStateChange>(_onAuthenticationStatusChanged);
    on<CheckingMailForForgetPasswordEvent>((event, emit) async {
      emit(CheckingMailForForgetPasswordState());
      try {
        final isEmailValid = await authenticationRepository
            .checkEmailToResetPassword(event.email);

        if (isEmailValid) {
          emit(CheckedMailForForgetPasswordState());
        } else {
          emit(CheckedMailForForgetPasswordErrorState(
              errorMsg:
                  authenticationRepository.forgetPasswordEmailCheckErrorMsg!));
        }
      } catch (_) {
        throw Error();
      }
    });
    on<CheckingOTPForForgetPasswordEvent>((event, emit) async {
      emit(CheckingOTPForForgetPasswordState());
      try {
        final isOTPValid =
            await authenticationRepository.checkOTPToResetPassword({
          "otp": event.otp,
          "email": event.email,
        });
        if (isOTPValid) {
          emit(CheckedOTPForForgetPasswordState());
        } else {
          emit(CheckedOTPForForgetPasswordErrorState(
            errorMsg: "OTP is invalid",
          ));
        }
      } catch (_) {
        throw Error();
      }
    });

    on<SettingPasswordForForgetPasswordEvent>((event, emit) async {
      emit(SettingPasswordForForgetPasswordState());
      try {
        final isPasswordSet = await authenticationRepository.changePassword({
          "email": event.email,
          "password": event.password,
        });
        if (isPasswordSet) {
          emit(SetedPasswordForForgetPasswordState());
        } else {
          emit(SetedPasswordForForgetPasswordErrorState(
              errorMsg:
                  "Invalid password, password must be combination of letters and digits."));
        }
      } catch (_) {
        throw Error();
      }
    });
  }
  final AuthenticationRepository authenticationRepository;

  Future<void> _onAuthenticationStatusChanged(
    AuthenticationStateChange event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(AuthenticatingState());
    //Future.delayed(Duration(seconds: 300));
    try {
      final islogged = await authenticationRepository.getUserLogin({
        "email": event.email,
        "password": event.password,
      });
      print("====>>>>> islogged: $islogged");
      if (islogged) {
        emit(AuthenticatedState());
      } else {
        emit(AuthenticationErrorState("Something went wrong"));
      }
    } catch (e) {
      emit(AuthenticationErrorState(e.toString()));
    }
  }
}
