import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewNewStudents extends StatefulWidget {
  const ViewNewStudents({super.key});

  @override
  _ViewNewStudentsState createState() => _ViewNewStudentsState();
}

class _ViewNewStudentsState extends State<ViewNewStudents> {
  List<Map<String, dynamic>> userData = [];
  List<bool> _isHovering = [];
  bool isLoading = true;
  String UName = "", UClass = "", UEmail = "";
  bool isAdded = false;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot querySnapshot =
          await firestore.collection('Submission').get();
      setState(() {
        userData = querySnapshot.docs.map((doc) {
          var data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id; // Store document ID for later use
          UName = data['Name'];
          UClass = data['Class'];
          UEmail = data['Email'];
          return data;
        }).toList();
        _isHovering = List<bool>.filled(userData.length, false);
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching data: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> _setOld(String docId, int index) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      await firestore
          .collection('Submission')
          .doc(docId)
          .update({'Type': 'Old'});
      setState(() {
        userData[index]['Type'] = 'Old';
      });
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  void _onEnter(bool hover, int index) {
    setState(() {
      _isHovering[index] = hover;
    });
  }

  Future<void> _addNewStudent(
      String ID, String Name, String Email, String Class) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    bool isAdded = false;

    try {
      UserCredential userCredential =
          await auth.createUserWithEmailAndPassword(
        email: Email,
        password:
            ID, // Using ID as password for simplicity; consider a stronger password policy
      );

      Map<String, dynamic> data = {
        "ID": ID,
        "Name": Name,
        "Email": Email,
        "Class": Class,
        "Role": "ST",
        "AuthUID": userCredential.user?.uid,
      };

      Map<String, dynamic> examData = {
        "Comment": "None",
        "Name": "None",
        "Score": "0/30",
        "Type": "None",
        "Date": "0/0/0",
      };

      CollectionReference submissions =
          FirebaseFirestore.instance.collection('Students');
      await submissions.doc(ID).set(data);

      CollectionReference examsCollection =
          submissions.doc(ID).collection('Marks');
      await examsCollection.doc("Exam").set(examData);

      setState(() {
        isAdded = true;
      });

      print("Student and marks added successfully");
    } catch (e) {
      setState(() {
        isAdded = false;
      });

      print("Failed to add student or marks: $e");
    }
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController newTaskController = TextEditingController();
  final bool _isless = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromARGB(255, 199, 174, 106),
          title: const Center(
            child: Text(
              'New Students',
              style: TextStyle(
                fontSize: 50,
                fontFamily: 'Cursive',
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: isLoading
            ? const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Loading Data ...",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    SizedBox(width: 30),
                    CircularProgressIndicator(),
                  ],
                ),
              )
            : Form(
                key: _formKey,
                child: ListView.builder(
                  padding: const EdgeInsets.all(20.0),
                  itemCount: userData.length,
                  itemBuilder: (context, index) {
                    return MouseRegion(
                      cursor: userData[index]['Type'] == 'New'
                          ? SystemMouseCursors.click
                          : SystemMouseCursors.basic,
                      onEnter: (_) => _onEnter(true, index),
                      onExit: (_) => _onEnter(false, index),
                      child: GestureDetector(
                        onTap: () {
                          if (userData[index]['Type'] == 'New') {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  backgroundColor:
                                      const Color.fromARGB(255, 24, 24, 24),
                                  title: const Text(
                                    'Student ID',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.white),
                                  ),
                                  content: TextFormField(
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your id';
                                      } else if (value.length < 6) {
                                        return "Your password is Weak";
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      newTaskController.text = value!;
                                    },
                                    controller: newTaskController,
                                    decoration: const InputDecoration(
                                      labelText: 'Password',
                                      labelStyle:
                                          TextStyle(color: Colors.white),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.white),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.blue),
                                      ),
                                    ),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.white),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text(
                                        'Add',
                                        style: TextStyle(
                                            fontSize: 20, color: Colors.red),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          _addNewStudent(
                                            newTaskController.text.trim(),
                                            UName,
                                            UEmail,
                                            UClass,
                                          );
                                          newTaskController.clear();
                                          _setOld(userData[index]['id'], index);
                                        }

                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          decoration: BoxDecoration(
                            color: (userData[index]['Type'] == 'New' &&
                                    _isHovering[index])
                                ? Colors.lightBlue[50]
                                : userData[index]['Type'] == 'New'
                                    ? const Color.fromARGB(255, 255, 128, 119)
                                    : _isHovering[index]
                                        ? Colors.lightBlue[50]
                                        : const Color.fromARGB(
                                            255, 199, 174, 106),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          padding: const EdgeInsets.all(20.0),
                          child: ListTile(
                            title: Text(
                              userData[index]['Name'] ?? '',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 17, 93, 180),
                                fontSize: 25,
                                fontFamily: 'Cursive',
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'PNumber: ${userData[index]['Parent Number']?.toString() ?? ''}',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Text(
                                  'SNumber: ${userData[index]['Student Number']?.toString() ?? ''}',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Text(
                                  'Student Email: ${userData[index]['Email'] ?? ''}',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Text(
                                  'Class: ${userData[index]['Class'] ?? ''}',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Text(
                                  'Address: ${userData[index]['Address'] ?? ''}',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                                Text(
                                  'Learning Type: ${userData[index]['Learning Type'] ?? ''}',
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ));
  }
}
