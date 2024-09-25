import 'package:flutter/material.dart';
import 'package:othmath/Pages/TeacherService/SubjectsTeacher.dart';


class SubServices extends StatefulWidget {
  final String subjectName;
  final String role;
  const SubServices({super.key, required this.role, required this.subjectName});

  @override
  State<SubServices> createState() {
    return _SubjectServices(role: role, subjectName: subjectName);
  }
}

class _SubjectServices extends State<SubServices> {
  final String subjectName;
  final String role;
  _SubjectServices({required this.role, required this.subjectName});
  Widget build(BuildContext context) {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    return TeacherSubjects(
        role: arguments!["role"], subjectName: arguments["Name"]);
  }
}
