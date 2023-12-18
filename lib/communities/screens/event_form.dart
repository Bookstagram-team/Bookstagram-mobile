import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';
import 'package:bookstagram/communities/models/event_item.dart';  // Ensure this import is correct

class AddEventPage extends StatefulWidget {
  final Function(Product) onSubmit;

  AddEventPage({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventPhotoController = TextEditingController();
  final TextEditingController _eventPriceController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime eventDate = DateTime.now();

  @override
  void dispose() {
    _eventNameController.dispose();
    _eventPhotoController.dispose();
    _eventPriceController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: eventDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != eventDate) {
      setState(() {
        eventDate = picked;
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Event'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _eventNameController,
                decoration: InputDecoration(labelText: 'Event Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Event Date',
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode()); 
                  _pickDate(context);
                },
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please pick a date';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _eventPhotoController,
                decoration: InputDecoration(labelText: 'Event Photo URL'),
              ),
              TextFormField(
                controller: _eventPriceController,
                decoration: InputDecoration(labelText: 'Event Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter event price';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final Map<String, dynamic> eventData = {
        "nama_event": _eventNameController.text,
        "tanggal_pelaksanaan": "${eventDate.toIso8601String()}",
        "foto": _eventPhotoController.text,
        "harga": int.tryParse(_eventPriceController.text) ?? 0,
      };

      final CookieRequest request = Provider.of<CookieRequest>(context, listen: false);
      final response = await request.postJson(
        "http://localhost:8000/create-flutter/",
        jsonEncode(eventData),
      );

      if (response['status'] == 'success') {
        String modelName = 'event_model'; 
        int primaryKey = DateTime.now().millisecondsSinceEpoch; 
        Product newProduct = Product(
          model: modelName,
          pk: primaryKey,
          fields: Fields(
            namaEvent: _eventNameController.text,
            tanggalPelaksanaan: eventDate, 
            foto: _eventPhotoController.text,
            harga: int.tryParse(_eventPriceController.text) ?? 0,
          ),
        );

        widget.onSubmit(newProduct);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Event successfully added!")),
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