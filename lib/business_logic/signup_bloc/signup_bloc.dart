import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miicon_protocol/data/repository/auth_repository.dart';
import 'signup.dart';
class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthenticationRepository _authenticationRepository;
  SignupBloc(this._authenticationRepository) : super(InitSignupState()) {
    on<StoreSignupDataEvent>((event, emit) {
      StoreSignupDataEvent(firstName: event.firstName);
    });
    on<SignupSubmittingEvent>((event, emit) async {
      emit(SignupingState());
      try {
        final isSuccess = await _authenticationRepository.getSignup({
          "first_name": event.firstName,
          "last_name": event.lastName,
          "email": event.email,
          "country": event.country,
          "password": event.password,
        });
        if (isSuccess) {
          emit(SignupCompetedState());
        } else {
          emit(SignupErrorState(
            _authenticationRepository.passwordValidationError.first,
          ));
        }
      } catch (e) {
        emit(SignupErrorState(
          _authenticationRepository.passwordValidationError[0],
        ));
      }
    });
    on<SignupTokenValidationEvent>((event, emit) async {
      emit(SignupingState());

      try {
        final isValid =
            await _authenticationRepository.verifyEmailOtp(event.token);
        emit(SignupTokenValidateSuccessState());
        if (isValid) {
          emit(SignupTokenValidateSuccessState());
        } else {
          emit(SignupTokenValidateErrorState());
        }
      } catch (e) {
        emit(SignupErrorState(e.toString()));
      }
    });
    on<CheckEmailEvent>((event, emit) async {
      emit(EmailValidatingState());
      try {
        final isValid = await _authenticationRepository.checkEmail({
          "email": event.email,
        });
        emit(EmailValidState(isValid));
      } catch (e) {
        emit(SignupErrorState(e.toString()));
      }
    });
  }

  @override
  void onChange(Change<SignupState> change) {
    print("from ${change.currentState} to ${change.nextState}");

    super.onChange(change);
  }
}
