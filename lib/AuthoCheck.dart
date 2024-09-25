import 'package:othmath/Pages/LoginService/AdminLogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthCheck extends StatelessWidget {
  final String role, Name, ID, Email;

  const AuthCheck(
      {required this.role,
      required this.Name,
      required this.ID,
      required this.Email,
      super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            switch (role) {
              case 'MM':
                Navigator.pushNamed(context, '/teacher', arguments: {
                  'Email': Email,
                  'ID': ID,
                  'Name': Name,
                });
                break;
              case 'ST':
                Navigator.pushNamed(context, '/main', arguments: {
                  'email': Email,
                  'Name': Name,
                });
                break;
              case 'AS':
                Navigator.pushNamed(context, '/assistant', arguments: {
                  'Email': Email,
                  'ID': ID,
                  'Name': Name,
                });
                break;
              default:
                Navigator.pushNamed(context, '/othmath');
            }
          });
          return const LoginAdmin();
        } else {
          return const LoginAdmin();
        }
      },
    );
  }

  Future<void> saveUserData(String email, String id, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('Email', email);
    await prefs.setString('ID', id);
    await prefs.setString('Name', name);
  }

  Future<Map<String, String>> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'Email': prefs.getString('Email') ?? '',
      'ID': prefs.getString('ID') ?? '',
      'Name': prefs.getString('Name') ?? '',
    };
  }
}
