import 'package:othmath/Pages/StudentService/StudMob.dart';
import 'package:othmath/Pages/StudentService/StudWin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MainpageALG extends StatefulWidget {
  final String email, Name;
  const MainpageALG({required this.email, required this.Name, super.key});
  @override
  _mainpagealg createState() => _mainpagealg(email: email, Name: Name);
}

class _mainpagealg extends State<MainpageALG> {
  final String email, Name;
  _mainpagealg({required this.email, required this.Name});

  bool _ismob = false;

  @override
  void initState() {
    super.initState();
    // Schedule the device type check after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkDeviceType();
    });
  }

  void checkDeviceType() {
    var screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      _ismob = screenWidth <= 800; // Simplified logic
    });
  }

  @override
  Widget build(BuildContext context) {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    return _ismob
        ? Studmob(
            email: arguments!["email"].toString(),
            name: arguments["Name"].toString(),
          )
        : Studwin(
            email: arguments!["email"].toString(),
            name: arguments["Name"].toString(),
          );
  }
}
