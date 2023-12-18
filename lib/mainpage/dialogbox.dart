import 'dart:convert';
import 'package:bookstagram/mainpage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

class DialogBox extends StatefulWidget {
  const DialogBox({super.key});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _rating = 0;
  String _comment = "";

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'Tell us your thoughts!',
          ),
        ),
        backgroundColor: Color.fromARGB(255, 254, 254, 254),
        foregroundColor: const Color.fromARGB(255, 0, 0, 0),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Your Name",
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _name = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Name is empty!";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Rate this app",
                labelText: "Rate",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _rating = int.parse(value!);
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Rating is empty!";
                }
                if (int.tryParse(value) == null) {
                  return "Rating should be in numbers!";
                } else if (int.parse(value) > 5 || int.parse(value) < 0) {
                  return "Rate from 0 to 5";
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Add a comment",
                labelText: "Comment",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              onChanged: (String? value) {
                setState(() {
                  _comment = value!;
                });
              },
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return "Comment is empty!";
                }
                return null;
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 197, 138, 28)),
                ),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Kirim ke Django dan tunggu respons
                    final response = await request.postJson(
                        "http://127.0.0.1:8000/comment-flutter/",
                        jsonEncode(<String, String>{
                          'name': _name,
                          'rating': _rating.toString(),
                          'comment': _comment,
                        }));
                    if (response['status'] == 'success') {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Saved!"),
                      ));
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LandingPage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Failed to save. Try Again!"),
                      ));
                    }
                  }
                },
                child: const Text(
                  "Save",
                  style: TextStyle(color: Color.fromARGB(255, 7, 7, 7)),
                ),
              ),
            ),
          ),
        ])),
      ),
    );
  }
}