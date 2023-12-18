import 'dart:convert';
import 'package:bookstagram/profile/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';  // Pastikan import ini sesuai dengan struktur proyek Anda

class EditBioForm extends StatefulWidget {
  final Function(UserProfile) onSubmit;

  EditBioForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _EditBioFormState createState() => _EditBioFormState();
}

class _EditBioFormState extends State<EditBioForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Bio'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _bioController,
                maxLines: 4,
                decoration: InputDecoration(
                  labelText: 'Bio',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your bio';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _submitForm();
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> bioData = {
        "bio": _bioController.text,
      };

      final CookieRequest request =
          Provider.of<CookieRequest>(context, listen: false);
      final response = await request.postJson(
        "http://localhost:8000/update-bio/", // Ganti dengan URL endpoint server Anda
        jsonEncode(bioData),
      );

      if (response['status'] == 'success') {
        UserProfile updatedProfile =
            UserProfile.fromJson(response['user_profile']);
        widget.onSubmit(updatedProfile);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Bio successfully updated!")),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("There was an error, please try again.")),
        );
      }
    }
  }
}