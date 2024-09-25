import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Security/encryption.dart';
import 'dart:html' as html;

class Subjects extends StatefulWidget {
  final String subjectName;
  final String role;
  const Subjects({super.key, required this.role, required this.subjectName});

  @override
  State<Subjects> createState() {
    return _subjects(role: role, subjectName: subjectName);
  }
}

class _subjects extends State<Subjects> {
  final String subjectName;
  final String role;
  _subjects({required this.role, required this.subjectName});
  bool isCalc = false;
  bool isAlg = false;
  bool isStatic = false;
  bool isDynamic = false;
  bool isStaticitics = false;
  bool isTrig = false;
  bool isUploaded = false;
  Encryption encryption = Encryption();
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  String? _errorMessage;
  final base64Key = "IRZ6jBItbg6aeUJPNMCOQEsvHPZ88clrK63x0weU6Qg=";
  var encryptedCode;
  var decryptedCode;
  String URL = "";

  void checkSubject(String sybjectName) {
    switch (sybjectName) {
      case "Algebra":
        isAlg = true;
        break;
      case "Calculus":
        isCalc = true;
        break;
      case "Statics":
        isStatic = true;
        break;
      case "Dynamics":
        isDynamic = true;
        break;
      case "Statictics":
        isStaticitics = true;
        break;
      case "Trig":
        isTrig = true;
        break;
    }
  }

  List<String> codes = [];
  List<String> videos = [];
  Future<void> _fetchCodes() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      DocumentSnapshot docSnapshot =
          await firestore.collection('Subjects').doc(widget.subjectName).get();

      if (docSnapshot.exists) {
        Map<String, dynamic>? videosMap =
            docSnapshot.get('Videos') as Map<String, dynamic>?;
        if (videosMap != null) {
          setState(() {
            codes = videosMap.entries
                .map((entry) =>
                    (entry.value as Map<String, dynamic>)['Code'] as String)
                .toList();
          });
        }
      }
    } catch (e) {
      print('Error retrieving codes: $e');
    }
  }

  Future<void> _fetchURLS(int index) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      DocumentSnapshot docSnapshot =
          await firestore.collection('Subjects').doc(widget.subjectName).get();

      if (docSnapshot.exists) {
        List<dynamic>? videosList = docSnapshot.get('Videos') as List<dynamic>?;
        if (videosList != null) {
          setState(() {
            videos = videosList
                .map((videoItem) =>
                    (videoItem as Map<String, dynamic>)['Video'] as String)
                .toList();
          });
        }
      }
      URL = videos[index];
    } catch (e) {
      print('Error retrieving videos: $e');
    }
  }

  String bookURL = "";
  bool isbookFound = false;
  bool istricksFound = false;
  bool issolutionFound = false;
  bool isvideoFound = false;
  bool ishomewordFound = false;
  bool isquizFound = false;
  bool isexamFound = false;
  final TextEditingController _urlController = TextEditingController();

  void launchURL(String url) async {
    html.window.open(url, 'new_tab');
  }

  void launchBookURL(String url) async {
    html.window.open(url, 'new_tab');
  }

  Future<void> openBook(BuildContext context, int index) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot docSnapshot =
          await firestore.collection('Subjects').doc(widget.subjectName).get();
      if (docSnapshot.exists) {
        List<dynamic>? bookList = docSnapshot.get('Books') as List<dynamic>?;
        if (bookList != null && bookList.length > index) {
          isbookFound = true;
          launchBookURL(bookList[index]);
        } else {
          isbookFound = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'No Books Yet',
              style: TextStyle(color: Colors.red),
            ),
          ));
        }
      } else {
        isbookFound = false;
      }
    } catch (e) {
      isbookFound = false;
      print('Error retrieving books: $e');
    }
  }

  void launchTricksURL(String url) async {
    html.window.open(url, 'new_tab');
  }

  Future<void> openTricks(BuildContext context, int index) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot docSnapshot =
          await firestore.collection('Subjects').doc(widget.subjectName).get();
      if (docSnapshot.exists) {
        List<dynamic>? bookList = docSnapshot.get('Tricks') as List<dynamic>?;

        if (bookList != null && bookList.length > index) {
          istricksFound = true;
          launchTricksURL(bookList[index]);
        } else {
          istricksFound = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'No Tricks Yet',
              style: TextStyle(color: Colors.red),
            ),
          ));
        }
      } else {
        istricksFound = false;
      }
    } catch (e) {
      istricksFound = false;
      print('Error retrieving books: $e');
    }
  }

  void launchSolutionURL(String url) async {
    html.window.open(url, 'new_tab');
  }

  Future<void> openSolution(BuildContext context, int index) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot docSnapshot =
          await firestore.collection('Subjects').doc(widget.subjectName).get();
      if (docSnapshot.exists) {
        List<dynamic>? bookList =
            docSnapshot.get('Solutions') as List<dynamic>?;

        if (bookList != null && bookList.length > index) {
          istricksFound = true;
          launchSolutionURL(bookList[index]);
        } else {
          istricksFound = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'No Solutions Yet',
              style: TextStyle(color: Colors.red),
            ),
          ));
        }
      } else {
        istricksFound = false;
      }
    } catch (e) {
      istricksFound = false;
      print('Error retrieving books: $e');
    }
  }

  Future<void> uploadHomework(
      BuildContext context, String url, int index) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      if (url.isNotEmpty && Uri.tryParse(url)?.hasAbsolutePath == true) {
        DocumentSnapshot docSnapshot = await firestore
            .collection('Subjects')
            .doc(widget.subjectName)
            .get();
        if (docSnapshot.exists) {
          List<dynamic>? homeworkList =
              docSnapshot.get('Homework') as List<dynamic>?;
          homeworkList ??= [];
          if (homeworkList.length > index) {
            homeworkList[index] = url;
          } else {
            while (homeworkList.length < index) {
              homeworkList.add('');
            }
            homeworkList.add(url);
          }
          await firestore
              .collection('Subjects')
              .doc(widget.subjectName)
              .update({'Homework': homeworkList});
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Subject not found',
              style: TextStyle(color: Colors.red),
            ),
          ));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Invalid URL',
            style: TextStyle(color: Colors.red),
          ),
        ));
      }
    } catch (e) {
      print('Error uploading URL: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Error uploading URL',
          style: TextStyle(color: Colors.red),
        ),
      ));
    }
  }

  void videoCode() {
    _fetchCodes();
    final encryption = Encryption();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 24, 24, 24),
          title: Text(
            widget.subjectName,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the Video Code';
                    }
                    return null;
                  },
                  controller: codeController,
                  decoration: const InputDecoration(
                    labelText: 'Video Code',
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
                if (_errorMessage != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      _errorMessage!,
                      style: TextStyle(color: Colors.red),
                    ),
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
                'Download',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  String originalCode = codeController.text;
                  try {
                    decryptedCode =
                        encryption.decryptCode(originalCode, base64Key);
                    if (codes.isNotEmpty &&
                        !encryption.compareEncryptedCode(
                            decryptedCode, codes[0], base64Key)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'Incorrect Video Code',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      );
                    } else {
                      _fetchURLS(0);
                      launchURL(URL);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Correct Video Code',
                          style: TextStyle(
                              color: const Color.fromARGB(255, 0, 250, 55)),
                        ),
                      ));
                      Navigator.of(context).pop();
                    }
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        'Incorrect Video Code',
                        style: TextStyle(color: Colors.red),
                      ),
                    ));
                    Navigator.of(context).pop();
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  void launchQuizURL(String url) async {
    html.window.open(url, 'new_tab');
  }

  Future<void> openQuiz(BuildContext context, int index) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot docSnapshot =
          await firestore.collection('Subjects').doc(widget.subjectName).get();
      if (docSnapshot.exists) {
        List<dynamic>? bookList = docSnapshot.get('Quiz') as List<dynamic>?;

        if (bookList != null && bookList.length > index) {
          istricksFound = true;
          launchQuizURL(bookList[index]);
        } else {
          istricksFound = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'No Solutions Yet',
              style: TextStyle(color: Colors.red),
            ),
          ));
        }
      } else {
        istricksFound = false;
      }
    } catch (e) {
      istricksFound = false;
      print('Error retrieving books: $e');
    }
  }

  void launchExamURL(String url) async {
    html.window.open(url, 'new_tab');
  }

  Future<void> openExam(BuildContext context, int index) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      DocumentSnapshot docSnapshot =
          await firestore.collection('Subjects').doc(widget.subjectName).get();
      if (docSnapshot.exists) {
        List<dynamic>? bookList = docSnapshot.get('Exam') as List<dynamic>?;

        if (bookList != null && bookList.length > index) {
          istricksFound = true;
          launchQuizURL(bookList[index]);
        } else {
          istricksFound = false;
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'No Solutions Yet',
              style: TextStyle(color: Colors.red),
            ),
          ));
        }
      } else {
        istricksFound = false;
      }
    } catch (e) {
      istricksFound = false;
      print('Error retrieving books: $e');
    }
  }

  void initialize() {
    checkSubject(subjectName);
    _fetchData();
    super.initState();
  }

  List<List<dynamic>> data = [
    ["", "", "", "", "", "", "", ""],
  ];
  Future<void> _fetchData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Retrieve the document snapshot from Firestore
      DocumentSnapshot docSnapshot =
          await firestore.collection('Subjects').doc(widget.subjectName).get();

      if (docSnapshot.exists) {
        // Assuming the document contains a list field named 'Name' with the data structure you want
        List<dynamic>? namesList = docSnapshot.get('Name') as List<dynamic>?;

        if (namesList != null) {
          setState(() {
            // Clear the current data and add the retrieved names list
            data.clear();

            // Add each name entry as a new row in your data table
            for (var name in namesList) {
              data.add([
                name,
                "View",
                "View",
                "View",
                "Get",
                "Add",
                "Enter",
                "Enter"
              ]);
            }
          });
        } else {
          print('No data found for the specified field.');
        }
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }

  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;
      _fetchData();
      return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: const Color(0xFF3F3F3F), // Darker background color
            title: Center(
              child: Text(
                "$subjectName",
                style: GoogleFonts.ultra(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          body: Container(
            width: screenWidth,
            height: screenHeight,
            color: const Color(0xFF1E1E1E), // Dark background for body
            padding: EdgeInsets.all(16.0), // Padding around the table
            child: Card(
              elevation: 8, // Shadow for the card
              color: const Color(0xFF2C2C2C), // Card background color
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  headingRowColor: MaterialStateColor.resolveWith(
                    (states) => const Color(0xFF4A4A4A), // Header row color
                  ),
                  columns: [
                    DataColumn(
                      label: Center(
                        child: Text(
                          "Lesson",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ultra(
                            fontSize: screenWidth * 0.01,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          "Book",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ultra(
                            fontSize: screenWidth * 0.01,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          "Tricks",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ultra(
                            fontSize: screenWidth * 0.01,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          "Solution",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ultra(
                            fontSize: screenWidth * 0.01,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          "Videos",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ultra(
                            fontSize: screenWidth * 0.01,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          "Homework",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ultra(
                            fontSize: screenWidth * 0.01,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          "Quiz",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ultra(
                            fontSize: screenWidth * 0.01,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          "Exam",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.ultra(
                            fontSize: screenWidth * 0.01,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                  rows: List<DataRow>.generate(data.length, (index) {
                    return DataRow(
                      cells: List<DataCell>.generate(data[index].length,
                          (cellIndex) {
                        String cellValue = data[index][cellIndex];
                        return DataCell(
                          Center(
                            child: cellValue == "View" ||
                                    cellValue == "Get" ||
                                    cellValue == "Add" ||
                                    cellValue == "Enter"
                                ? TextButton(
                                    onPressed: () {
                                      if (cellIndex == 1) {
                                        openBook(context, index);
                                      } else if (cellIndex == 2) {
                                        openTricks(context, index);
                                      } else if (cellIndex == 3) {
                                        openSolution(context, index);
                                      } else if (cellIndex == 4) {
                                        videoCode();
                                      } else if (cellIndex == 5) {
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              backgroundColor:
                                                  const Color(0xFF2C2C2C),
                                              title: const Text(
                                                'Homework',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    color: Colors.white),
                                              ),
                                              content: Form(
                                                key: _formKey,
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    TextFormField(
                                                      validator: (value) {
                                                        if (value == null ||
                                                            value.isEmpty) {
                                                          return 'Please enter a valid URL';
                                                        }
                                                        return null;
                                                      },
                                                      controller:
                                                          _urlController,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: 'Drive URL',
                                                        labelStyle: TextStyle(
                                                            color:
                                                                Colors.white),
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .blue),
                                                        ),
                                                      ),
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              actions: <Widget>[
                                                TextButton(
                                                  child: const Text('Cancel',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.white)),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                ),
                                                TextButton(
                                                  child: const Text('Add',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Colors.red)),
                                                  onPressed: () async {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      _formKey.currentState!
                                                          .save();
                                                      uploadHomework(
                                                          context,
                                                          _urlController.text,
                                                          index);
                                                      Navigator.of(context)
                                                          .pop();
                                                    }
                                                  },
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      } else if (cellIndex == 6) {
                                        openQuiz(context, index);
                                      } else if (cellIndex == 7) {
                                        openExam(context, index);
                                      }
                                    },
                                    child: Text(
                                      cellValue,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.ultra(
                                        fontSize: screenWidth * 0.01,
                                        color: Colors.red,
                                      ),
                                    ),
                                  )
                                : Text(
                                    cellValue,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.ultra(
                                      fontSize: screenWidth * 0.01,
                                      color: Colors.white,
                                    ),
                                  ),
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ),
            ),
          ));
    });
  }
}
