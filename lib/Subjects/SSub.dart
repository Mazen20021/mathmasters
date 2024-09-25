import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:othmath/Security/encryption.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:html' as html;

class SpecialTeacherSubjects extends StatefulWidget {
  final String subjectName;
  final String className;
  const SpecialTeacherSubjects(
      {super.key, required this.className, required this.subjectName});

  @override
  State<SpecialTeacherSubjects> createState() {
    return _subjects(className: className, subjectName: subjectName);
  }
}

class _subjects extends State<SpecialTeacherSubjects> {
  final String subjectName;
  final String className;
  _subjects({required this.className, required this.subjectName});
  int tableIndex = 0;
  List<List<dynamic>> data = [
    ["", "", "", "", "", "", "", ""],
  ];
  bool isUploaded = false;
  Encryption encryption = Encryption();
  final _formKey = GlobalKey<FormState>();
  TextEditingController codeController = TextEditingController();
  TextEditingController _url = TextEditingController();
  String? _errorMessage;
  final base64Key = "IRZ6jBItbg6aeUJPNMCOQEsvHPZ88clrK63x0weU6Qg=";
  var encryptedCode;
  var decryptedCode;
  String URL = "";
  String bookURL = "";

  void initialize() {
    _fetchData();
    super.initState();
  }

  Future<void> _geturl(
      BuildContext context, String name, String constName, int index) async {
    switch (name) {
      case "Quiz":
        _setURL(constName, "Quiz", index);
        break;
      case "Exam":
        _setURL(constName, "Exam", index);
        break;
    }
  }

  Future<void> _pick(
      BuildContext context, String name, String constName) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        PlatformFile file = result.files.first;
        Uint8List? fileBytes = file.bytes;

        if (fileBytes != null) {
          switch (name) {
            case "Book":
              _upload(fileBytes, name, constName);
              break;
            case "Tricks":
              _upload(fileBytes, "Tricks", constName);
              break;
            case "Solution":
              _upload(fileBytes, "Solutions", constName);
              break;
            case "Quiz":
              _setURL(constName, "Quiz", tableIndex);
              break;
            case "Exam":
              _setURL(constName, "Exam", tableIndex);
              break;
          }
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating document: $e'),
        ),
      );
    }
  }

  Future<void> _update(String newUrl, int index, String name) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore
        .collection('Subjects')
        .doc(className); // Adjust the document path as needed

    try {
      // Fetch the current document snapshot
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Retrieve the existing map for the 'Algebra' field
        Map<String, dynamic>? algebraMap =
            docSnapshot.data()?[subjectName] as Map<String, dynamic>?;

        if (algebraMap != null) {
          // Retrieve the existing list for the specified name ('Books')
          List<dynamic> books = algebraMap[name] ?? [];

          // Check if the list is not empty and the index is within range
          if (books.length > index) {
            // Update the specific index with the new URL
            books[index] = newUrl;
          } else {
            // Insert new data if the index does not exist or list is empty
            while (books.length <= index) {
              books.add('');
            }
            books[index] = newUrl;
          }

          // Update the 'Algebra' map with the modified list
          algebraMap[name] = books;

          // Update the 'Algebra' field within the document
          await docRef.update({subjectName: algebraMap}).catchError((e) async {
            await docRef.set({subjectName: algebraMap});
          });
        } else {
          // Create a new 'Algebra' field if it doesn't exist, and set the list
          await docRef.update({
            subjectName: {
              name: List.filled(index + 1, '')..[index] = newUrl,
            },
          }).catchError((e) async {
            await docRef.set({
              subjectName: {
                name: List.filled(index + 1, '')..[index] = newUrl,
              },
            });
          });
        }
      } else {
        // Document does not exist, create a new document with the specified structure
        await docRef.set({
          subjectName: {
            name: List.filled(index + 1, '')..[index] = newUrl,
          },
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating document: $e'),
        ),
      );
    }
  }

  Future<void> _setURL(String URL, String name, int index) async {
    ensureUserIsAuthenticated();
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore.collection('Subjects').doc(className);

    try {
      // Fetch the current document snapshot
      final docSnapshot = await docRef.get();

      // Initialize the list for the specified name
      List<dynamic> items = [];

      if (docSnapshot.exists) {
        // Retrieve the existing list for the specified name, ensuring it's a list
        items = List.from(docSnapshot.data()?[name] ?? []);
      }

      // Check if the list is not empty and the index is within range
      if (items.length > index) {
        // Update the specific index with the new URL
        items[index] = URL;
      } else {
        // If the index does not exist or the list is empty, expand the list correctly
        for (int i = items.length; i <= index; i++) {
          items.add('');
        }
        items[index] = URL;
      }

      // Update or set the document in Firestore
      await docRef.update({name: items}).catchError((e) async {
        await docRef.set({name: items});
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Document inserted successfully.'),
          ),
        );
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Document updated successfully.'),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating document: $e'),
        ),
      );
    }
  }

  Future<void> _upload(Uint8List files, String name, String constName) async {
    ensureUserIsAuthenticated();
    switch (name) {
      case "Book":
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('Subjects/$subjectName/Books/$constName.pdf');
        try {
          // Create an UploadTask to monitor the progress
          UploadTask uploadTask = storageRef.putData(files);

          // Show a loading dialog with a progress indicator
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                content: StreamBuilder<TaskSnapshot>(
                  stream: uploadTask.snapshotEvents,
                  builder: (BuildContext context,
                      AsyncSnapshot<TaskSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final progress = snapshot.data!.bytesTransferred /
                          snapshot.data!.totalBytes;
                      final percentage = (progress * 100).toStringAsFixed(2);

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(value: progress),
                          SizedBox(height: 20),
                          Text('$percentage% uploaded'),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text('Starting upload...'),
                        ],
                      );
                    }
                  },
                ),
              );
            },
          );
          await uploadTask;
          bookURL = await storageRef.getDownloadURL();
          Navigator.of(context).pop();
          _update(bookURL, tableIndex, "Books");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Books uploaded successfully!'),
            ),
          );
        } catch (e) {
          Navigator.of(context)
              .pop(); // Close the loading dialog if there's an error

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to upload Book: $e'),
            ),
          );
        }
        break;
      case "Tricks":
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('Subjects/$subjectName/Tricks/$constName.pdf');
        try {
          // Create an UploadTask to monitor the progress
          UploadTask uploadTask = storageRef.putData(files);

          // Show a loading dialog with a progress indicator
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                content: StreamBuilder<TaskSnapshot>(
                  stream: uploadTask.snapshotEvents,
                  builder: (BuildContext context,
                      AsyncSnapshot<TaskSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final progress = snapshot.data!.bytesTransferred /
                          snapshot.data!.totalBytes;
                      final percentage = (progress * 100).toStringAsFixed(2);

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(value: progress),
                          SizedBox(height: 20),
                          Text('$percentage% uploaded'),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text('Starting upload...'),
                        ],
                      );
                    }
                  },
                ),
              );
            },
          );

          await uploadTask;

          // Get the download URL
          bookURL = await storageRef.getDownloadURL();

          // Close the loading dialog
          Navigator.of(context).pop();
          _update(bookURL, tableIndex, "Tricks");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Tricks uploaded successfully!'),
            ),
          );
        } catch (e) {
          Navigator.of(context)
              .pop(); // Close the loading dialog if there's an error

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to upload Book: $e'),
            ),
          );
        }
        break;
      case "Solutions":
        final storageRef = FirebaseStorage.instance
            .ref()
            .child('Subjects/$subjectName/Solutions/$constName.pdf');
        try {
          // Create an UploadTask to monitor the progress
          UploadTask uploadTask = storageRef.putData(files);

          // Show a loading dialog with a progress indicator
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                content: StreamBuilder<TaskSnapshot>(
                  stream: uploadTask.snapshotEvents,
                  builder: (BuildContext context,
                      AsyncSnapshot<TaskSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      final progress = snapshot.data!.bytesTransferred /
                          snapshot.data!.totalBytes;
                      final percentage = (progress * 100).toStringAsFixed(2);

                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(value: progress),
                          SizedBox(height: 20),
                          Text('$percentage% uploaded'),
                        ],
                      );
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 20),
                          Text('Starting upload...'),
                        ],
                      );
                    }
                  },
                ),
              );
            },
          );

          await uploadTask;

          // Get the download URL
          bookURL = await storageRef.getDownloadURL();

          // Close the loading dialog
          Navigator.of(context).pop();
          _update(bookURL, tableIndex, "Solutions");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Solutions uploaded successfully!'),
            ),
          );
        } catch (e) {
          Navigator.of(context)
              .pop(); // Close the loading dialog if there's an error

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to upload Book: $e'),
            ),
          );
        }
        break;
    }
  }

  List<String> _encryptedCodes = [];
  final TextEditingController _bookController = TextEditingController();
  void dialogCon(String Name) {
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
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the $Name Name';
                  }
                  return null;
                },
                controller: _bookController,
                decoration: InputDecoration(
                  labelText: '$Name Name',
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
            ]),
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
                'Upload',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _pick(context, Name, _bookController.text);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void ExamsDialog(String Name, int index) {
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
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the $Name URL';
                  }
                  return null;
                },
                controller: _url,
                decoration: InputDecoration(
                  labelText: '$Name URL',
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
            ]),
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
                'Set',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _geturl(context, Name, _url.text, index);
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> ensureUserIsAuthenticated() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        // Perform sign-in (e.g., anonymously, via email/password, etc.)
        await FirebaseAuth.instance.signInAnonymously();
      }
    } catch (e) {
      print('Error during authentication: $e');
    }
  }

  Future<void> _pickVideo(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null) {
        PlatformFile file = result.files.first;

        // Use the `bytes` property on web to get the file data
        Uint8List? fileBytes = file.bytes;

        if (fileBytes != null) {
          // Now you can use `fileBytes` to upload the file
          print('File size: ${fileBytes.length} bytes');
          _uploadVideoAndGetURL(fileBytes);
        } else {
          print('File data not available');
        }
      } else {
        print('No file selected.');
      }
    } catch (e) {
      print('Error picking file: $e');
    }
  }

  String videoURL = "";
  Future<void> _uploadVideoAndGetURL(Uint8List files) async {
    ensureUserIsAuthenticated();
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('Subjects/$subjectName/Videos/${codeController.text}.mp4');

    try {
      // Create an UploadTask to monitor the progress
      UploadTask uploadTask = storageRef.putData(files);

      // Show a loading dialog with a progress indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            content: StreamBuilder<TaskSnapshot>(
              stream: uploadTask.snapshotEvents,
              builder:
                  (BuildContext context, AsyncSnapshot<TaskSnapshot> snapshot) {
                if (snapshot.hasData) {
                  final progress = snapshot.data!.bytesTransferred /
                      snapshot.data!.totalBytes;
                  final percentage = (progress * 100).toStringAsFixed(2);

                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(value: progress),
                      SizedBox(height: 20),
                      Text('$percentage% uploaded'),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(height: 20),
                      Text('Starting upload...'),
                    ],
                  );
                }
              },
            ),
          );
        },
      );

      // Wait for the upload to complete
      await uploadTask;

      // Get the download URL
      videoURL = await storageRef.getDownloadURL();

      // Close the loading dialog
      Navigator.of(context).pop();
      _generateAndEncryptCodes();
      _showEncryptedCodesDialog(context);
      _updateFirestore(_encryptedCodes[0], videoURL, tableIndex);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Video uploaded successfully!'),
        ),
      );
    } catch (e) {
      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to upload video: $e'),
        ),
      );
    }
  }

  bool isUploadedVideo = false;
  Future<void> _updateFirestore(
      String newCode, String newUrl, int index) async {
    final firestore = FirebaseFirestore.instance;
    final docRef = firestore
        .collection('Subjects')
        .doc(className); // Make sure 'className' is the correct document name

    try {
      // Fetch the document snapshot from Firestore
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Access the 'Algebra' field directly
        Map<String, dynamic>? algebraMap =
            docSnapshot.data()?[subjectName] as Map<String, dynamic>?;

        if (algebraMap != null) {
          // Retrieve the 'Videos' field inside 'Algebra', or initialize as an empty list if it doesn't exist
          List<dynamic> videos = algebraMap['Videos'] ?? [];

          // Check if the index exists within the list or needs to be extended
          if (index < videos.length) {
            // Update the specific index with the new data
            Map<String, dynamic> updatedVideo =
                Map<String, dynamic>.from(videos[index]);
            updatedVideo['Code'] = newCode;
            updatedVideo['Video'] = newUrl;
            videos[index] = updatedVideo;
          } else {
            // Extend the list to accommodate the new index if necessary
            while (videos.length <= index) {
              videos.add({'Code': '', 'Video': ''});
            }
            // Set the new data at the specified index
            videos[index] = {'Code': newCode, 'Video': newUrl};
          }
          algebraMap["Videos"] = videos;
          await docRef.update({subjectName: algebraMap}).catchError((e) async {
            await docRef.set({subjectName: algebraMap});
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error updating document: $e'),
        ),
      );
    }
  }

  final TextEditingController _numCodesController = TextEditingController();
  void videoCode() {
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
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the Video Name';
                  }
                  return null;
                },
                controller: codeController,
                decoration: const InputDecoration(
                  labelText: 'Video Name',
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
              SizedBox(height: 5),
              TextField(
                controller: _numCodesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Code Numbers',
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
            ]),
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
                'Upload',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _pickVideo(context);
                }
              },
            ),
            TextButton(
              child: const Text(
                'View Codes',
                style: TextStyle(fontSize: 20, color: Colors.red),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _generateAndEncryptCodes();
                  _showEncryptedCodesDialog(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _generateAndEncryptCodes() {
    setState(() {
      int numberOfCodes = int.tryParse(_numCodesController.text) ?? 0;
      _encryptedCodes.clear();
      for (int i = 0; i < numberOfCodes; i++) {
        String originalCode = codeController.text;
        String encrypted = encryption.encryptCode(originalCode, base64Key);
        _encryptedCodes.add(encrypted);
      }
    });
  }

  void _showEncryptedCodesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Encrypted Codes'),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _encryptedCodes.length,
              itemBuilder: (context, index) {
                return InkWell(
                    onTap: () async {
                      await Clipboard.setData(
                          ClipboardData(text: _encryptedCodes[index]));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                          'Code Copied',
                          style: TextStyle(color: Colors.red),
                        ),
                      ));
                    },
                    child: ListTile(
                      title: Text(_encryptedCodes[index]),
                    ));
              },
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }

  bool _isFetched = false;
  Future<void> _fetchData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      // Reference the document within the 'Subjects' collection
      final docRef = firestore.collection('Subjects').doc(className);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Assuming 'Algebra' is a map inside the document
        Map<String, dynamic>? algebraMap =
            docSnapshot.data()?[subjectName] as Map<String, dynamic>?;

        if (algebraMap != null) {
          // Access the 'Names' list within the 'Algebra' map
          List<dynamic>? namesList = algebraMap['Names'] as List<dynamic>?;

          if (namesList != null) {
            setState(() {
              data.clear();

              // Add each name entry as a new row in your data table
              for (var name in namesList) {
                data.add(
                    [name, "Add", "Add", "Add", "Upload", "See", "Add", "Add"]);
              }
              _isFetched = true;
            });
          } else {
            print('No data found for the "Names" field.');
          }
        } else {
          print('No data found for the "Algebra" field.');
        }
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }

  Future<void> _insertData(String name) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Retrieve the document reference for the specific class
      DocumentReference docRef = firestore
          .collection('Subjects') // Main collection
          .doc(className); // Document for the class

      // Fetch the document snapshot
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Safely cast the document data to a Map<String, dynamic>
        Map<String, dynamic>? data =
            docSnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          // Access the dynamic subject field from the document data
          Map<String, dynamic>? subjectMap =
              data[subjectName] as Map<String, dynamic>?;

          if (subjectMap != null) {
            // Access the 'Names' field inside the dynamic subject map
            List<dynamic>? namesList = subjectMap['Names'] as List<dynamic>?;

            if (namesList != null) {
              // Add the new name to the list
              namesList.add(name);

              // Update the subject field with the new 'Names' list
              await docRef.update({
                subjectName: {
                  ...subjectMap,
                  'Names': namesList,
                },
              });
              _isFetched = false;
              _fetchData();
              print('Name added successfully.');
            } else {
              print('No Names field found in the $subjectName data.');
            }
          } else {
            print('No data found for the $subjectName field.');
          }
        } else {
          print('No data found in the document.');
        }
      } else {
        print('Document does not exist.');
      }
    } catch (e) {
      print('Error adding name: $e');
    }
  }

  void _addData(String name) {
    setState(() {
      data.add([name, "Add", "Add", "Add", "Upload", "See", "Add", "Add"]);
    });
  }

  final TextEditingController _namesController = TextEditingController();
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final screenWidth = constraints.maxWidth;
      final screenHeight = constraints.maxHeight;
      if (!_isFetched) {
        _fetchData();
      }
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xFF3F3F3F),
          title: Row(children: [
            Center(
              child: Text(
                "$subjectName",
                style: GoogleFonts.ultra(
                  fontSize: 35,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 20),
            Center(
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        backgroundColor: const Color.fromARGB(255, 24, 24, 24),
                        title: Text(
                          "Add New Lesson",
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
                                    return 'Please enter the Name';
                                  }
                                  return null;
                                },
                                controller: _namesController,
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: const Text(
                              'Add',
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _insertData(_namesController.text);
                                Navigator.of(context).pop();
                                _namesController.clear();
                              }
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: Icon(
                  Icons.add_box,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ),
          ]),
        ),
        body: Container(
          width: screenWidth,
          height: screenHeight,
          color: const Color(0xFF1E1E1E),
          padding: EdgeInsets.all(16.0),
          child: Card(
            elevation: 8,
            color: const Color(0xFF2C2C2C),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: DataTable(
                headingRowColor: MaterialStateColor.resolveWith(
                  (states) => const Color(0xFF4A4A4A),
                ),
                columns: [
                  DataColumn(label: _buildColumnHeader('Lesson', screenWidth)),
                  DataColumn(label: _buildColumnHeader('Book', screenWidth)),
                  DataColumn(label: _buildColumnHeader('Tricks', screenWidth)),
                  DataColumn(
                      label: _buildColumnHeader('Solution', screenWidth)),
                  DataColumn(label: _buildColumnHeader('Videos', screenWidth)),
                  DataColumn(
                      label: _buildColumnHeader('Homework', screenWidth)),
                  DataColumn(label: _buildColumnHeader('Quiz', screenWidth)),
                  DataColumn(label: _buildColumnHeader('Exam', screenWidth)),
                ],
                rows: List<DataRow>.generate(data.length, (index) {
                  return DataRow(
                    cells: List<DataCell>.generate(data[index].length,
                        (cellIndex) {
                      String cellValue = data[index][cellIndex];
                      return DataCell(
                        Center(
                          child: _buildTableCell(
                              cellValue, cellIndex, screenWidth, index),
                        ),
                      );
                    }),
                  );
                }),
              ),
            ),
          ),
        ),
      );
    });
  }

  // Helper function to build column headers
  Widget _buildColumnHeader(String label, double screenWidth) {
    return Center(
      child: Text(
        label,
        textAlign: TextAlign.center,
        style: GoogleFonts.ultra(
          fontSize: screenWidth * 0.01,
          color: Colors.white,
        ),
      ),
    );
  }

  // Helper function to build table cells
  Widget _buildTableCell(
      String cellValue, int cellIndex, double screenWidth, int rowIndex) {
    return cellValue == "View" ||
            cellValue == "See" ||
            cellValue == "Add" ||
            cellValue == "Upload"
        ? TextButton(
            onPressed: () {
              _handleButtonPress(cellIndex, rowIndex);
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
          );
  }

  // Function to handle button presses in the table
  void _handleButtonPress(int cellIndex, int rowIndex) {
    tableIndex = rowIndex;
    if (cellIndex == 1) {
      dialogCon("Book");
    } else if (cellIndex == 2) {
      dialogCon("Tricks");
    } else if (cellIndex == 3) {
      dialogCon("Solution");
    } else if (cellIndex == 4) {
      videoCode();
    } else if (cellIndex == 6) {
      ExamsDialog("Quiz", rowIndex);
    } else if (cellIndex == 7) {
      ExamsDialog("Exam", rowIndex);
    }
  }
}
