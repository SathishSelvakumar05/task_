import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled5/view/presentation/employee_screen.dart';
import 'package:untitled5/view/presentation/login_screen.dart';
import 'package:untitled5/viewmodel/employee_cubit.dart';
import 'package:untitled5/viewmodel/repository.dart';
import 'package:untitled5/viewmodel/services/connectivity_service.dart';
import 'package:untitled5/viewmodel/services/employee_service.dart';
import 'package:untitled5/viewmodel/theme_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  ConnectivityService.listen();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>ThemeCubit() ,),
        BlocProvider(

          create: (_) => EmployeeCubit(
            EmployeeRepositoryImpl(
              ApiService(Dio()),
            ),
          ),
          child: const MyApp(),
        ),
      ], child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeMode>(
      builder: (context, themeMode) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          themeMode: themeMode,

          theme: ThemeData(
            brightness: Brightness.light,
            useMaterial3: true,
            colorSchemeSeed: Colors.indigo,
          ),

          darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
            colorSchemeSeed: Colors.indigo,
          ),

          home: const LoginScreen(),
        );
      },
    );
  }
}
