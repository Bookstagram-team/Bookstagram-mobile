// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'package:bookstagram/communities/models/book.dart';

// Future<void> addBook(Book book) async {
//   var url = Uri.parse('http://localhost:8000/add-flutter/');  // Ganti dengan URL API Anda
//   var response = await http.post(url, body: {
//     'isbn': book.isbn,
//     'judul': book.judul,
//     'penulis': book.penulis,
//     'publikasi': book.publikasi.toString(),
//     'publisher': book.publisher,
//     'imageS': book.imageS,
//     'imageM': book.imageM,
//     'imageL': book.imageL,
//     'rating': book.rating.toString(),
//   });

//   if (response.statusCode != 201) {
//     throw Exception('Failed to add book');
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bookstagram/communities/models/book.dart';

Future<void> addBook(Book book) async {
  var url = Uri.parse('http://localhost:8000/add-flutter/');  // Ganti dengan URL API Anda
  var response = await http.post(
    url,
    body: json.encode({
      'isbn': book.isbn,
      'judul': book.judul,
      'penulis': book.penulis,
      'publikasi': book.publikasi.toString(),
      'publisher': book.publisher,
      'imageS': book.imageS,
      'imageM': book.imageM,
      'imageL': book.imageL,
      'rating': book.rating.toString(),
      'urutan': book.rating.toString(),
    }),
    headers: {"Content-Type": "application/json"},
  );

  if (response.statusCode != 201) {
    throw Exception('Failed to add book');
  }
}

class ApiService {
  Future<Book> fetchBookDetails(int pk) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/get-book-details/$pk/'));
//     if (response.statusCode == 200) {
//   dynamic body = jsonDecode(response.body);
//   Map<String, dynamic> bookData = body[0]['fields'];

//   // Ubah string ke integer untuk field 'pk', 'publikasi', 'rating', dan 'urutan'
//   if (bookData['pk'] is String) {
//     bookData['pk'] = int.parse(bookData['pk']);
//   }
//   if (bookData['publikasi'] is String) {
//     bookData['publikasi'] = int.parse(bookData['publikasi']);
//   }
//   if (bookData['rating'] is String) {
//     bookData['rating'] = int.parse(bookData['rating']);
//   }
//   if (bookData['urutan'] is String) {
//     bookData['urutan'] = int.parse(bookData['urutan']);
//   }
  
//   Book book = Book.fromJson(bookData);
//   return book;

// } else {
//   throw Exception('Failed to load book details.');
// }

if (response.statusCode == 200) {
  dynamic body = jsonDecode(response.body);
  Book book = Book.fromJson(body[0]);
  return book;
} else {
  throw Exception('Failed to load book details.');
}



  }
}

