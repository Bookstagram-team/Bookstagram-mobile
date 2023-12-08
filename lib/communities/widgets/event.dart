import 'package:flutter/material.dart';
import 'package:bookstagram/left_drawer.dart'; 
import 'package:bookstagram/communities/widgets/event_card.dart';
import 'package:bookstagram/communities/models/event_item.dart'; 
import 'package:bookstagram/communities/screens/event_form.dart'; 

class MyEventPage extends StatefulWidget {
  MyEventPage({Key? key}) : super(key: key);

  @override
  _MyEventPageState createState() => _MyEventPageState();
}

class _MyEventPageState extends State<MyEventPage> {
  List<Product> events = [];

  void addEvent(Product event) {
    setState(() {
      events.add(event);
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
        backgroundColor: Colors.grey, // Adjust color as needed
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
    setState(() {
      events.remove(event);
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
