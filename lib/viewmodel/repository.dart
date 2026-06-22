import 'package:untitled5/viewmodel/services/employee_service.dart';

import '../model/employee_model.dart';

abstract class EmployeeRepository {
  Future<List<EmployeeModel>> getEmployees();
}
class EmployeeRepositoryImpl
    implements EmployeeRepository {

  final ApiService apiService;

  EmployeeRepositoryImpl(this.apiService);

  @override
  Future<List<EmployeeModel>> getEmployees() async {
    return await apiService.getEmployees();
  }
}