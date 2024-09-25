import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommunityPage extends StatefulWidget {
  final String email, role;
  const CommunityPage({required this.email, required this.role, super.key});
  @override
  _CommunityPageState createState() =>
      _CommunityPageState(email: email, role: role);
}

class _CommunityPageState extends State<CommunityPage> {
  final String email, role;
  _CommunityPageState({required this.email, required this.role});
  final TextEditingController _postController = TextEditingController();
  String? _userRole;
  String? _userName;

  @override
  void initState() {
    super.initState();
    _getUserRole(role);
  }

  Future<void> _getUserRole(String role) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection(role == "MM"
                ? 'Admins'
                : role == "AS"
                    ? 'Assistance'
                    : 'Students')
            .where('Email', isEqualTo: email)
            .limit(1)
            .get();
        if (querySnapshot.docs.isNotEmpty) {
          DocumentSnapshot userDoc = querySnapshot.docs.first;
          setState(() {
            _userRole = userDoc['Role'];
            _userName = userDoc['Name'];
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('No user found with the email $email')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error fetching user data: $e')),
        );
      }
    }
  }

  Future<void> _postMessage() async {
    if (_postController.text.isEmpty) return;

    try {
      await FirebaseFirestore.instance.collection('CommunityPosts').add({
        'text': _postController.text,
        'author': _userName,
        'role': _userRole,
        'email': email,
        'likes': 0,
        'dislikes': 0,
        'likedBy': [],
        'dislikedBy': [],
        'timestamp': FieldValue.serverTimestamp(),
      });
      _postController.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error posting message: $e')),
      );
    }
  }

  Future<void> _toggleLike(String postId, bool isLike) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    try {
      DocumentReference postRef =
          FirebaseFirestore.instance.collection('CommunityPosts').doc(postId);
      DocumentSnapshot postSnapshot = await postRef.get();
      List likedBy = postSnapshot['likedBy'];
      List dislikedBy = postSnapshot['dislikedBy'];
      if (isLike) {
        if (likedBy.contains(user.email)) {
          await postRef.update({
            'likes': FieldValue.increment(-1),
            'likedBy': FieldValue.arrayRemove([user.email]),
          });
        } else {
          await postRef.update({
            'likes': FieldValue.increment(1),
            'likedBy': FieldValue.arrayUnion([user.email]),
            'dislikes': dislikedBy.contains(user.email)
                ? FieldValue.increment(-1)
                : FieldValue.increment(0),
            'dislikedBy': FieldValue.arrayRemove([user.email]),
          });
        }
      } else {
        if (dislikedBy.contains(user.email)) {
          await postRef.update({
            'dislikes': FieldValue.increment(-1),
            'dislikedBy': FieldValue.arrayRemove([user.email]),
          });
        } else {
          await postRef.update({
            'dislikes': FieldValue.increment(1),
            'dislikedBy': FieldValue.arrayUnion([user.email]),
            'likes': likedBy.contains(user.email)
                ? FieldValue.increment(-1)
                : FieldValue.increment(0),
            'likedBy': FieldValue.arrayRemove([user.email]),
          });
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error toggling like/dislike: $e')),
      );
    }
  }

  Future<void> _deletePost(String postId) async {
    try {
      await FirebaseFirestore.instance
          .collection('CommunityPosts')
          .doc(postId)
          .delete();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting post: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 41, 50, 65),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10,
        backgroundColor: const Color.fromARGB(255, 160, 219, 248),
        title: Center(
          child: Text(
            'Community',
            style: GoogleFonts.pacifico(
              fontSize: 30,
              color: const Color.fromARGB(255, 0, 0, 0),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          if (_userRole != null)
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('CommunityPosts')
                    .orderBy('timestamp', descending: false)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                        child: Text(
                      'No posts yet.',
                      style: TextStyle(color: Colors.white),
                    ));
                  }

                  final posts = snapshot.data!.docs;
                  return ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      final post = posts[index];
                      final postId = post.id;
                      final text = post['text'];
                      final author = post['author'];
                      final role = post['role'];
                      final email = post['email'];
                      final likes = post['likes'];
                      final dislikes = post['dislikes'];
                      final likedBy = post['likedBy'] as List;
                      final dislikedBy = post['dislikedBy'] as List;
                      final userLiked = likedBy.contains(widget.email);
                      final userDisliked = dislikedBy.contains(widget.email);

                      return Card(
                        elevation: 10,
                        color: role == "MM"
                            ? const Color.fromARGB(255, 255, 178, 172)
                            : role == "AS"
                                ? const Color.fromARGB(255, 255, 210, 167)
                                : const Color.fromARGB(255, 255, 255, 255),
                        margin:
                            const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListTile(
                          subtitle: Text(
                            text,
                            style: const TextStyle(fontSize: 20),
                          ),
                          title: Text(
                            '$author (${role == "MM" ? "Teacher" : role == "AS" ? "Assistant" : "Student"})',
                            style: const TextStyle(fontSize: 12),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (email == widget.email ||
                                  role != "" && role != "MM" && role != "AS")
                                IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () => _deletePost(postId),
                                ),
                              IconButton(
                                icon: Icon(
                                  Icons.thumb_up,
                                  color: userLiked
                                      ? const Color.fromARGB(255, 27, 94, 99)
                                      : const Color.fromARGB(255, 73, 69, 79),
                                ),
                                onPressed: () => _toggleLike(postId, true),
                              ),
                              Text(likes.toString()),
                              IconButton(
                                icon: Icon(
                                  Icons.thumb_down,
                                  color: userDisliked
                                      ? const Color.fromARGB(255, 27, 94, 99)
                                      : const Color.fromARGB(255, 73, 69, 79),
                                ),
                                onPressed: () => _toggleLike(postId, false),
                              ),
                              Text(dislikes.toString()),
                            ],
                          ),
                        ),
                      );
                    },
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
                    cursorColor: Colors.white,
                    style: const TextStyle(color: Colors.white),
                    controller: _postController,
                    decoration: InputDecoration(
                        labelText: 'Write a post...',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelStyle: const TextStyle(color: Colors.white)),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  onPressed: _postMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
