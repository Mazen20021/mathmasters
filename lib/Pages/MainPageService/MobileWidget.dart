import 'package:othmath/FireBase/UsersDataBase.dart';
import 'package:othmath/Pages/MainPageService/news.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html;

class MOBWidget extends StatefulWidget {
  const MOBWidget({super.key});

  @override
  State<MOBWidget> createState() {
    return _mobwidget();
  }
}

class _mobwidget extends State<MOBWidget> {
  bool _isHovering = false;
  final bool _isHovering1 = false;
  bool _isHovering2 = false;
  bool _isHovering3 = false;
  bool _isHovering4 = false;
  bool _isHovering5 = false;
  bool _isHovering6 = false;
  bool _isHovering7 = false;
  bool _isHovering8 = false;
  bool _isHovering9 = false;
  bool _isHovering10 = false;
  bool _isHovering11 = false;
  bool _isHovering12 = false;
  bool _isHovering13 = false;
  bool _isHovering14 = false;
  bool _isHovering15 = false;
  bool _isHovering16 = false;
  bool _isHovering100 = false;
  bool _isHovering20 = false;
  bool cemail = false;
  bool cpass = false;
  bool correctdata = false;
  String missingemail = "Student ID";
  String missingpass = "Student Name";
  String stem = "", stpass = "";

  Createusers lg = Createusers();
  bool _showpure = false;
  bool _showAppliedMath = false;
  @override
  Future<void> initialize() async {
    await Firebase.initializeApp();
    super.initState();
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
          _isHovering6 = hover;
        });
        break;
      case 3:
        setState(() {
          _isHovering2 = hover;
        });
        break;
      case 4:
        setState(() {
          _isHovering3 = hover;
        });
        break;
      case 5:
        setState(() {
          _isHovering4 = hover;
        });
        break;
      case 6:
        setState(() {
          _isHovering5 = hover;
        });
        break;
      case 7:
        setState(() {
          _isHovering20 = hover;
        });
        break;
      case 8:
        setState(() {
          _isHovering7 = hover;
        });

        break;
      case 9:
        setState(() {
          _isHovering8 = hover;
        });

        break;
      case 10:
        setState(() {
          _isHovering9 = hover;
        });

        break;
      case 11:
        setState(() {
          _isHovering10 = hover;
        });

        break;
      case 12:
        setState(() {
          _isHovering11 = hover;
        });

        break;
      case 13:
        setState(() {
          _isHovering12 = hover;
        });

        break;
      case 14:
        setState(() {
          _isHovering20 = hover;
        });

        break;
      case 15:
        setState(() {
          _isHovering13 = hover;
        });

        break;
      case 16:
        setState(() {
          _isHovering14 = hover;
        });

        break;
      case 21:
        setState(() {
          _isHovering16 = hover;
        });

        break;
      case 20:
        setState(() {
          _isHovering15 = hover;
        });

        break;
      case 100:
        setState(() {
          _isHovering100 = hover;
        });

        break;
      default:
        break;
    }
  }

  void launchGoogleMaps() async {
    const url =
        'https://www.google.com/maps/search/?api=1&query=30.065057,31.272531';
    html.window.open(url, 'new_tab'); // Use dart:html to open URL in new tab
  }

  void facebook() async {
    const url = 'https://www.facebook.com/profile.php?id=61561225986355';
    html.window.open(url, 'new_tab');
  }

  void youtube() async {
    const url = '';
    html.window.open(url, 'new_tab');
  }

  void _mainpage(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: SingleChildScrollView(
              child: Row(children: [
                MouseRegion(
                  onEnter: (event) => _onEnter(true, 13),
                  onExit: (event) => _onEnter(false, 13),
                  child: IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/news'),
                    icon: Icon(
                      Icons.newspaper_outlined,
                      size: screenWidth * 0.06,
                      color: _isHovering12
                          ? const Color.fromARGB(255, 207, 62, 51)
                          : const Color.fromARGB(255, 24, 24, 24),
                    ),
                  ),
                ),
                MouseRegion(
                  onEnter: (event) => _onEnter(true, 3),
                  onExit: (event) => _onEnter(false, 3),
                  child: IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/timetable'),
                    icon: Icon(
                      Icons.table_chart_rounded,
                      size: screenWidth * 0.06,
                      color: _isHovering2
                          ? const Color.fromARGB(255, 207, 62, 51)
                          : const Color.fromARGB(255, 24, 24, 24),
                    ),
                  ),
                ),
                MouseRegion(
                  onEnter: (event) => _onEnter(true, 4),
                  onExit: (event) => _onEnter(false, 4),
                  child: IconButton(
                    onPressed: launchGoogleMaps,
                    icon: Icon(
                      Icons.location_city_rounded,
                      size: screenWidth * 0.06,
                      color: _isHovering3
                          ? const Color.fromARGB(255, 207, 62, 51)
                          : const Color.fromARGB(255, 24, 24, 24),
                    ),
                  ),
                ),
                MouseRegion(
                  onEnter: (event) => _onEnter(true, 5),
                  onExit: (event) => _onEnter(false, 5),
                  child: IconButton(
                    onPressed: () => Navigator.pushNamed(context, '/aboutus'),
                    icon: Icon(
                      Icons.groups_rounded,
                      size: screenWidth * 0.06,
                      color: _isHovering4
                          ? const Color.fromARGB(255, 207, 62, 51)
                          : const Color.fromARGB(255, 24, 24, 24),
                    ),
                  ),
                ),
                const Spacer(flex: 100),
                MouseRegion(
                  onEnter: (event) => _onEnter(true, 15),
                  onExit: (event) => _onEnter(false, 15),
                  child: IconButton(
                    onPressed: () => {
                      Navigator.pushNamed(context, '/login'),
                    },
                    color: _isHovering13
                        ? const Color.fromARGB(255, 207, 62, 51)
                        : const Color.fromARGB(255, 24, 24, 24),
                    icon: Icon(
                      Icons.login_outlined,
                      size: screenWidth * 0.06,
                    ),
                  ),
                ),
              ]),
            ),
            elevation: 20,
            backgroundColor: const Color.fromARGB(255, 216, 209, 161),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: Form(
                  child: Column(children: [
                    Container(
                      color: const Color.fromARGB(255, 21, 32, 26),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.001,
                        vertical: screenHeight * 0.01,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 250,
                            width: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.asset('assets/images/blob.jpeg',
                                  fit: BoxFit.cover),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                              child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "MR. Othman Mostafa",
                                  style: GoogleFonts.ultra(
                                    fontSize: screenWidth * 0.045,
                                    color: const Color.fromARGB(
                                        255, 214, 214, 247),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "G. Math Teacher",
                                  style: GoogleFonts.pacifico(
                                    fontSize: screenWidth * 0.04,
                                    color: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                ),
                                const SizedBox(height: 50),
                                MouseRegion(
                                    onEnter: (event) => _onEnter(true, 10),
                                    onExit: (event) => _onEnter(false, 10),
                                    child: ElevatedButton(
                                        style: ButtonStyle(
                                          backgroundColor:
                                              WidgetStateProperty.all(
                                            _isHovering9
                                                ? const Color.fromARGB(
                                                    255, 221, 172, 107)
                                                : const Color.fromARGB(
                                                    255, 255, 255, 255),
                                          ),
                                        ),
                                        onPressed: () => Navigator.pushNamed(
                                            context, '/register'),
                                        child: Text(
                                          "Register Now",
                                          style: TextStyle(
                                              color: const Color.fromARGB(
                                                  255, 0, 0, 0),
                                              fontSize: screenWidth * 0.03),
                                        )))
                              ],
                            ),
                          )),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.03,
                        vertical: screenHeight * 0.03,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Our Programs",
                            style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: MouseRegion(
                                  child: Column(
                                    children: [
                                      InkWell(
                                        onTap: () => setState(() {
                                          _showpure = !_showpure;
                                        }),
                                        child: MouseRegion(
                                          onEnter: (event) => _onEnter(true, 2),
                                          onExit: (event) => _onEnter(false, 2),
                                          child: Container(
                                            padding: const EdgeInsets.all(16),
                                            decoration: BoxDecoration(
                                              color: _isHovering6
                                                  ? Colors.lightBlue[50]
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.3),
                                                  spreadRadius: 2,
                                                  blurRadius: 5,
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.calculate,
                                                    size: 40,
                                                    color: Colors
                                                        .blue), // Added calculator icon
                                                const SizedBox(height: 8),
                                                Text(
                                                  "Pure Mathematics",
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.025,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                  "Explore a wide range of math courses designed to help you master mathematical concepts and problem-solving techniques.",
                                                  style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.019,
                                                  ),
                                                ),
                                                if (_showpure) Pure(),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                  child: MouseRegion(
                                child: Column(children: [
                                  InkWell(
                                    onTap: () => {print("Statistics")},
                                    child: MouseRegion(
                                        onEnter: (event) => _onEnter(true, 8),
                                        onExit: (event) => _onEnter(false, 8),
                                        child: Container(
                                          padding: const EdgeInsets.all(16),
                                          decoration: BoxDecoration(
                                            color: _isHovering7
                                                ? Colors.lightBlue[50]
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.3),
                                                spreadRadius: 2,
                                                blurRadius: 5,
                                              ),
                                            ],
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Icon(Icons.auto_graph,
                                                  size: 40,
                                                  color: Colors.green),
                                              const SizedBox(height: 8),
                                              Text(
                                                "Statistics",
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.025,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                "Learn how to analyze and interpret data, and make data-driven decisions with our comprehensive statistics courses.",
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.019,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )),
                                  )
                                ]),
                              )),
                              const SizedBox(width: 16),
                              Expanded(
                                  child: MouseRegion(
                                      child: Column(children: [
                                InkWell(
                                  onTap: () => setState(() {
                                    _showAppliedMath = !_showAppliedMath;
                                  }),
                                  child: MouseRegion(
                                      onEnter: (event) => _onEnter(true, 9),
                                      onExit: (event) => _onEnter(false, 9),
                                      child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                          color: _isHovering8
                                              ? Colors.lightBlue[50]
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.3),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                            ),
                                          ],
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(Icons.car_repair,
                                                size: 40,
                                                color: Color.fromARGB(
                                                    255, 185, 34, 7)),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Applied Mathematics",
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.025,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              "Understand how forces interact in systems at rest. analyzing and solving problems related to equilibrium, structures and more",
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.019,
                                              ),
                                            ),
                                            if (_showAppliedMath) applied(),
                                          ],
                                        ),
                                      )),
                                ),
                              ])))
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.01,
                          vertical: screenHeight * 0.001,
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: screenWidth * 0.45),
                            IconButton(
                                onPressed: () => facebook(),
                                icon: Icon(
                                  Icons.facebook_rounded,
                                  color: const Color.fromARGB(255, 51, 64, 177),
                                  size: screenWidth * 0.08,
                                )),
                            IconButton(
                                onPressed: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((_) =>
                                            const UnderDevelopmentPage()))), //_toggleChat,
                                icon: Icon(
                                  Icons.video_camera_front_rounded,
                                  color:
                                      const Color.fromARGB(255, 172, 26, 106),
                                  size: screenWidth * 0.08,
                                )),
                          ],
                        )),
                  ]),
                ),
              );
            },
          ));
    });
  }

  Widget applied() {
    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;
      return Row(
        children: [
          Expanded(
              child: Column(
            children: [
              InkWell(
                onTap: () => {print("statics")},
                child: MouseRegion(
                  onEnter: (event) => _onEnter(true, 11),
                  onExit: (event) => _onEnter(false, 11),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _isHovering10
                          ? Colors.lightBlue[50]
                          : const Color.fromARGB(255, 245, 160, 104),
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
                        const Icon(Icons.balance_rounded,
                            size: 40,
                            color: Color.fromARGB(
                                255, 1, 156, 177)), // Added calculator icon
                        const SizedBox(height: 8),
                        Text(
                          "Statics",
                          style: TextStyle(
                            fontSize: screenWidth * 0.17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => {print("dynamics")},
                child: MouseRegion(
                    onEnter: (event) => _onEnter(true, 12),
                    onExit: (event) => _onEnter(false, 12),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _isHovering11
                            ? Colors.lightBlue[50]
                            : const Color.fromARGB(255, 90, 194, 235),
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
                          const Icon(Icons.motorcycle_outlined,
                              size: 40,
                              color: Color.fromARGB(255, 199, 60, 18)),
                          const SizedBox(height: 8),
                          Text(
                            "Dynamics",
                            style: TextStyle(
                              fontSize: screenWidth * 0.15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    )),
              ),
            ],
          ))
        ],
      );
    });
  }

  Widget Pure() {
    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;
      return Row(
        children: [
          Expanded(
              child: Column(
            children: [
              InkWell(
                onTap: () => {print("Alg")},
                child: MouseRegion(
                    onEnter: (event) => _onEnter(true, 20),
                    onExit: (event) => _onEnter(false, 20),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _isHovering15
                            ? Colors.lightBlue[50]
                            : const Color.fromARGB(255, 247, 123, 123),
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
                          const Icon(Icons.functions_rounded,
                              size: 40, color: Color.fromARGB(255, 9, 85, 129)),
                          const SizedBox(height: 8),
                          Text(
                            "Algebra",
                            style: TextStyle(
                              fontSize: screenWidth * 0.15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    )),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => {print("trig")},
                child: MouseRegion(
                    onEnter: (event) => _onEnter(true, 15),
                    onExit: (event) => _onEnter(false, 15),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _isHovering13
                            ? Colors.lightBlue[50]
                            : const Color.fromARGB(255, 176, 148, 255),
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
                          const Icon(Icons.shape_line_rounded,
                              size: 40, color: Color.fromARGB(255, 9, 85, 129)),
                          const SizedBox(height: 8),
                          Text(
                            "Trigonometry",
                            style: TextStyle(
                              fontSize: screenWidth * 0.11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    )),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => {print("trig")},
                child: MouseRegion(
                    onEnter: (event) => _onEnter(true, 16),
                    onExit: (event) => _onEnter(false, 16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _isHovering14
                            ? Colors.lightBlue[50]
                            : const Color.fromARGB(255, 238, 113, 165),
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
                          const Icon(Icons.format_shapes_rounded,
                              size: 40, color: Color.fromARGB(255, 9, 85, 129)),
                          const SizedBox(height: 8),
                          Text(
                            "Solid Geometry",
                            style: TextStyle(
                              fontSize: screenWidth * 0.12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    )),
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => {print("calc")},
                child: MouseRegion(
                  onEnter: (event) => _onEnter(true, 21),
                  onExit: (event) => _onEnter(false, 21),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _isHovering16
                          ? Colors.lightBlue[50]
                          : const Color.fromARGB(255, 104, 218, 161),
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
                        const Icon(Icons.area_chart_rounded,
                            size: 40,
                            color: Color.fromARGB(
                                255, 243, 36, 9)), // Added calculator icon
                        const SizedBox(height: 8),
                        Text(
                          "Calculus",
                          style: TextStyle(
                            fontSize: screenWidth * 0.15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
        ],
      );
    });
  }
}
