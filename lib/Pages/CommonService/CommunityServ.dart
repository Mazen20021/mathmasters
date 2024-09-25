import 'package:othmath/Pages/CommonService/Community.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommunityServ extends StatefulWidget {
  final String email, Role;
  const CommunityServ({required this.email, required this.Role, super.key});
  @override
  _CommunityServ createState() => _CommunityServ(email: email, Role: Role);
}

class _CommunityServ extends State<CommunityServ> {
  final String email, Role;
  _CommunityServ({required this.email, required this.Role});

  @override
  Widget build(BuildContext context) {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    return CommunityPage(
      email: arguments!["Email"].toString(),
      role: arguments["Role"].toString(),
    );
  }
}
