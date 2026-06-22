import 'package:flutter/material.dart';

import '../../model/employee_model.dart';

import 'package:flutter/material.dart';

import '../presentation/emp_details_screen.dart';



import 'package:flutter/material.dart';

import '../../model/employee_model.dart';
import '../presentation/emp_details_screen.dart';

class EmployeeCard extends StatelessWidget {
  final EmployeeModel employee;

  const EmployeeCard({
    super.key,
    required this.employee,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EmployeeDetailsPage(
              employee: employee,
            ),
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        elevation: 4,
        color: colorScheme.surface,
        shadowColor: colorScheme.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            children: [
              Hero(
                tag: employee.id,
                child: CircleAvatar(
                  radius: 34,
                  backgroundColor:
                  colorScheme.primaryContainer,
                  backgroundImage:
                  NetworkImage(employee.image),
                ),
              ),

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${employee.firstName} ${employee.lastName}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Row(
                      children: [
                        Icon(
                          Icons.email_outlined,
                          size: 16,
                          color:
                          colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            employee.email,
                            maxLines: 1,
                            overflow:
                            TextOverflow.ellipsis,
                            style:
                            textTheme.bodyMedium?.copyWith(
                              color: colorScheme
                                  .onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color:
                        colorScheme.primaryContainer,
                        borderRadius:
                        BorderRadius.circular(30),
                      ),
                      child: Text(
                        employee.department,
                        style:
                        textTheme.labelMedium?.copyWith(
                          color: colorScheme
                              .onPrimaryContainer,
                          fontWeight:
                          FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color:
                  colorScheme.secondaryContainer,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: colorScheme
                      .onSecondaryContainer,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}