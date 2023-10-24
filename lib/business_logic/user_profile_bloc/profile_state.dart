import 'package:equatable/equatable.dart';
import 'package:miicon_protocol/data/models/profile_model.dart';

class ProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProfileLoadingState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final Profile profile;
  ProfileLoadedState({required this.profile});
}

class ProfileLoadErrorState extends ProfileState {}
