import 'package:dio/dio.dart';

import '../../model/employee_model.dart';

class ApiService {
  final Dio dio;

  ApiService(this.dio);

  Future<List<EmployeeModel>> getEmployees() async {
    final response =
    await dio.get('https://dummyjson.com/users?limit=100');

    return (response.data['users'] as List)
        .map((e) => EmployeeModel.fromJson(e))
        .toList();
  }
}