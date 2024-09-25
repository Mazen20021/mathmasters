import 'package:flutter/material.dart';
import 'package:othmath/Subjects/Subjects.dart';

class SubjectServices extends StatefulWidget {
  final String subjectName;
  final String role;
  const SubjectServices(
      {super.key, required this.role, required this.subjectName});

  @override
  State<SubjectServices> createState() {
    return _SubjectServices(role: role, subjectName: subjectName);
  }
}

class _SubjectServices extends State<SubjectServices> {
  final String subjectName;
  final String role;
  _SubjectServices({required this.role, required this.subjectName});
  Widget build(BuildContext context) {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    return Subjects(role: arguments!["role"], subjectName: arguments["Name"]);
  }
}
