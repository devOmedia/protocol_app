import 'package:equatable/equatable.dart';

class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileLoadingEvent extends ProfileEvent {}

class ProfileLoadedEvent extends ProfileEvent {}
