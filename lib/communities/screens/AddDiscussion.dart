import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bookstagram/login.dart';
import 'package:bookstagram/communities/screens/discussion.dart';



class NewDiscussionPage extends StatefulWidget {
  const NewDiscussionPage({Key? key}) : super(key: key);

  @override
  _NewDiscussionPageState createState() => _NewDiscussionPageState();
}

class _NewDiscussionPageState extends State<NewDiscussionPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> _submitDiscussion() async {
    if (_formKey.currentState!.validate()) {
      final request = context.read<CookieRequest>();
      final user = await request.get('http://127.0.0.1:8000/discussion/create-flutter-post/');
      final List<String> profile = [];
      user.forEach((key, value) {
        profile.add(value);
      });

      var url = Uri.parse('http://127.0.0.1:8000/discussion/create-flutter-post/');
      var response = await request.postJson(
        'http://127.0.0.1:8000/discussion/create-flutter-post/',
        jsonEncode({
          'title': _titleController.text,
          'body': _contentController.text,
          'author': LoginPage.usernamePass, // Assuming the username is at index 0
        }),
      );

      if (response['status'] == 'success') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Discussion added successfully!"),
        ));

        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DiscussionPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Error adding discussion. Please try again."),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Discussion'),
      ),
      backgroundColor: Color.fromARGB(255, 228, 155, 52),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle: TextStyle(
                    color: Colors.deepPurple, // Adjust label text color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple), // Adjust focused border color
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _contentController,
                decoration: InputDecoration(
                  labelText: 'Content',
                  labelStyle: TextStyle(
                    color: Colors.deepPurple, // Adjust label text color
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple), // Adjust focused border color
                  ),
                ),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter content';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitDiscussion,
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple, // Adjust button color
                ),
                child: const Text(
                  'Submit Discussion',
                  style: TextStyle(
                    color: Colors.white, // Adjust text color
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}