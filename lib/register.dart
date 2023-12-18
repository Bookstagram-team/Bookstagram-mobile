import 'package:bookstagram/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isCustomer = false;
  bool isEmployee = false;

  Future<void> registerUser() async {
    var url = Uri.parse('http://localhost:8000/auth/register/');
    var response = await http.post(
      url,
      body: json.encode({
        'username': _usernameController.text,
        'password': _passwordController.text,
        'is_customer': isCustomer,
        'is_employee': isEmployee
      }),
      headers: {"Content-Type": "application/json"}
    );
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registration Successful!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()), 
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Please enter a username';
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Please enter a password';
                return null;
              },
            ),
            CheckboxListTile(
              title: Text("Is Reader"),
              value: isCustomer,
              onChanged: (newValue) {
                setState(() {
                  isCustomer = newValue ?? false;
                  if (isCustomer) { 
                    isEmployee = false;
                  }
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            CheckboxListTile(
              title: Text("Is Author"),
              value: isEmployee,
              onChanged: (newValue) {
                setState(() {
                  isEmployee = newValue ?? false;
                  if (isEmployee) { 
                    isCustomer = false;
                  }
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  registerUser();
                }
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }
}