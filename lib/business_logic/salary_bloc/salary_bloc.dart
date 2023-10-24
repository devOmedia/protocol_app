import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miicon_protocol/data/local_database/login_db.dart';
import 'package:miicon_protocol/data/models/salary_model.dart';
import 'package:miicon_protocol/data/repository/protocol_repository.dart';
import 'salary.dart';

class SalaryEventBloc extends Bloc<SalaryEvent, SalaryState> {
  SalaryEventBloc({required this.repository}) : super(SalaryState()) {
    on<SalaryLoadingInitEvent>((event, emit) async {
      emit(SalaryLoadingInitState());
      final id = await UserInfoDB.getUserEmployeeIDData();
      final joininDate = await UserInfoDB.getUserJoiningDate();
      final joiningYear = joininDate.split("-")[0];
      final joiningMonth = joininDate.split("-")[1];

      try {
        SalaryEventModel? salary =
            await repository.getEmployeeSalary(id, joiningMonth, joiningYear);
        if (salary != null) {
          emit(SalaryLoadInitState(
            salary: salary
          ));
        } else {
          emit(SalaryLoadInitErrorState());
        }
      } catch (e) {
        throw Exception(e);
      }
    });
    on<SalaryLoadingEvent>((event, emit) async {
      emit(SalaryLoadingState());
      try {
        SalaryEventModel? salary = await repository.getEmployeeSalary(
            event.id, event.month, event.year);
        if (salary != null) {
          emit(SalaryLoadedState(
            salary: salary
          ));
        } else {
          emit(SalaryLoadErrorState());
        }
      } catch (e) {
        throw Exception(e);
      }
    });
  }
  final ProtocolRepository repository;
}
