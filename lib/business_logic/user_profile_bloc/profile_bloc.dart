import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miicon_protocol/data/repository/protocol_repository.dart';
import 'profile.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc({required this.repository}) : super(ProfileState()) {
    on<ProfileLoadingEvent>((event, emit) async {
      emit(ProfileLoadingState());
      try {
        final profile = await repository.userProfile();

        emit(ProfileLoadedState(profile: profile));
      } catch (e) {
        throw Exception();
      }
    });
  }
  final ProtocolRepository repository;
}
