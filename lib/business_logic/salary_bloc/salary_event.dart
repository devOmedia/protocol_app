import 'package:equatable/equatable.dart';
import 'package:miicon_protocol/data/models/user_attendance.dart';

class SalaryEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//filted attendance states
class SalaryLoadingEvent extends SalaryEvent {
  final String id;
  final String year;
  final String month;
  SalaryLoadingEvent(
      {required this.id, required this.month, required this.year});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SalaryLoadedEvent extends SalaryEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SalaryLoadErrorEvent extends SalaryEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SalaryLoadInitEvent extends SalaryEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SalaryLoadingInitEvent extends SalaryEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SalaryLoadInitErrorEvent extends SalaryEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
