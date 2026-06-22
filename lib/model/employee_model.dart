class EmployeeModel {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String department;
  final String image;

  EmployeeModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.department,
    required this.image,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json["id"],
      firstName: json["firstName"],
      lastName: json["lastName"],
      email: json["email"],
      phone: json["phone"],
      department: json["company"]["department"],
      image: json["image"],
    );
  }
}