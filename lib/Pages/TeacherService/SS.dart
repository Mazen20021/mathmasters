import 'package:flutter/material.dart';
import 'package:othmath/Pages/TeacherService/Subjects.dart';


class SS extends StatefulWidget {
  final String Level;
  const SS({super.key, required this.Level});

  @override
  State<SS> createState() {
    return _SubjectServices(Level: Level);
  }
}

class _SubjectServices extends State<SS> {
  final String Level;
  _SubjectServices({required this.Level});
  Widget build(BuildContext context) {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    return LevelSelection(
      level: arguments!["Level"],
      hasApplied: arguments["hasApplied"],
      pureSubjects: arguments["Pure"],
      appliedSubjects: arguments["Applied"],
    );
  }
}
