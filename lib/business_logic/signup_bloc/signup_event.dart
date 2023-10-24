import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class SignupEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class StoreSignupDataEvent extends SignupEvent {
  StoreSignupDataEvent({
    this.country,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
  });

  final String? firstName;
  final String? lastName;
  final String? email;
  final String? country;
  final String? password;

  StoreSignupDataEvent copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? country,
    String? password,
  }) {
    return StoreSignupDataEvent(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      country: country ?? this.country,
      password: password ?? this.password,
    );
  }

  @override
  List<Object?> get props => [];
}

class SignupSubmittedEvent extends SignupEvent {}

class SignupSubmittingEvent extends SignupEvent {
  SignupSubmittingEvent({
    required this.country,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String country;
  final String password;
}

class SignupTokenValidationEvent extends SignupEvent {
  SignupTokenValidationEvent(this.token);
  final String token;
}

class CheckEmailEvent extends SignupEvent{
  final String email;
  CheckEmailEvent(this.email);
}
