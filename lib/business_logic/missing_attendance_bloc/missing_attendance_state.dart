import 'package:equatable/equatable.dart';

class MissingAttendanceState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MissingAttendanceDataPostedState extends MissingAttendanceState {}

class MissingAttendanceDataPostingState extends MissingAttendanceState {}

class MissingAttendanceDataPostErrorState extends MissingAttendanceState {
  final String errorMsg;
  MissingAttendanceDataPostErrorState({required this.errorMsg});
}
