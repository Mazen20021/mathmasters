import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:google_fonts/google_fonts.dart';

import 'news.dart';

class WinWidget extends StatefulWidget {
  const WinWidget({super.key});

  @override
  State<WinWidget> createState() {
    return _windwidget();
  }
}

class _windwidget extends State<WinWidget> {
  bool _isHovering = false;
  bool _isHovering1 = false;
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
  bool _isHovering17 = false;
  bool _isHovering18 = false;
  bool cemail = false;
  bool cpass = false;
  bool correctdata = false;
  String missingemail = "Student ID";
  String missingpass = "Student Name";

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
          _isHovering1 = hover;
        });
        break;
      case 2:
        setState(() {
          _isHovering2 = hover;
        });
        break;
      case 3:
        setState(() {
          _isHovering3 = hover;
        });
        break;
      case 4:
        setState(() {
          _isHovering4 = hover;
        });
        break;
      case 5:
        setState(() {
          _isHovering5 = hover;
        });
        break;
      case 6:
        setState(() {
          _isHovering6 = hover;
        });
        break;
      case 7:
        setState(() {
          _isHovering7 = hover;
        });
        break;
      case 8:
        setState(() {
          _isHovering8 = hover;
        });

        break;
      case 9:
        setState(() {
          _isHovering9 = hover;
        });

        break;
      case 10:
        setState(() {
          _isHovering10 = hover;
        });

        break;
      case 11:
        setState(() {
          _isHovering11 = hover;
        });

        break;
      case 12:
        setState(() {
          _isHovering12 = hover;
        });

        break;
      case 13:
        setState(() {
          _isHovering13 = hover;
        });

        break;
      case 14:
        setState(() {
          _isHovering14 = hover;
        });

        break;
      case 15:
        setState(() {
          _isHovering15 = hover;
        });

        break;
      case 16:
        setState(() {
          _isHovering16 = hover;
        });
        break;
      case 17:
        setState(() {
          _isHovering17 = hover;
        });

        break;
      case 18:
        setState(() {
          _isHovering18 = hover;
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

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Row(children: [
              MouseRegion(
                onEnter: (event) => _onEnter(true, 1),
                onExit: (event) => _onEnter(false, 1),
                child: IconButton(
                  onPressed: () => Navigator.pushNamed(context, '/news'),
                  icon: Icon(
                    Icons.newspaper_outlined,
                    size: 37,
                    color: _isHovering1
                        ? const Color.fromARGB(255, 207, 62, 51)
                        : const Color.fromARGB(255, 24, 24, 24),
                  ),
                ),
              ),
              const Spacer(flex: 10),
              MouseRegion(
                onEnter: (event) => _onEnter(true, 2),
                onExit: (event) => _onEnter(false, 2),
                child: IconButton(
                  onPressed: () => Navigator.pushNamed(context, '/timetable'),
                  icon: Icon(
                    Icons.table_chart_rounded,
                    size: 37,
                    color: _isHovering2
                        ? const Color.fromARGB(255, 207, 62, 51)
                        : const Color.fromARGB(255, 24, 24, 24),
                  ),
                ),
              ),
              const Spacer(flex: 10),
              MouseRegion(
                onEnter: (event) => _onEnter(true, 3),
                onExit: (event) => _onEnter(false, 3),
                child: IconButton(
                  onPressed: launchGoogleMaps,
                  icon: Icon(
                    Icons.location_city_rounded,
                    size: 37,
                    color: _isHovering3
                        ? const Color.fromARGB(255, 207, 62, 51)
                        : const Color.fromARGB(255, 24, 24, 24),
                  ),
                ),
              ),
              const Spacer(flex: 10),
              MouseRegion(
                onEnter: (event) => _onEnter(true, 4),
                onExit: (event) => _onEnter(false, 4),
                child: IconButton(
                  onPressed: () => Navigator.pushNamed(context, '/aboutus'),
                  icon: Icon(
                    Icons.groups_rounded,
                    size: 37,
                    color: _isHovering4
                        ? const Color.fromARGB(255, 207, 62, 51)
                        : const Color.fromARGB(255, 24, 24, 24),
                  ),
                ),
              ),
              const Spacer(flex: 100),
              const SizedBox(width: 5),
              // if (_isclicked) fields(),
              MouseRegion(
                onEnter: (event) => _onEnter(true, 5),
                onExit: (event) => _onEnter(false, 5),
                child: IconButton(
                  onPressed: () => {
                    Navigator.pushNamed(context, '/login'),
                  },
                  color: _isHovering5
                      ? const Color.fromARGB(255, 207, 62, 51)
                      : const Color.fromARGB(255, 24, 24, 24),
                  icon: const Icon(
                    Icons.login_outlined,
                    size: 37,
                  ),
                ),
              ),
            ]),
            elevation: 20,
            backgroundColor: const Color.fromARGB(255, 216, 209, 161),
          ),
          body: LayoutBuilder(builder: (context, constraints) {
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
                      height: 480,
                      width: 280,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset('assets/images/blob.jpeg',
                            fit: BoxFit.cover,
                            height: 280, // Adjusted height
                            width: 220, // Adjusted width
                            scale: 0.001),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                        child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            style: GoogleFonts.ultra(
                              fontSize: 50,
                              color: const Color.fromARGB(255, 214, 214, 247),
                            ),
                            "MR. Othman Mostafa",
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "G. Math Teacher",
                            style: GoogleFonts.pacifico(
                              fontSize: 40,
                              color: const Color.fromARGB(255, 214, 214, 247),
                            ),
                          ),
                          const SizedBox(height: 20),
                          MouseRegion(
                              onEnter: (event) => _onEnter(true, 12),
                              onExit: (event) => _onEnter(false, 12),
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    backgroundColor: WidgetStateProperty.all(
                                      _isHovering12
                                          ? const Color.fromARGB(
                                              255, 221, 172, 107)
                                          : const Color.fromARGB(
                                              255, 255, 255, 255),
                                    ),
                                  ),
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/register'),
                                  child: const Text(
                                    "Register Now",
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                        fontSize: 20),
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
                  horizontal: screenWidth * 0.1,
                  vertical: screenHeight * 0.1,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Pure Mathematics",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 45, 92, 173)),
                    ),
                    const SizedBox(height: 8),
                    Divider(
                        color: const Color.fromARGB(255, 45, 92, 173),
                        thickness: 5),

                    Row(
                      children: [
                        Expanded(
                          child: _buildProgramCard(
                            "Algebra",
                            Icons.functions_rounded,
                            "Learn the foundational algebraic principles, from basic equations.",
                            _isHovering6,
                            () => _onEnter(true, 6),
                            () => _onEnter(false, 6),
                            const Color.fromARGB(255, 105, 18, 18),
                            const Color.fromARGB(255, 55, 85, 68),
                            () => {},
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: _buildProgramCard(
                            "Trigonometry",
                            Icons.shape_line_rounded,
                            "Explore the relationships between the angles and sides of triangles.",
                            _isHovering7,
                            () => _onEnter(true, 7),
                            () => _onEnter(false, 7),
                            const Color.fromARGB(255, 105, 18, 18),
                            const Color.fromARGB(255, 55, 85, 68),
                            () => {},
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: _buildProgramCard(
                            "Solid Geometry",
                            Icons.format_shapes_rounded,
                            "Understand the properties and relationships of geometric solids.",
                            _isHovering8,
                            () => _onEnter(true, 8),
                            () => _onEnter(false, 8),
                            const Color.fromARGB(255, 105, 18, 18),
                            const Color.fromARGB(255, 55, 85, 68),
                            () => {},
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: _buildProgramCard(
                            "Calculus",
                            Icons.area_chart_rounded,
                            "Dive into the world of limits, derivatives, integrals, and their applications.",
                            _isHovering9,
                            () => _onEnter(true, 9),
                            () => _onEnter(false, 9),
                            const Color.fromARGB(255, 105, 18, 18),
                            const Color.fromARGB(255, 55, 85, 68),
                            () => {},
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
                    Divider(
                        color: Color.fromARGB(255, 187, 55, 45), thickness: 5),
                    Row(
                      children: [
                        Expanded(
                          child: _buildProgramCard(
                            "Statics",
                            Icons.balance_rounded,
                            "Understand how forces interact in systems at rest, analyzing and solving problems related",
                            _isHovering10,
                            () => _onEnter(true, 10),
                            () => _onEnter(false, 10),
                            const Color.fromARGB(255, 105, 18, 18),
                            const Color.fromARGB(255, 55, 85, 68),
                            () => {},
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: _buildProgramCard(
                            "Dynamics",
                            Icons.motorcycle_outlined,
                            "Learn how to analyze and interpret motion in systems, from particles to complex machinery.",
                            _isHovering11,
                            () => _onEnter(true, 11),
                            () => _onEnter(false, 11),
                            const Color.fromARGB(255, 105, 18, 18),
                            const Color.fromARGB(255, 55, 85, 68),
                            () => {},
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ])));
          }));
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
}
