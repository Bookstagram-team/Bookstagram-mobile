import 'package:flutter/material.dart';

class EventItem {
  final String title;
  final String eventDate;
  final String eventPhoto;
  final double eventPrice;
  final IconData icon;

  EventItem(this.title, this.eventDate, this.eventPhoto, this.eventPrice, this.icon);
}
