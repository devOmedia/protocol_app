import 'package:equatable/equatable.dart';
import 'package:miicon_protocol/data/models/salary_model.dart';
import 'package:miicon_protocol/data/models/user_attendance.dart';

class SalaryState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//filted attendance states
class SalaryLoadingState extends SalaryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SalaryLoadedState extends SalaryState {
  final SalaryEventModel salary;
  SalaryLoadedState({required this.salary});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SalaryLoadErrorState extends SalaryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SalaryLoadInitState extends SalaryState {
  final SalaryEventModel salary;
  SalaryLoadInitState({required this.salary});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SalaryLoadingInitState extends SalaryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class SalaryLoadInitErrorState extends SalaryState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
