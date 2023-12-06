import 'package:flutter/material.dart';
import 'package:bookstagram/models/event_item.dart';

class EventCard extends StatelessWidget {
  final EventItem event;
  final VoidCallback onDelete;

  EventCard({required this.event, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(10),
      elevation: 4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Image.network(
            event.eventPhoto,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                color: Colors.grey,
                alignment: Alignment.center,
                child: Text('Image not available', style: TextStyle(fontSize: 16)),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(event.title, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Row(
                  children: <Widget>[
                    Icon(event.icon, size: 24),
                    SizedBox(width: 10),
                    Text(event.eventDate, style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 5),
                Text('Price: ${event.eventPrice}', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: onDelete,
                style: TextButton.styleFrom(
                  primary: Colors.red, // This is the text color
                ),
                child: Text('Delete'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
