import 'package:bookstagram/models/event_item.dart';
import 'package:flutter/material.dart';

class AddEventPage extends StatefulWidget {
  final Function(EventItem) onSubmit;

  AddEventPage({Key? key, required this.onSubmit}) : super(key: key);
  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final _formKey = GlobalKey<FormState>();
  String eventName = '';
  DateTime eventDate = DateTime.now();
  String eventPhoto = ''; 
  double eventPrice = 0.0;
  TextEditingController _dateController = TextEditingController();

  @override
  void dispose() {
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
        _dateController.text = "${eventDate.toLocal()}".split(' ')[0]; 
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
                decoration: InputDecoration(labelText: 'Event Name'),
                onSaved: (value) {
                  eventName = value!;
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
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Event Photo URL'),
                onSaved: (value) {
                  eventPhoto = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Event Price'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  eventPrice = double.tryParse(value!) ?? 0.0;
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

  void _submitForm() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      String formattedDate = "${eventDate.toLocal()}".split(' ')[0];
      EventItem newEvent = EventItem(eventName, formattedDate, eventPhoto, eventPrice, Icons.event); 
      widget.onSubmit(newEvent); 
      Navigator.pop(context);
    }
  }
}
