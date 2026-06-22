import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/viewmodel/repository.dart';

import '../model/employee_model.dart';
import 'employee_state.dart';

class EmployeeCubit extends Cubit<EmployeeState> {
  final EmployeeRepository repository;

  EmployeeCubit(this.repository)
      : super(EmployeeInitial());

  List<EmployeeModel> allEmployees = [];

  Future<void> fetchEmployees() async {
    try {
      emit(EmployeeLoading());

      allEmployees =
      await repository.getEmployees();

      emit(EmployeeLoaded(allEmployees));
    } catch (e) {
      emit(EmployeeError(e.toString()));
    }
  }

  void search(String query) {
    final filtered = allEmployees.where((e) {
      return "${e.firstName} ${e.lastName}"
          .toLowerCase()
          .contains(query.toLowerCase());
    }).toList();

    emit(EmployeeLoaded(filtered));
  }
}