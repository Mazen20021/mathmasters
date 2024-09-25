import 'package:flutter/material.dart';
import 'package:othmath/Pages/TeacherService/SpecialSubjects.dart';


class SpecialSub extends StatefulWidget {
  final String Level;
  const SpecialSub({super.key, required this.Level});

  @override
  State<SpecialSub> createState() {
    return _SubjectServices(Level: Level);
  }
}

class _SubjectServices extends State<SpecialSub> {
  final String Level;
  _SubjectServices({
    required this.Level,
  });
  Widget build(BuildContext context) {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    return SpecialLevelSelection(
      level: arguments!["Level"],
      hasApplied: arguments["hasApplied"],
      pureSubjects: arguments["Pure"],
      appliedSubjects: arguments["Applied"],
      Class: arguments["Class"],
    );
  }
}
