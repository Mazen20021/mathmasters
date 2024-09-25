import 'package:flutter/material.dart';

class settingteacher extends StatefulWidget {
  const settingteacher({super.key});
  @override
  State<settingteacher> createState() {
    return _settingteacher();
  }
}

class _settingteacher extends State<settingteacher> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 20,
          title: const Center(
            child: Text("Settings"),
          ),
        ),
        body: SizedBox(
            width: screenWidth * 0.5,
            height: screenHeight * 0.05,
            child: Card(
              child: Column(
                children: [Expanded(child: TextFormField())],
              ),
            )),
      );
    });
  }
}
