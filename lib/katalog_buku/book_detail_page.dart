import 'package:flutter/material.dart';
import 'package:bookstagram/communities/models/book.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  BookDetailPage({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book.judul),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: book.imageL.isEmpty
                  ? Image.asset('assets/images/no_image.png', width: 200)
                  : Image.network(book.imageL, width: 200),
            ),
            SizedBox(height: 20),
            Text('Title: ${book.judul}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Author: ${book.penulis}', style: TextStyle(fontSize: 16)),
            Text('Publisher: ${book.publisher}', style: TextStyle(fontSize: 16)),
            Text('Publication Year: ${book.publikasi}', style: TextStyle(fontSize: 16)),
            Text('ISBN: ${book.isbn}', style: TextStyle(fontSize: 16)),
            Text('Rating: ${book.rating}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}