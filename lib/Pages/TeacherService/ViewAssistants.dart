import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewAssistant extends StatefulWidget {
  const ViewAssistant({super.key});

  @override
  _ViewAssistantState createState() => _ViewAssistantState();
}

class _ViewAssistantState extends State<ViewAssistant> {
  List<Map<String, dynamic>> userData = [];
  TextEditingController newTaskController = TextEditingController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Assistance').get();

      List<Map<String, dynamic>> tempList = [];
      for (var doc in querySnapshot.docs) {
        tempList.add({
          'ID': doc.id,
          'Name': doc['Name'],
          'Students': doc["AStudents"],
          'Tasks': doc['Tasks'],
        });
      }
      setState(() {
        userData = tempList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> addTask(String assistantId, String newTask) async {
    try {
      DocumentReference assistantRef =
          FirebaseFirestore.instance.collection('Assistance').doc(assistantId);

      await assistantRef.update({
        'Tasks': FieldValue.arrayUnion([newTask])
      });

      fetchData();
    } catch (e) {}
  }

  Future<void> deleteTask(String assistantId, String task) async {
    try {
      DocumentReference assistantRef =
          FirebaseFirestore.instance.collection('Assistance').doc(assistantId);

      await assistantRef.update({
        'Tasks': FieldValue.arrayRemove([task])
      });

      fetchData();
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF6A0572), Color(0xFFBF0A30)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: const Center(
          child: Text(
            'Assistants',
            style: TextStyle(
              fontSize: 40,
              fontFamily: 'DancingScript',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xFFBF0A30), Color(0xFF6A0572)],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),
        child: isLoading
            ? const Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Loading Data ...",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    SizedBox(width: 30),
                    CircularProgressIndicator()
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: userData.length,
                itemBuilder: (context, index) {
                  List<String> astudents = userData[index]['Students'] != null
                      ? List.from(userData[index]['Students'])
                      : [];
                  List<String> tasks = userData[index]['Tasks'] != null
                      ? List.from(userData[index]['Tasks'])
                      : [];

                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.9),
                    shadowColor: Colors.grey.withOpacity(0.5),
                    elevation: 10,
                    margin: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${userData[index]['Name'] ?? ''}',
                              style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Pacifico',
                                  color: Color(0xFF6A0572))),
                          const SizedBox(height: 8.0),
                          Text(
                              'Assigned Students: ${astudents.isNotEmpty ? astudents.join(', ') : ''}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Lobster',
                                  color: Color(0xFFBF0A30))),
                          const SizedBox(height: 8.0),
                          Text(
                              'Tasks: ${tasks.isNotEmpty ? tasks.join(', ') : ''}',
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontFamily: 'Lobster',
                                  color: Color(0xFF6A0572))),
                          const SizedBox(height: 8.0),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      title: const Text('New Task',
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontFamily: 'Pacifico')),
                                      content: TextField(
                                        controller: newTaskController,
                                        decoration: const InputDecoration(
                                          labelText: 'Task',
                                        ),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel',
                                              style: TextStyle(fontSize: 20)),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text('Add',
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Colors.red)),
                                          onPressed: () {
                                            addTask(userData[index]['ID'],
                                                newTaskController.text.trim());
                                            newTaskController.clear();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Text('Add New Task',
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 24, 24, 24))),
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Center(
                              child: Text(
                            "Current Tasks Are",
                            style: TextStyle(
                                fontSize: 35,
                                fontFamily: 'Lobster',
                                color: Colors.black87),
                          )),
                          for (var task in tasks)
                            ListTile(
                              title: Text(task,
                                  style: const TextStyle(
                                      fontFamily: 'Lobster',
                                      color: Color(0xFF6A0572))),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  deleteTask(userData[index]['ID'], task);
                                },
                              ),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
