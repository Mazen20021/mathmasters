import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SecondaryLevelSelection extends StatefulWidget {
  SecondaryLevelSelection({super.key});
  @override
  _SecondaryLevelSelection createState() => _SecondaryLevelSelection();
}

class _SecondaryLevelSelection extends State<SecondaryLevelSelection> {
  final List<bool> _Hover = List.generate(18, (index) => false);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            'Choose Level',
            style: GoogleFonts.abel(fontSize: 30, color: Colors.white),
          )),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: LayoutBuilder(builder: (context, Constraints) {
          final screenWidth = MediaQuery.of(context).size.width;
          final screenHeight = MediaQuery.of(context).size.height;
          return SingleChildScrollView(
              child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1,
              vertical: screenHeight * 0.1,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Preparatory",
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
                        "First Preparatory",
                        Icons.face_4,
                        "",
                        _Hover[10],
                        () => _onEnter(true, 10),
                        () => _onEnter(false, 10),
                        const Color.fromARGB(255, 45, 92, 173),
                        const Color.fromARGB(255, 55, 85, 68),
                        () => Navigator.pushNamed(context, "/specialsub",
                            arguments: {
                              "Level": "First Prepatory",
                              "Pure": [
                                "Algebra",
                                "SoildGeometry",
                                "Trigonometry",
                                ""
                              ],
                              "hasApplied": false,
                              "Applied": ["", ""],
                              "Class": "FP"
                            }),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildProgramCard(
                        "Second Preparatory",
                        Icons.face_4_sharp,
                        "",
                        _Hover[11],
                        () => _onEnter(true, 11),
                        () => _onEnter(false, 11),
                        const Color.fromARGB(255, 45, 92, 173),
                        const Color.fromARGB(255, 55, 85, 68),
                        () => Navigator.pushNamed(context, "/specialsub",
                            arguments: {
                              "Level": "Second Prepatory",
                              "Pure": [
                                "Algebra",
                                "SoildGeometry",
                                "Trigonometry",
                                ""
                              ],
                              "hasApplied": false,
                              "Applied": ["", ""],
                              "Class": "SP"
                            }),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildProgramCard(
                        "Third Preparatory",
                        Icons.face_4_rounded,
                        "",
                        _Hover[12],
                        () => _onEnter(true, 12),
                        () => _onEnter(false, 12),
                        const Color.fromARGB(255, 45, 92, 173),
                        const Color.fromARGB(255, 55, 85, 68),
                        () => Navigator.pushNamed(context, "/specialsub",
                            arguments: {
                              "Level": "Third Prepatory",
                              "Pure": [
                                "Algebra",
                                "SoildGeometry",
                                "Trigonometry",
                                ""
                              ],
                              "hasApplied": false,
                              "Applied": ["", ""],
                              "Class": "TP"
                            }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),

                // Applied Mathematics Section
                const Text(
                  "Secondary",
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
                        "First Secondary",
                        Icons.face_6,
                        "",
                        _Hover[14],
                        () => _onEnter(true, 14),
                        () => _onEnter(false, 14),
                        const Color.fromARGB(255, 187, 55, 45),
                        const Color.fromARGB(255, 55, 85, 68),
                        () => Navigator.pushNamed(context, "/specialsub",
                            arguments: {
                              "Level": "First Secondary",
                              "Pure": [
                                "Algebra",
                                "SoildGeometry",
                                "Trigonometry",
                                ""
                              ],
                              "hasApplied": true,
                              "Applied": ["Statics", ""],
                              "Class": "FS"
                            }),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: _buildProgramCard(
                        "Second Secondary",
                        Icons.face_outlined,
                        "",
                        _Hover[15],
                        () => _onEnter(true, 15),
                        () => _onEnter(false, 15),
                        const Color.fromARGB(255, 187, 55, 45),
                        const Color.fromARGB(255, 55, 85, 68),
                        () => Navigator.pushNamed(context, "/specialsub",
                            arguments: {
                              "Level": "Second Secondary",
                              "Pure": [
                                "Algebra",
                                "SoildGeometry",
                                "Trigonometry",
                                "Calculus"
                              ],
                              "hasApplied": true,
                              "Applied": ["Statics", ""],
                              "Class": "SS"
                            }),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: _buildProgramCard(
                        "Third Secondary",
                        Icons.face_retouching_natural_rounded,
                        "",
                        _Hover[13],
                        () => _onEnter(true, 13),
                        () => _onEnter(false, 13),
                        const Color.fromARGB(255, 187, 55, 45),
                        const Color.fromARGB(255, 55, 85, 68),
                        () => Navigator.pushNamed(context, "/sub", arguments: {
                          "Level": "Third Secondary",
                          "Pure": [
                            "Algebra",
                            "Soild Geometry",
                            "Statistics",
                            "Calculus"
                          ],
                          "hasApplied": true,
                          "Applied": ["Statics", "Dynamics"]
                        }),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ));
        }));
  }
}
