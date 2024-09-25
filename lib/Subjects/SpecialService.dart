import 'package:flutter/material.dart';
import 'package:othmath/Subjects/SSub.dart';

class SpecialSubjectServices extends StatefulWidget {
  final String subjectName;
  final String className;
  const SpecialSubjectServices(
      {super.key, required this.className, required this.subjectName});

  @override
  State<SpecialSubjectServices> createState() {
    return _SubjectServices(className: className, subjectName: subjectName);
  }
}

class _SubjectServices extends State<SpecialSubjectServices> {
  final String subjectName;
  final String className;
  _SubjectServices({required this.className, required this.subjectName});
  Widget build(BuildContext context) {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    return SpecialTeacherSubjects(
        className: arguments!["Class"], subjectName: arguments["Name"]);
  }
}
