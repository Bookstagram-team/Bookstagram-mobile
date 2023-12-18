import 'package:flutter/material.dart';
import 'package:bookstagram/left_drawer.dart'; 
import 'package:bookstagram/communities/widgets/event_card.dart';
import 'package:bookstagram/communities/models/event_item.dart'; 
import 'package:bookstagram/communities/screens/event_form.dart'; 
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyEventPage extends StatefulWidget {
  MyEventPage({Key? key}) : super(key: key);

  @override
  _MyEventPageState createState() => _MyEventPageState();
}

Future<List<Product>> fetchEvents() async {
  var url = Uri.parse('http://localhost:8000/communities/show-json/');
  var response = await http.get(url);

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Product.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load events');
  }
}

class _MyEventPageState extends State<MyEventPage> {
  List<Product> events = [];

  void addEvent(Product event) {
    fetchEvents().then((loadedEvents) {
      setState(() {
        events = loadedEvents;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchEvents().then((loadedEvents) {
      setState(() {
        events = loadedEvents;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookstagram'),
      ),
      drawer: const LeftDrawer(),
      body: events.isNotEmpty ? buildEventGrid() : buildEmptyState(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AddEventPage(onSubmit: addEvent),
          ),
        ),
        child: const Icon(Icons.add),
        backgroundColor: Colors.grey, 
      ),
    );
  }

  Widget buildEventGrid() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text(
                'Upcoming Events',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: events.map((event) {
                return EventCard(
                  event: event,
                  onDelete: () => deleteEvent(event),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  void deleteEvent(Product event) {
    fetchEvents().then((loadedEvents) {
      setState(() {
        events.remove(event);
      });
    });
  }

  Widget buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Text(
          'No events available. Tap the + button to add an event.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
