import 'package:othmath/AuthoCheck.dart';
import 'package:othmath/Pages/TeacherService/ViewNewStudents.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Assistantpage extends StatefulWidget {
  final String Name, ID, Email;
  const Assistantpage(
      {required this.Name, required this.ID, required this.Email, super.key});

  @override
  State<Assistantpage> createState() {
    return _Assistantpage(Email: Email, ID: ID, Name: Name);
  }
}

class _Assistantpage extends State<Assistantpage>
    with SingleTickerProviderStateMixin {
  final String Name, ID, Email;
  _Assistantpage({required this.Name, required this.ID, required this.Email});
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
      Navigator.pushNamed(
        context,'/'
  
      );
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
    "Tasks": false,
    "Assignments": false,
    "Videos": false,
    "Books": false,
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
                    "Role": "AS",
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
                            buildCard("Tasks", Icons.task_alt_rounded, '/tasks',
                                context),
                            buildCard("Assignments", Icons.assignment_add,
                                '/assigments', context),
                            buildCard("Videos", Icons.video_collection_rounded,
                                '/videos', context),
                            buildCard("Books", Icons.menu_book_rounded,
                                '/books', context),
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

  void handleCardTap(String cardName, String route, BuildContext context) {
    switch (cardName) {
      case "Students":
        Navigator.pushNamed(context, route);
        break;
      case "Assistants":
        Navigator.pushNamed(context, route);
        break;
      case "Tasks":
        Navigator.pushNamed(context, route);
        break;
      case "Assigments":
        Navigator.pushNamed(context, route);
        break;
      case "Videos":
        Navigator.pushNamed(context, route);
        break;
      case "Books":
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
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'YourCustomFont', // Add custom font here
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
