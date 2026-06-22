import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../viewmodel/employee_cubit.dart';
import '../../viewmodel/employee_state.dart';
import '../../viewmodel/theme_cubit.dart';
import '../widget/employee_card.dart';



class EmployeeListPage extends StatefulWidget {
  const EmployeeListPage({super.key});

  @override
  State<EmployeeListPage> createState() => _EmployeeListPageState();
}

class _EmployeeListPageState extends State<EmployeeListPage> {
  final TextEditingController searchController =
  TextEditingController();

  @override
  void initState() {
    super.initState();

    context.read<EmployeeCubit>().fetchEmployees();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Employees"),
        centerTitle: true,
        actions: [
          BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return IconButton(
                onPressed: () {
                  context.read<ThemeCubit>().toggleTheme();
                },
                icon: Icon(
                  themeMode == ThemeMode.dark
                      ? Icons.light_mode
                      : Icons.dark_mode,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [

          /// SEARCH BAR
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                context
                    .read<EmployeeCubit>()
                    .search(value);
              },
              decoration: InputDecoration(
                hintText: "Search employee...",
                prefixIcon:
                const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(15),
                ),
              ),
            ),
          ),

          /// BODY
          Expanded(
            child:
            BlocBuilder<EmployeeCubit,
                EmployeeState>(
              builder: (context, state) {

                /// INITIAL
                if (state
                is EmployeeInitial) {
                  return const Center(
                    child: Text(
                        "Loading employees..."),
                  );
                }

                /// LOADING
                if (state
                is EmployeeLoading) {
                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                /// LOADED
                if (state
                is EmployeeLoaded) {
                  if (state
                      .employees
                      .isEmpty) {
                    return const Center(
                      child:
                      Text("No Employees"),
                    );
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      context
                          .read<EmployeeCubit>()
                          .fetchEmployees();
                    },
                    child: ListView.builder(
                      itemCount: state
                          .employees
                          .length,
                      itemBuilder:
                          (context, index) {
                        final employee =
                        state.employees[
                        index];

                        return EmployeeCard(
                          employee:
                          employee,
                        );
                      },
                    ),
                  );
                }

                /// ERROR
                if (state
                is EmployeeError) {
                  return Center(
                    child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 60,
                          color: Colors.red,
                        ),
                        const SizedBox(
                            height: 10),
                        Text(
                          state.message,
                          textAlign:
                          TextAlign.center,
                        ),
                        const SizedBox(
                            height: 15),
                        ElevatedButton(
                          onPressed: () {
                            context
                                .read<
                                EmployeeCubit>()
                                .fetchEmployees();
                          },
                          child:
                          const Text("Retry"),
                        )
                      ],
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}