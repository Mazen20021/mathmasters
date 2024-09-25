import 'package:othmath/FireBase/UsersDataBase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MobLogin extends StatefulWidget {
  const MobLogin({super.key});

  @override
  State<MobLogin> createState() => _MobLoginState();
}

class _MobLoginState extends State<MobLogin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  Createusers lg = Createusers();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _login(BuildContext context) async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    final form = _formKey.currentState;
    if (form == null || !form.validate()) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final email = emailController.text;
        final password = passwordController.text;

        if (email.isNotEmpty && password.isNotEmpty) {
          if (email.contains("as")) {
            await lg.loginWithEmailAndPass(email, password, context, "AS");
          } else if (email.contains("te")) {
            await lg.loginWithEmailAndPass(email, password, context, "MM");
          } else {
            await lg.loginWithEmailAndPass(email, password, context, "ST");
          }
        }
      } catch (e) {
        print('Error logging in: $e');
        // Handle error here, such as displaying an error message to the user
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF6441A5),
                  Color(0xFF2A0845),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: constraints.maxWidth < 600 ? 300 : 400,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Login',
                          style: GoogleFonts.pacifico(
                            fontSize: constraints.maxWidth < 600 ? 36 : 48,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 40),
                        _buildTextField(
                          controller: emailController,
                          context: context,
                          hint: 'Email',
                          icon: Icons.email,
                        ),
                        const SizedBox(height: 20),
                        _buildTextField(
                          controller: passwordController,
                          context: context,
                          hint: 'Password',
                          icon: Icons.lock,
                          obscureText: true,
                        ),
                        const SizedBox(height: 40),
                        _isLoading
                            ? const CircularProgressIndicator(
                                backgroundColor:
                                    Color.fromARGB(255, 84, 174, 226),
                                color: Color.fromARGB(255, 255, 255, 255),
                              )
                            : ElevatedButton(
                                onPressed: () => _login(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        constraints.maxWidth < 600 ? 40 : 50,
                                    vertical: 15,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  'Login',
                                  style: GoogleFonts.pacifico(
                                    fontSize:
                                        constraints.maxWidth < 600 ? 18 : 20,
                                    color: const Color(0xFF6441A5),
                                  ),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required BuildContext context,
    required String hint,
    required IconData icon,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return "Please enter $hint";
        }
        return null;
      },
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.white),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
