import 'package:flutter/material.dart';

class LevelSelection extends StatefulWidget {
  final String level;
  final List<String> pureSubjects;
  final List<String> appliedSubjects;
  final bool hasApplied;
  LevelSelection(
      {required this.appliedSubjects,
      required this.hasApplied,
      required this.pureSubjects,
      required this.level,
      super.key});
  @override
  SubjectsPage createState() => SubjectsPage(
      appliedSubjects: appliedSubjects,
      hasApplied: hasApplied,
      pureSubjects: pureSubjects,
      level: level);
}

class SubjectsPage extends State<LevelSelection> {
  final String level;
  final List<String> pureSubjects;
  final List<String> appliedSubjects;
  final bool hasApplied;
  SubjectsPage(
      {required this.appliedSubjects,
      required this.hasApplied,
      required this.level,
      required this.pureSubjects});
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
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ));
    });
  }

  bool firstp = false;
  bool secp = false;
  bool thirdp = false;
  bool firsts = false;
  bool secs = false;
  bool thirds = false;

  @override
  void initalize() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
              child: Text(
            '$level Subjects',
            style: const TextStyle(color: Colors.white, fontSize: 30),
          )),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: SingleChildScrollView(
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
                      pureSubjects[0],
                      Icons.functions_rounded,
                      "",
                      _Hover[10],
                      () => _onEnter(true, 10),
                      () => _onEnter(false, 10),
                      const Color.fromARGB(255, 45, 92, 173),
                      const Color.fromARGB(255, 55, 85, 68),
                      () => Navigator.pushNamed(context, "/subjects",
                          arguments: {"role": "", "Name": "Algebra"}),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildProgramCard(
                      pureSubjects[1],
                      Icons.format_shapes_rounded,
                      "",
                      _Hover[11],
                      () => _onEnter(true, 11),
                      () => _onEnter(false, 11),
                      const Color.fromARGB(255, 45, 92, 173),
                      const Color.fromARGB(255, 55, 85, 68),
                      () => Navigator.pushNamed(context, "/subjects",
                          arguments: {"role": "", "Name": "Solid Geometry"}),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: _buildProgramCard(
                      pureSubjects[2],
                      Icons.signal_cellular_4_bar,
                      "",
                      _Hover[12],
                      () => _onEnter(true, 12),
                      () => _onEnter(false, 12),
                      const Color.fromARGB(255, 45, 92, 173),
                      const Color.fromARGB(255, 55, 85, 68),
                      () => Navigator.pushNamed(context, "/subjects",
                          arguments: {"role": "", "Name": "Statistics"}),
                    ),
                  ),
                  const SizedBox(width: 20),
                  pureSubjects[3] == ""
                      ? const SizedBox(width: 0)
                      : Expanded(
                          child: _buildProgramCard(
                            pureSubjects[3],
                            Icons.area_chart_rounded,
                            "",
                            _Hover[13],
                            () => _onEnter(true, 13),
                            () => _onEnter(false, 13),
                            const Color.fromARGB(255, 45, 92, 173),
                            const Color.fromARGB(255, 55, 85, 68),
                            () => Navigator.pushNamed(context, "/subjects",
                                arguments: {"role": "", "Name": "Calculus"}),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 32),
              hasApplied
                  ? const SizedBox(height: 0)
                  : const Text(
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
                  appliedSubjects[0] == ""
                      ? const SizedBox(width: 0)
                      : Expanded(
                          child: _buildProgramCard(
                            appliedSubjects[0],
                            Icons.car_repair_rounded,
                            "",
                            _Hover[14],
                            () => _onEnter(true, 14),
                            () => _onEnter(false, 14),
                            const Color.fromARGB(255, 187, 55, 45),
                            const Color.fromARGB(255, 55, 85, 68),
                            () => Navigator.pushNamed(context, "/subjects",
                                arguments: {"role": "", "Name": "Statics"}),
                          ),
                        ),
                  const SizedBox(width: 20),
                  appliedSubjects[1] == ""
                      ? const SizedBox(width: 0)
                      : Expanded(
                          child: _buildProgramCard(
                            appliedSubjects[1],
                            Icons.motorcycle_outlined,
                            "",
                            _Hover[15],
                            () => _onEnter(true, 15),
                            () => _onEnter(false, 15),
                            const Color.fromARGB(255, 187, 55, 45),
                            const Color.fromARGB(255, 55, 85, 68),
                            () => Navigator.pushNamed(context, "/subjects",
                                arguments: {"role": "", "Name": "Dynamics"}),
                          ),
                        ),
                ],
              ),
            ],
          ),
        )));
  }

  Widget buildSubjectTile(
      BuildContext context, String subject, IconData icon, Color color) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      tileColor: color.withOpacity(0.2),
      leading: Icon(icon, color: color, size: 30),
      title: Text(
        subject,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: color),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      onTap: () {
        // Handle navigation to the respective subject page
      },
    );
  }
}
