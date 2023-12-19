
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
    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      Book book = Book.fromJson(body[0]);
      return book;
    } else {
      throw Exception('Failed to load book details.');
    }
  }
}