import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:othmath/AuthoCheck.dart';
import 'dart:html' as html;

import 'package:othmath/Pages/MainPageService/news.dart';

class Studmob extends StatefulWidget {
  final String email, name;
  const Studmob({required this.email, required this.name, super.key});
  @override
  _Studmob createState() => _Studmob(email: email, name: name);
}

class _Studmob extends State<Studmob> {
  final String email, name;
  _Studmob({required this.email, required this.name});

  final double _leftPosition = 0;
  final bool _movingRight = true;
  final bool _isHovering0 = false;
  final bool _isHovering1 = false;
  final bool _isHovering2 = false;
  final bool _isHovering3 = false;
  final bool _isHovering4 = false;
  final bool _isHovering5 = false;
  final bool _isHovering6 = false;
  final bool _isHovering7 = false;
  final bool _isHovering8 = false;
  final bool _isHovering9 = false;
  final bool _isHovering10 = false;
  final bool _isHovering11 = false;
  final bool _isHovering12 = false;
  final bool _isHovering13 = false;
  final bool _isHovering14 = false;
  final bool _isHovering15 = false;
  final bool _isHovering16 = false;
  final bool _isHovering20 = false;
  late String Name = name;

  void launchGoogleMaps() async {
    const url =
        'https://www.google.com/maps/search/?api=1&query=30.065057,31.272531';
    html.window.open(url, 'new_tab'); // Use dart:html to open URL in new tab
  }

  void facebook() async {
    const url = 'https://www.facebook.com/share/MvaBA3RsSSJtWA6z/';
    html.window.open(url, 'new_tab');
  }

  void youtube() async {
    const url = '';
    html.window.open(url, 'new_tab');
  }

  @override
  void initState() {
    getData();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  String userpoints = "0";
  final bool _showpure = false;
  final bool _showAppliedMath = false;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String userName = "";
  final List<bool> _Hover = List.generate(18, (index) => false);
  Future<void> getData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (email.isEmpty) {
        // No need to check for null anymore
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email is empty')),
        );
        _isLoading = false;
        return;
      }

      QuerySnapshot querySnapshot = await _firestore
          .collection("Students")
          .where("Email", isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        DocumentSnapshot userDoc = querySnapshot.docs.first;
        setState(() {
          userName = userDoc['Name'] ?? '';
          // Check if there is a space in the name
          int spaceIndex = userName.indexOf(" ");
          if (spaceIndex != -1) {
            userName = userName.substring(0, spaceIndex);
            _isLoading = false;
          }
          _isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('No user found with the email $email')),
        );
      }
    } catch (e, stacktrace) {
      print('Error fetching user data: $e');
      print(stacktrace);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user data: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onEnter(bool hover, int num) {
    setState(() {
      switch (num) {
        case 0:
          _Hover[0] = hover;
          break;
        case 1:
          _Hover[1] = hover;
          break;
        case 2:
          _Hover[2] = hover;
          break;
        case 3:
          _Hover[3] = hover;
          break;
        case 4:
          _Hover[4] = hover;
          break;
        case 5:
          _Hover[5] = hover;
          break;
        case 6:
          _Hover[6] = hover;
          break;
        case 7:
          _Hover[7] = hover;
          break;
        case 8:
          _Hover[8] = hover;
          break;
        case 9:
          _Hover[9] = hover;
          break;
        case 10:
          _Hover[10] = hover;
          break;
        case 11:
          _Hover[11] = hover;
          break;
        case 12:
          _Hover[12] = hover;
          break;
        case 13:
          _Hover[13] = hover;
          break;
        case 14:
          _Hover[14] = hover;
          break;
        case 15:
          _Hover[15] = hover;
          break;
        case 16:
          _Hover[16] = hover;
          break;
        case 17:
          _Hover[17] = hover;
          break;
        default:
          break;
      }
    });
  }

  TextEditingController messagesCont = TextEditingController();

  List<Map<String, dynamic>> messages = [
    {
      "sender": "bot",
      "text": "Hello, I am ChatBot v1.0  How can I help you ?",
      "icon": const Icon(Icons.android_outlined)
    },
  ];

  void sendMessage(String message) {
    if (message.isNotEmpty) {
      setState(() {
        messages.add({
          "sender": "user",
          "text": message,
          "icon": const Icon(Icons.account_circle)
        });
        messagesCont.clear();
      });
      // Simulate a bot response after a short delay
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          botmessage(message);
        });
      });
    }
  }

  bool _isclicked = true;
  final List<Map<String, dynamic>> Peoples = [
    {"Name": "", "icon": Icons.android_outlined},
    {"Name": "Support", "icon": Icons.support_agent_rounded},
    {"Name": "Mr Othman", "icon": Icons.person_3},
    {"Name": "Charlie", "icon": Icons.person},
  ];
  String UName = "";
  Widget getPeople(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: const Color.fromARGB(255, 17, 153, 119).withOpacity(0.5)),
        height: 250,
        child: ListView.builder(
            itemCount: Peoples.length - 1,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Peoples[index]["icon"]),
                title: Text(Peoples[index]["Name"]),
                onTap: () => {
                  setState(() {
                    UName = Peoples[index]["Name"];
                    if (UName == "") {
                      UName = "ChatBot v1.0";
                      _isListClicked = false;
                      _isNameChanged = true;
                    } else {
                      UName = Peoples[index]["Name"];
                      _isListClicked = false;
                      _isNameChanged = false;
                    }

                    messages.clear();
                  })
                },
              );
            }));
  }

  bool _isListClicked = false;
  bool _isNameChanged = true;

  Widget _openchat(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Align(
      alignment: const AlignmentDirectional(1, 1),
      child: _isclicked
          ? Container(
              alignment: Alignment.bottomRight,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: 300,
              height: 50,
              child: Card(
                color: Colors.white,
                elevation: 20,
                child: InkWell(
                  onTap: () => {
                    setState(() {
                      if (_isclicked) {
                        _isclicked = false;
                      } else {
                        _isclicked = true;
                      }
                    })
                  },
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    Container(
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 17, 153, 119),
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        children: [
                          _isNameChanged
                              ? const Icon(Icons.android_outlined,
                                  size: 30,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  weight: 10,
                                  shadows: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          offset: Offset(1, 2),
                                          color: Colors.black)
                                    ])
                              : const Icon(
                                  Icons.person,
                                  size: 30,
                                  color: Color.fromARGB(255, 255, 255, 255),
                                  weight: 10,
                                  shadows: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        offset: Offset(1, 2),
                                        color: Colors.black)
                                  ],
                                ),
                          const SizedBox(width: 2),
                          _isNameChanged
                              ? const Text("ChatBot v1.0",
                                  style: TextStyle(
                                    color: Colors.white,
                                    shadows: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          offset: Offset(1, 2),
                                          color: Colors.black)
                                    ],
                                  ))
                              : Text(UName,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    shadows: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          offset: Offset(1, 2),
                                          color: Colors.black)
                                    ],
                                  ))
                        ],
                      ),
                    ),
                  ]),
                ),
              ),
            )
          : Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              width: 300,
              height: 400,
              child: Card(
                color: Colors.white,
                elevation: 20,
                child: Column(children: [
                  InkWell(
                      onTap: () => {
                            setState(() {
                              if (_isclicked) {
                                _isclicked = false;
                              } else {
                                _isclicked = true;
                              }
                            })
                          },
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 17, 153, 119),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            _isNameChanged
                                ? const Icon(Icons.android_outlined,
                                    size: 30,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    weight: 10,
                                    shadows: [
                                        BoxShadow(
                                            blurRadius: 10,
                                            offset: Offset(1, 2),
                                            color: Colors.black)
                                      ])
                                : const Icon(
                                    Icons.person,
                                    size: 30,
                                    color: Color.fromARGB(255, 255, 255, 255),
                                    weight: 10,
                                    shadows: [
                                      BoxShadow(
                                          blurRadius: 10,
                                          offset: Offset(1, 2),
                                          color: Colors.black)
                                    ],
                                  ),
                            const SizedBox(width: 2),
                            _isNameChanged
                                ? const Text("ChatBot v1.0",
                                    style: TextStyle(
                                      color: Colors.white,
                                      shadows: [
                                        BoxShadow(
                                            blurRadius: 10,
                                            offset: Offset(1, 2),
                                            color: Colors.black)
                                      ],
                                    ))
                                : Text(UName,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      shadows: [
                                        BoxShadow(
                                            blurRadius: 10,
                                            offset: Offset(1, 2),
                                            color: Colors.black)
                                      ],
                                    )),
                            const SizedBox(width: 105),
                            IconButton(
                              onPressed: () => {
                                setState(() {
                                  if (_isListClicked) {
                                    _isListClicked = false;
                                  } else {
                                    _isListClicked = true;
                                  }
                                })
                              },
                              icon: const Icon(Icons.list_rounded,
                                  color: Colors.white),
                            ),
                          ],
                        ),
                      )),
                  if (_isListClicked) getPeople(context),
                  Expanded(
                    child: ListView.builder(
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        bool isBot = messages[index]["sender"] == "bot";
                        return ListTile(
                          title: Align(
                            alignment: isBot
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              width:
                                  messages[index]["text"].toString().length < 5
                                      ? 70
                                      : 500,
                              decoration: BoxDecoration(
                                color: isBot
                                    ? const Color.fromARGB(255, 250, 185, 185)
                                    : const Color.fromARGB(255, 151, 255, 215),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    messages[index]["icon"] as Widget,
                                    const SizedBox(width: 5),
                                    messages[index]["text"].toString().length <
                                            10
                                        ? Text(
                                            messages[index]["text"] ?? "",
                                          )
                                        : Expanded(
                                            child: Text(
                                            messages[index]["text"] ?? "",
                                            overflow: TextOverflow.visible,
                                            softWrap: true,
                                          ))
                                  ]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: messagesCont,
                            decoration: InputDecoration(
                              hintText: "Enter your message",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        IconButton(
                          onPressed: () {
                            sendMessage(messagesCont.text);
                          },
                          icon: const Icon(Icons.send),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ),
    );
  }

  void botmessage(String message) {
    if (UName != "ChatBot v1.0") {
      //Do FireBase Live Chat
    } else {
      if (message.contains("help") || message.contains("Help")) {
        messages.add({
          "sender": "bot",
          "text": "Hi, Here is what I can do",
          "icon": const Icon(Icons.android_outlined)
        });
        messages.add({
          "sender": "bot",
          "text": "1- Site Problem (Site) or (1)",
          "icon": const Icon(Icons.android_outlined)
        });
        messages.add({
          "sender": "bot",
          "text": "2- Homework Problem (Homework) or (2)",
          "icon": const Icon(Icons.android_outlined)
        });
        messages.add({
          "sender": "bot",
          "text": "3- Information About Site (Info) or (3)",
          "icon": const Icon(Icons.android_outlined)
        });
      } else if (message.contains("hi") || message.contains("Hi")) {
        messages.add({
          "sender": "bot",
          "text": "Hi, Here is what I can do",
          "icon": const Icon(Icons.android_outlined)
        });
        messages.add({
          "sender": "bot",
          "text": "1- Site Problem (Site) or (1)",
          "icon": const Icon(Icons.android_outlined)
        });
        messages.add({
          "sender": "bot",
          "text": "2- Homework Problem (Homework) or (2)",
          "icon": const Icon(Icons.android_outlined)
        });
        messages.add({
          "sender": "bot",
          "text": "3- Information About Site (Info) or (3)",
          "icon": const Icon(Icons.android_outlined)
        });
      } else if (message.contains("1") ||
          message.contains("Site") ||
          message.contains("site")) {
        messages.add({
          "sender": "bot",
          "text":
              "You can tell me you problem and Eng.Mazen Will Reach You As soon as possible",
          "icon": const Icon(Icons.android_outlined)
        });
      } else if (message.contains("2") ||
          message.contains("Homework") ||
          message.contains("home") ||
          message.contains("homework")) {
        messages.add({
          "sender": "bot",
          "text": "You selected Homework Problem.",
          "icon": const Icon(Icons.android_outlined)
        });
      } else if (message.contains("3") ||
          message.contains("info") ||
          message.contains("information")) {
        messages.add({
          "sender": "bot",
          "text": "You selected Information About Site.",
          "icon": const Icon(Icons.android_outlined)
        });
      } else {
        messages.add({
          "sender": "bot",
          "text": "I could not get that. But Here is what I can do",
          "icon": const Icon(Icons.android_outlined)
        });
        messages.add({
          "sender": "bot",
          "text": "1- Site Problem (Site) or (1)",
          "icon": const Icon(Icons.android_outlined)
        });
        messages.add({
          "sender": "bot",
          "text": "2- Homework Problem (Homework) or (2)",
          "icon": const Icon(Icons.android_outlined)
        });
        messages.add({
          "sender": "bot",
          "text": "3- Information About Site (Info) or (3)",
          "icon": const Icon(Icons.android_outlined)
        });
      }
    }
  }

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
        context,"/",
      );
    }
  }

  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            _buildIconButton(
              context,
              Icons.logout_rounded,
              () => _logout(context),
              0,
            ),
            const Spacer(),
            _buildIconButton(
              context,
              Icons.bookmark_outlined,
              () => Navigator.pushNamed(context, "/honor"),
              1,
            ),
            const Spacer(),
            _buildIconButton(
              context,
              Icons.table_chart_rounded,
              () => Navigator.pushNamed(context, "/timetable"),
              2,
            ),
            const Spacer(),
            _buildIconButton(
              context,
              Icons.location_city_rounded,
              launchGoogleMaps,
              3,
            ),
            const Spacer(),
            _buildIconButton(context, Icons.groups_rounded,
                () => Navigator.pushNamed(context, "/aboutus"), 4),
            const Spacer(),
            Text(userpoints + " oths")
          ],
        ),
        elevation: 20,
        backgroundColor: const Color.fromARGB(255, 255, 249, 208),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                _buildWelcomeSection(screenHeight),
                const SizedBox(height: 40),
                _buildServicesSection(),
                SizedBox(height: screenHeight * 0.05),
                Align(
                  alignment: Alignment.bottomRight,
                  child: _openchat(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIconButton(
      BuildContext context, IconData icon, VoidCallback onPressed, int index) {
    return MouseRegion(
      onEnter: (event) => _onEnter(true, index),
      onExit: (event) => _onEnter(false, index),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, size: 37),
        color: _Hover[index]
            ? const Color.fromARGB(255, 255, 121, 97)
            : const Color.fromARGB(255, 42, 157, 143),
      ),
    );
  }

  Widget _buildWelcomeSection(double screenHeight) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 21, 32, 26),
            Color.fromARGB(255, 42, 157, 143)
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: screenHeight * 0.03,
      ),
      child: Center(
        child: Column(
          children: [
            !_isLoading
                ? Column(
                    children: [
                      Text(
                        "Welcome Back",
                        style: GoogleFonts.ultra(
                          fontSize: 45,
                          color: const Color.fromARGB(255, 244, 241, 222),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        userName,
                        style: GoogleFonts.ultra(
                          fontSize: 30,
                          color: const Color.fromARGB(255, 244, 241, 222),
                        ),
                      ),
                    ],
                  )
                : const CircularProgressIndicator(
                    backgroundColor: Colors.brown,
                    color: Colors.white,
                  )
          ],
        ),
      ),
    );
  }

  Widget _buildServicesSection() {
    return LayoutBuilder(builder: (context, Constraints) {
      final screenWidth = MediaQuery.of(context).size.width;
      final screenHeight = MediaQuery.of(context).size.height;
      return Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.1,
          vertical: screenHeight * 0.1,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Services",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 135, 38, 155)),
            ),
            const SizedBox(height: 8),
            const Divider(
                color: Color.fromARGB(255, 135, 38, 155), thickness: 5),
            Row(
              children: [
                Expanded(
                  child: _buildProgramCard(
                    "Grades",
                    Icons.grading_outlined,
                    "See your over all Grades in all subjects",
                    _Hover[7],
                    () => _onEnter(true, 7),
                    () => _onEnter(false, 7),
                    const Color.fromARGB(255, 135, 38, 155),
                    const Color.fromARGB(255, 55, 85, 68),
                    () => {},
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildProgramCard(
                    "Buy Videos",
                    Icons.monetization_on_rounded,
                    "Now you can buy online videos' codes",
                    _Hover[8],
                    () => _onEnter(true, 8),
                    () => _onEnter(false, 8),
                    const Color.fromARGB(255, 135, 38, 155),
                    const Color.fromARGB(255, 55, 85, 68),
                    () => print("Trigonometry"),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildProgramCard(
                    "Community",
                    Icons.groups_3_sharp,
                    "Chat, Ask Questions and Get Answers",
                    _Hover[16],
                    () => _onEnter(true, 16),
                    () => _onEnter(false, 16),
                    const Color.fromARGB(255, 135, 38, 155),
                    const Color.fromARGB(255, 55, 85, 68),
                    () {
                      Navigator.pushNamed(context, "/community", arguments: {
                        "Email": email,
                        "Role": "",
                      });
                    },
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildProgramCard(
                    "Point shop",
                    Icons.shopify_rounded,
                    "Use your earned points to buy",
                    _Hover[9],
                    () => _onEnter(true, 9),
                    () => _onEnter(false, 9),
                    const Color.fromARGB(255, 135, 38, 155),
                    const Color.fromARGB(255, 55, 85, 68),
                    () => print("Calculus"),
                  ),
                )
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              "Pure Mathematics",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 45, 92, 173)),
            ),
            const SizedBox(height: 8),
            const Divider(
                color: Color.fromARGB(255, 45, 92, 173), thickness: 5),

            Row(
              children: [
                Expanded(
                  child: _buildProgramCard(
                    "Algebra",
                    Icons.functions_rounded,
                    "Learn the foundational algebraic principles, from basic equations.",
                    _Hover[10],
                    () => _onEnter(true, 10),
                    () => _onEnter(false, 10),
                    const Color.fromARGB(255, 45, 92, 173),
                    const Color.fromARGB(255, 55, 85, 68),
                    () => Navigator.pushNamed(context, '/mysubjects',
                        arguments: {"Name": "Algebra", "role": ""}),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildProgramCard(
                    "Trigonometry",
                    Icons.shape_line_rounded,
                    "Explore the relationships between the angles and sides of triangles.",
                    _Hover[11],
                    () => _onEnter(true, 11),
                    () => _onEnter(false, 11),
                    const Color.fromARGB(255, 45, 92, 173),
                    const Color.fromARGB(255, 55, 85, 68),
                    () => Navigator.pushNamed(context, '/mysubjects',
                        arguments: {"Name": "Trignometry", "role": ""}),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildProgramCard(
                    "Solid Geometry",
                    Icons.format_shapes_rounded,
                    "Understand the properties and relationships of geometric solids.",
                    _Hover[12],
                    () => _onEnter(true, 12),
                    () => _onEnter(false, 12),
                    const Color.fromARGB(255, 45, 92, 173),
                    const Color.fromARGB(255, 55, 85, 68),
                    () => Navigator.pushNamed(context, '/mysubjects',
                        arguments: {"Name": "Solid Geometry", "role": ""}),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: _buildProgramCard(
                    "Calculus",
                    Icons.area_chart_rounded,
                    "Dive into the world of limits, derivatives, integrals, and their applications.",
                    _Hover[13],
                    () => _onEnter(true, 13),
                    () => _onEnter(false, 13),
                    const Color.fromARGB(255, 45, 92, 173),
                    const Color.fromARGB(255, 55, 85, 68),
                    () => Navigator.pushNamed(context, '/mysubjects',
                        arguments: {"Name": "Calculus", "role": ""}),
                  ),
                )
              ],
            ),
            const SizedBox(height: 32),

            // Applied Mathematics Section
            const Text(
              "Applied Mathematics",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 187, 55, 45)),
            ),
            const SizedBox(height: 8),
            const Divider(
                color: Color.fromARGB(255, 187, 55, 45), thickness: 5),
            Row(
              children: [
                Expanded(
                  child: _buildProgramCard(
                    "Statics",
                    Icons.balance_rounded,
                    "Understand how forces interact in systems at rest, analyzing and solving problems related",
                    _Hover[14],
                    () => _onEnter(true, 14),
                    () => _onEnter(false, 14),
                    const Color.fromARGB(255, 187, 55, 45),
                    const Color.fromARGB(255, 55, 85, 68),
                    () => Navigator.pushNamed(context, '/mysubjects',
                        arguments: {"Name": "Statics", "role": ""}),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: _buildProgramCard(
                    "Dynamics",
                    Icons.motorcycle_outlined,
                    "Learn how to analyze and interpret motion in systems, from particles to complex machinery.",
                    _Hover[15],
                    () => _onEnter(true, 15),
                    () => _onEnter(false, 15),
                    const Color.fromARGB(255, 187, 55, 45),
                    const Color.fromARGB(255, 55, 85, 68),
                    () => Navigator.pushNamed(context, '/mysubjects',
                        arguments: {"Name": "Dynamics", "role": ""}),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    });
  }

// Custom Method to Build Program Cards
  Widget _buildProgramCard(
    String title,
    IconData icon,
    String description,
    bool isHovering,
    VoidCallback onEnter,
    VoidCallback onExit,
    Color hoverColor,
    Color? baseColor,
    VoidCallback onTap,
  ) {
    return LayoutBuilder(builder: (context, constrains) {
      return Container(
          width: constrains.maxWidth,
          child: InkWell(
            onTap: onTap,
            child: MouseRegion(
              onEnter: (event) => onEnter(),
              onExit: (event) => onExit(),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isHovering ? hoverColor : baseColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon,
                        size: 40,
                        color: const Color.fromARGB(255, 255, 255, 255)),
                    const SizedBox(height: 8),
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }

  // String url = "";
  // Future<void> checkExams(BuildContext context) async {
  //   // Fetch all documents where 'Entered' is false
  //   final querySnapshot = await FirebaseFirestore.instance
  //       .collection('Exams')
  //       .where("Active", isEqualTo: true)
  //       .get();

  //   if (querySnapshot.docs.isEmpty) {
  //     // No exams found
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('No exams available')),
  //     );
  //     return;
  //   }

  //   // Display the exams in a dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Select an Exam'),
  //         content: SizedBox(
  //           width: double.maxFinite,
  //           child: ListView.builder(
  //             shrinkWrap: true,
  //             itemCount: querySnapshot.docs.length,
  //             itemBuilder: (context, index) {
  //               final doc = querySnapshot.docs[index];
  //               final examName = doc.id;
  //               final examUrl = doc['URL'];
  //               return ListTile(
  //                 title: Text(examName),
  //                 onTap: () {
  //                   doExams(examUrl);
  //                   Navigator.of(context).pop();
  //                 },
  //               );
  //             },
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('Cancel'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
