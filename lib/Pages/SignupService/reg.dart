import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _SN = '';
  String _PN = '';
  String _address = '';
  String _SchN = '';
  String _Class = '';
  String _LTYPE = '';
  bool isSuccess = false;
  String _selectedClass = 'Choose your Grade';
  String _selectedType = 'How do you want to learn?';
  String _errorMessage = '';
  String _errorMessage1 = '';
  String _errorMessage2 = '';

  void saveindb(String name, String sn, String pn, String schN,
      String selectedClass, String ltype, String email, String address) async {
    CollectionReference submissions =
        FirebaseFirestore.instance.collection('Submission');
    try {
      await submissions.add({
        'Name': name,
        'Student Number': sn,
        'Parent Number': pn,
        'School Name': schN,
        'Class': selectedClass,
        'Learning Type': ltype,
        'Email': email,
        'Address': address,
        'Type': "New"
      });
      setState(() {
        isSuccess = true;
      });
    } catch (e) {
      setState(() {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(
                  'Could not add this student due to: $e',
                  style: const TextStyle(fontSize: 20),
                ),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK', style: TextStyle(fontSize: 20)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
        isSuccess = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 23, 15, 61),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "Registration Form",
                    style: TextStyle(
                      fontSize: 48,
                      color: Color.fromARGB(255, 207, 160, 16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  elevation: 10,
                  color: const Color.fromARGB(255, 255, 255, 255),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            labelText: 'Full Name *',
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Color.fromARGB(255, 206, 170, 62)),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _name = value!;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            labelText: 'Student Email *',
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            setState(() {
                              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                  .hasMatch(value)) {
                                _errorMessage =
                                    'Please enter a valid email address';
                              } else {
                                _errorMessage = '';
                              }
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _email = value!;
                          },
                        ),
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        const SizedBox(height: 15),
                        TextFormField(
                          maxLength: 11,
                          style: const TextStyle(fontSize: 20),
                          onChanged: (value1) {
                            setState(() {
                              if (value1.isEmpty ||
                                  value1.length < 11 ||
                                  !(value1.startsWith("010") ||
                                      value1.startsWith("011") ||
                                      value1.startsWith("012"))) {
                                _errorMessage1 =
                                    'Please enter the number correctly';
                              } else {
                                _errorMessage1 = '';
                              }
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Student WhatsApp Number *',
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 11 ||
                                !(value.startsWith("010") ||
                                    value.startsWith("011") ||
                                    value.startsWith("012"))) {
                              return 'Please enter your number correctly';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _SN = value!;
                          },
                        ),
                        if (_errorMessage1.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _errorMessage1,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        const SizedBox(height: 15),
                        TextFormField(
                          maxLength: 11,
                          style: const TextStyle(fontSize: 20),
                          onChanged: (value2) {
                            setState(() {
                              if (value2.isEmpty ||
                                  value2.length < 11 ||
                                  !(value2.startsWith("010") ||
                                      value2.startsWith("011") ||
                                      value2.startsWith("012"))) {
                                _errorMessage2 =
                                    'Please enter the number correctly';
                              } else {
                                _errorMessage2 = '';
                              }
                            });
                          },
                          decoration: const InputDecoration(
                            labelText: 'Parent WhatsApp Number *',
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 11) {
                              return 'Please enter the number correctly';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _PN = value!;
                          },
                        ),
                        if (_errorMessage2.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _errorMessage2,
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                        const SizedBox(height: 15),
                        TextFormField(
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            labelText: 'Address *',
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your address';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _address = value!;
                          },
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          style: const TextStyle(fontSize: 20),
                          decoration: const InputDecoration(
                            labelText: 'School Name *',
                            labelStyle: TextStyle(color: Colors.deepPurple),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.amber),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.deepPurple),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your school name';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _SchN = value!;
                          },
                        ),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(66, 172, 172, 172),
                                blurRadius: 20,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: Colors.white,
                            value: _selectedClass,
                            decoration: const InputDecoration(
                              labelText: 'Your Grade *',
                              labelStyle: TextStyle(color: Colors.deepPurple),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                            ),
                            items: [
                              'Choose your Grade',
                              'First Secondary',
                              'Second Secondary (Art)',
                              'Second Secondary (Scientific)',
                              'Third Secondary',
                              'International General Certificate of Secondary Education (IG)',
                              'Scholastic Aptitude Test (SAT)',
                              'American College Testing (ACT)',
                              'American Diploma (EST)'
                            ].map((String className) {
                              return DropdownMenuItem<String>(
                                value: className,
                                child: Text(className),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedClass = newValue!;
                              });
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == "Choose your Grade") {
                                return 'Please select a class';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _Class = newValue!;
                            },
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                color: Color.fromARGB(66, 173, 173, 173),
                                blurRadius: 20,
                                offset: Offset(0, 5),
                              ),
                            ],
                          ),
                          child: DropdownButtonFormField<String>(
                            dropdownColor: Colors.white,
                            value: _selectedType,
                            decoration: const InputDecoration(
                              labelText: 'Way Of Learning *',
                              labelStyle: TextStyle(color: Colors.deepPurple),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.amber),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.deepPurple),
                              ),
                            ),
                            items: [
                              'How do you want to learn?',
                              'Offline at Center',
                              'Online Videos'
                            ].map((String role) {
                              return DropdownMenuItem<String>(
                                value: role,
                                child: Text(role),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedType = newValue!;
                              });
                            },
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value == "How do you want to learn?") {
                                return 'Please select a learning type';
                              }
                              return null;
                            },
                            onSaved: (newValue) {
                              _LTYPE = newValue!;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        isSuccess
                            ? const Center(
                                child: Text(
                                  "Your submission has been sent. We will contact you soon!",
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              )
                            : ElevatedButton.icon(
                                icon: const Icon(Icons.send, size: 24),
                                label: const Text("Submit",
                                    style: TextStyle(fontSize: 20)),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.deepPurple,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 15),
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    saveindb(_name, _SN, _PN, _SchN, _Class,
                                        _LTYPE, _email, _address);
                                  }
                                },
                              ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
