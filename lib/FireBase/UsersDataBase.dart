import 'package:othmath/AuthoCheck.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Createusers {
  DatabaseReference ref = FirebaseDatabase.instance.ref();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool is_loggedin = false;
  
  void init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
  }

  Future<void> signInWithEmailAndPassword(String email, String password,
      String userID, String name, String document) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        print("User signed in: ${user.email}");
        await loginUser(userID, name, document);
      } else {
        print("No user returned from sign-in");
      }
    } on FirebaseAuthException catch (e) {
      print("Error signing in: ${e.message}");
    } catch (e) {
      print("Unexpected error signing in: $e");
    }
  }

  Future<void> loginUser(String userID, String name, String document) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection(document).doc(userID).get();

      if (!snapshot.exists) {
        print("Document does not exist");
        is_loggedin = false;
        return;
      }

      String storedId = snapshot.get("ID");
      String email = snapshot.get("Email");
      String password = snapshot.get("Password");
      String userName = snapshot.get("Name");
      User? user = _auth.currentUser;

      if (user != null && storedId == userID && userName == name) {
        is_loggedin = true;
      } else {
        await signInWithEmailAndPassword(
            email, password, userID, userName, document);
      }
    } catch (error) {
      is_loggedin = false;
      print("Error logging in: $error");
    }
  }

  void createuserwithemailandpass(
      String emailAddress, String password, BuildContext context) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            'Success',
            style: TextStyle(fontSize: 20),
          ),
          content: const Text(
            'User Created Successfully !',
            style: TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print("password is weak");
      } else if (e.code == 'email-already-in-use') {
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Error',
              style: TextStyle(fontSize: 20),
            ),
            content: const Text(
              'This User Exists Already!',
              style: TextStyle(fontSize: 20),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text(
            'Error',
            style: TextStyle(fontSize: 20),
          ),
          content: Text(
            'Error 404 Dueto $e',
            style: const TextStyle(fontSize: 20),
          ),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

  Future<void> loginWithEmailAndPass(
    String email, String password, BuildContext context, String role) async {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: password);

    // After successful login, get the current user details
    String storedId = FirebaseAuth.instance.currentUser?.uid ?? '';
    String userName = FirebaseAuth.instance.currentUser?.displayName ?? '';

    switch (role) {
      case "MM":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AuthCheck(
              role: "MM",
              Email: email,
              ID: storedId,
              Name: userName,
            ),
          ),
        );
        break;
      case "AS":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AuthCheck(
              role: "AS",
              Email: email,
              ID: storedId,
              Name: userName,
            ),
          ),
        );
        break;
      case "ST":
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => AuthCheck(
              role: "ST",
              Email: email,
              ID: storedId,
              Name: userName,
            ),
          ),
        );
        break;
      default:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const AuthCheck(role: "", Email: "", ID: "", Name: ""),
          ),
        );
        break;
    }
  } on FirebaseAuthException catch (e) {
    _handleAuthError(context, e);
  }
}

void _handleAuthError(BuildContext context, FirebaseAuthException e) {
  String title = '';
  String content = '';

  if (e.code == 'user-not-found') {
    title = 'Email Not Found';
    content =
        'This email is not found. Please sign up or try again with a valid email.';
  } else if (e.code == 'wrong-password') {
    title = 'Password Incorrect';
    content =
        'This password is incorrect. Please try again with the correct password.';
  } else {
    title = 'Error';
    content = 'User not found. Please sign up or try again later.';
  }

  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      title: Text(title, style: const TextStyle(fontSize: 20)),
      content: Text(content, style: const TextStyle(fontSize: 20)),
      actions: [
        TextButton(
          child: const Text('OK'),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

}
