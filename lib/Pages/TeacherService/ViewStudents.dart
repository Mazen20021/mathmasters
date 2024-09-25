import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewStudents extends StatefulWidget {
  const ViewStudents({super.key});

  @override
  _ViewStudentsState createState() => _ViewStudentsState();
}

class _ViewStudentsState extends State<ViewStudents> {
  List<Map<String, dynamic>> userData = [];
  bool isLoading = true;
  List<bool> _isHovering = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Students').get();
      List<Map<String, dynamic>> tempList = [];
      for (var doc in querySnapshot.docs) {
        DocumentSnapshot marksDoc =
            await doc.reference.collection('Marks').doc('Exam').get();
        tempList.add({
          'name': doc['Name'],
          'class': doc['Class'],
          'examName': marksDoc['Name'],
          'examScore': marksDoc['Score'],
          'date': marksDoc['Date'],
          'comment': marksDoc['Comment'],
          'type': marksDoc['Type']
        });
      }
      setState(() {
        userData = tempList;
        isLoading = false;
        _isHovering = List<bool>.filled(userData.length, false);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onEnter(bool hover, int index) {
    setState(() {
      _isHovering[index] = hover;
    });
  }

  Future<void> _sortFirstSec() async {
    await _sortStudentsByClass("First Secondary");
  }

  Future<void> _sortSecSec() async {
    await _sortStudentsByClass("Second Secondary");
  }

  Future<void> _sortThirdSec() async {
    await _sortStudentsByClass("Third Secondary");
  }

  Future<void> _sortStudentsByClass(String className) async {
    try {
      setState(() {
        isLoading = true;
      });
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Students')
          .where("Class", isEqualTo: className)
          .get();
      List<Map<String, dynamic>> tempList = [];
      for (var doc in querySnapshot.docs) {
        DocumentSnapshot marksDoc =
            await doc.reference.collection('Marks').doc('Exam').get();
        tempList.add({
          'name': doc['Name'],
          'class': doc['Class'],
          'examName': marksDoc['Name'],
          'examScore': marksDoc['Score'],
          'date': marksDoc['Date'],
          'comment': marksDoc['Comment'],
          'type': marksDoc['Type']
        });
      }
      setState(() {
        userData = tempList;
        isLoading = false;
        _isHovering = List<bool>.filled(userData.length, false);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 20,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A0572), Color(0xFFBF0A30)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildClassButton("View All", fetchData, screenWidth * 0.02),
                const Spacer(),
                _buildClassButton(
                    "First Secondary", _sortFirstSec, screenWidth * 0.02),
                const Spacer(),
                _buildClassButton(
                    "Second Secondary", _sortSecSec, screenWidth * 0.02),
                const Spacer(),
                _buildClassButton(
                    "Third Secondary", _sortThirdSec, screenWidth * 0.02),
              ],
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 121, 20, 80),
                Color.fromARGB(255, 101, 75, 167)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: isLoading
              ? const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Loading Data ...",
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontFamily: 'DancingScript'),
                      ),
                      SizedBox(width: 30),
                      CircularProgressIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.blueAccent,
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: userData.length,
                  itemBuilder: (context, index) {
                    return MouseRegion(
                      onEnter: (_) => _onEnter(true, index),
                      onExit: (_) => _onEnter(false, index),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () {},
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          color: _isHovering[index]
                              ? Colors.blueGrey.withOpacity(0.5)
                              : Colors.blueGrey.withOpacity(0.3),
                          shadowColor: Colors.black.withOpacity(0.5),
                          elevation: 10,
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildText('Name', userData[index]['name']),
                                const SizedBox(height: 8.0),
                                _buildText('Class', userData[index]['class']),
                                const SizedBox(height: 8.0),
                                _buildText(
                                    'Exam Name', userData[index]['examName']),
                                const SizedBox(height: 8.0),
                                _buildText(
                                    'Exam Score', userData[index]['examScore']),
                                const SizedBox(height: 8.0),
                                _buildText('Date', userData[index]['date']),
                                const SizedBox(height: 8.0),
                                _buildText(
                                    'Comment', userData[index]['comment']),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      );
    });
  }

  ElevatedButton _buildClassButton(
      String title, VoidCallback onPressed, double width) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontSize: width,
          fontFamily: 'Pacifico',
        ),
      ),
    );
  }

  Widget _buildText(String label, String? value) {
    return Text(
      '$label: ${value ?? ''}',
      style: const TextStyle(
        fontSize: 18,
        fontFamily: 'Lobster',
        color: Colors.white,
      ),
    );
  }
}
