import 'package:flutter/material.dart';
import 'package:bookstagram/communities/models/event_item.dart';

class EventCard extends StatelessWidget {
  final Product event;
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
            event.fields.foto,
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
                Text(event.fields.namaEvent, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Row(
                  children: <Widget>[
                    // Icon placeholder if you have an icon
                    SizedBox(width: 10),
                    Text(
                      "${event.fields.tanggalPelaksanaan.year.toString()}-${event.fields.tanggalPelaksanaan.month.toString().padLeft(2, '0')}-${event.fields.tanggalPelaksanaan.day.toString().padLeft(2, '0')}", 
                      style: TextStyle(fontSize: 16)
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text('Price: ${event.fields.harga}', style: TextStyle(fontSize: 18)),
              ],
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              TextButton(
                onPressed: onDelete,
                style: TextButton.styleFrom(primary: Colors.red),
                child: Text('Delete'),
              ),
              
            ],
          ),
        ],
      ),
    );
  }
}