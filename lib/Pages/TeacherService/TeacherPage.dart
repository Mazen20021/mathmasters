import 'package:othmath/AuthoCheck.dart';
import 'package:othmath/Pages/TeacherService/ViewNewStudents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Teacherpage extends StatefulWidget {
  final String Name, ID, Email;
  const Teacherpage(
      {required this.Name, required this.ID, required this.Email, super.key});

  @override
  State<Teacherpage> createState() {
    return _Teacherpage(Email: Email, ID: ID, Name: Name);
  }
}

class _Teacherpage extends State<Teacherpage>
    with SingleTickerProviderStateMixin {
  final String Name, ID, Email;
  _Teacherpage({required this.Name, required this.ID, required this.Email});
  bool _isHovering = false;
  bool _isHovering3 = false;
  bool _isHovering4 = false;
  bool _isHovering6 = false;
  bool _isHovering5 = false;
  final bool _hasnoti = false;

  Future<bool> showLogoutConfirmationDialog(BuildContext context) async {
    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(
                'Are you sure you want to logout?',
                style: TextStyle(fontSize: 20),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('No', style: TextStyle(fontSize: 20)),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: const Text(
                    'Yes',
                    style: TextStyle(color: Colors.redAccent, fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  void _logout(BuildContext context) async {
    bool shouldLogout = await showLogoutConfirmationDialog(context);
    if (shouldLogout) {
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamed(context,'/',);
    }
  }

  @override
  void initState() {
    _checkForNewStudents();
    super.initState();
  }

  @override
  void dispose() {
    isChecked = false;
    super.dispose();
  }

  void _onEnter(bool hover, int num) {
    switch (num) {
      case 1:
        setState(() {
          _isHovering = hover;
        });
        break;
      case 2:
        setState(() {
          _isHovering3 = hover;
        });
        break;
      case 3:
        setState(() {
          _isHovering4 = hover;
        });
        break;
      case 4:
        setState(() {
          _isHovering5 = hover;
        });
      case 6:
        setState(() {
          _isHovering6 = hover;
        });
        break;
      default:
        break;
    }
  }

  bool newStudents = false;
  bool isChecked = false;

  void _checkForNewStudents() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Submission')
          .where('Type', isEqualTo: 'New')
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        for (var doc in querySnapshot.docs) {
          setState(() {
            isChecked = false;
            newStudents = true;
          });
        }
      } else {
        setState(() {
          isChecked = true;
          newStudents = false;
        });
      }
      isChecked = true;
    } catch (e) {
      print('Error checking for new students: $e');
      isChecked = false;
    }
  }

  final Map<String, bool> _isHovering1 = {
    "Students": false,
    "Assistants": false,
    "Subjects": false,
  };

  @override
  Widget build(BuildContext context) {
    final Map? arguments = ModalRoute.of(context)!.settings.arguments as Map?;
    if (!isChecked) {
      _checkForNewStudents();
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: () async {
        return await showLogoutConfirmationDialog(context);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              MouseRegion(
                onEnter: (event) => _onEnter(true, 1),
                onExit: (event) => _onEnter(false, 1),
                child: IconButton(
                  onPressed: () => _logout(context),
                  icon: Icon(
                    Icons.logout_rounded,
                    size: 37,
                    color: _isHovering
                        ? const Color.fromARGB(255, 151, 31, 23)
                        : const Color.fromARGB(255, 41, 75, 189),
                  ),
                ),
              ),
              const Spacer(),
              MouseRegion(
                onEnter: (event) => _onEnter(true, 6),
                onExit: (event) => _onEnter(false, 6),
                child: IconButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, "/community", arguments: {
                    "Email": arguments!["Email"],
                    "Role": "MM",
                  }),
                  icon: Icon(
                    Icons.spatial_tracking_outlined,
                    size: 37,
                    color: _isHovering6
                        ? const Color.fromARGB(255, 151, 31, 23)
                        : const Color.fromARGB(255, 41, 75, 189),
                  ),
                ),
              ),
              const Spacer(
                flex: 100,
              ),
              MouseRegion(
                onEnter: (event) => _onEnter(true, 4),
                onExit: (event) => _onEnter(false, 4),
                child: IconButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((_) => const ViewNewStudents()))),
                    icon: newStudents
                        ? const Icon(
                            Icons.notification_important_rounded,
                            size: 37,
                            color: Color.fromARGB(255, 151, 31, 23),
                          )
                        : Icon(
                            Icons.notifications,
                            color: _isHovering5
                                ? const Color.fromARGB(255, 151, 31, 23)
                                : const Color.fromARGB(255, 41, 75, 189),
                            size: 37,
                          )),
              ),
              const Spacer(),
              MouseRegion(
                onEnter: (event) => _onEnter(true, 2),
                onExit: (event) => _onEnter(false, 2),
                child: IconButton(
                  onPressed: () =>
                      {Navigator.pushNamed(context, '/teachersettings')},
                  icon: Icon(
                    Icons.account_circle,
                    size: 37,
                    color: _isHovering3
                        ? const Color.fromARGB(255, 151, 31, 23)
                        : const Color.fromARGB(255, 41, 75, 189),
                  ),
                ),
              ),
            ],
          ),
          elevation: 20,
          backgroundColor: const Color.fromARGB(255, 249, 219, 186),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final screenHeight = constraints.maxHeight;
            return Stack(
              children: [
                // Background Image
                Container(
                  width: screenWidth,
                  height: screenHeight,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 91, 153, 194),
                        Color.fromARGB(255, 26, 72, 112),
                        Color.fromARGB(255, 31, 49, 111)
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),

                // Content
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const SizedBox(height: 150),
                        GridView.count(
                          shrinkWrap: true,
                          crossAxisCount: screenWidth < 600 ? 2 : 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 50,
                          childAspectRatio: 2.5,
                          children: [
                            buildCard(
                                "Students",
                                Icons.supervisor_account_rounded,
                                '/students',
                                context),
                            buildCard("Assistants", Icons.person_2_rounded,
                                '/Myassistants', context),
                            buildCard("Subjects", Icons.subject_rounded,
                                '/levels', context),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  String url = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController examUrl = TextEditingController();
  TextEditingController nameController = TextEditingController();

  Future<void> checkExams(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 24, 24, 24),
          title: const Text(
            'Exam Data',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          content: Form(
            key: _formKey, // Assign the key to the Form widget
            child: Column(
              mainAxisSize: MainAxisSize
                  .min, // Ensure the column doesn't take up unnecessary space
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter correct exam name';
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter correct exam URL';
                    }
                    return null;
                  },
                  controller: examUrl,
                  decoration: const InputDecoration(
                    labelText: 'URL',
                    labelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Cancel',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text(
                'Add',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();

                  Map<String, dynamic> examData = {
                    'Name': nameController.text, // Get the Name field
                    'URL': examUrl.text, // Get the URL field
                    'Active': true
                  };

                  await FirebaseFirestore.instance
                      .collection('Exams')
                      .doc(nameController.text) // Use Name as the document ID
                      .set(examData);

                  Navigator.of(context).pop(); // Close the dialog
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> getExams(BuildContext context) async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('Exams').get();

    if (querySnapshot.docs.isEmpty) {
      // No exams found
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No exams available')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: const Text('Select an Exam'),
            content: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: querySnapshot.docs.length,
                    itemBuilder: (context, index) {
                      final doc = querySnapshot.docs[index];
                      final examName = doc.id;
                      final examUrl = doc['URL'];
                      final bool isActive = doc['Active'];
                      return ListTile(
                        title: Text(examName),
                        subtitle: Text('URL: $examUrl\nActive: $isActive'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                editExam(doc.id, doc.data(), context);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                deleteExam(doc.id, context);
                              },
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ));
            }));
      },
    );
  }

  void deleteExam(String examId, BuildContext context) async {
    await FirebaseFirestore.instance.collection('Exams').doc(examId).delete();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Exam deleted successfully')),
    );
  }

  void editExam(
      String examId, Map<String, dynamic> examData, BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: examData['Name']);
    TextEditingController urlController =
        TextEditingController(text: examData['URL']);
    bool isActive = examData['Active'];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Exam'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Form(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: urlController,
                      decoration: const InputDecoration(labelText: 'URL'),
                    ),
                    const SizedBox(height: 10),
                    CheckboxListTile(
                      title: const Text('Active'),
                      value: isActive,
                      onChanged: (newValue) {
                        setState(() {
                          isActive = newValue!;
                        });
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'Close',
                style: TextStyle(fontSize: 20),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Save'),
              onPressed: () async {
                await FirebaseFirestore.instance
                    .collection('Exams')
                    .doc(examId)
                    .update({
                  'Name': nameController.text,
                  'URL': urlController.text,
                  'Active': isActive,
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Exam updated successfully')),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void handleCardTap(String cardName, String route, BuildContext context) {
    switch (cardName) {
      case "Students":
        Navigator.pushNamed(context, route);
        break;
      case "Assistants":
        Navigator.pushNamed(context, route);
        break;
      case "Subjects":
        Navigator.pushNamed(context, route);
        break;
    }
  }

  Widget buildCard(
      String title, IconData icon, String route, BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovering1[title] = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovering1[title] = false;
        });
      },
      child: InkWell(
        onTap: () => handleCardTap(title, route, context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: _isHovering1[title]!
                  ? [
                      const Color.fromARGB(255, 128, 0, 0),
                      const Color.fromARGB(255, 152, 43, 28)
                    ]
                  : [const Color(0xFFC39770), const Color(0xFFC39770)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: _isHovering1[title]!
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.4),
                      blurRadius: 10,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: _isHovering1[title]!
                    ? const Color(0xFFB7F806)
                    : Colors.black,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: GoogleFonts.ultra(
                  fontSize: 20,
                  color: _isHovering1[title]!
                      ? const Color(0xFFB7F806)
                      : Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
