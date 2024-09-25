import 'package:othmath/Pages/MainPageService/MobileWidget.dart';
import 'package:othmath/Pages/MainPageService/WindowsWidgits.dart';
import 'package:flutter/material.dart';

class LoginAdmin extends StatefulWidget {
  const LoginAdmin({super.key});

  @override
  State<LoginAdmin> createState() => _LoginAdminState();
}

class _LoginAdminState extends State<LoginAdmin> {
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
    return _ismob ? const MOBWidget() : const WinWidget();
  }
}
