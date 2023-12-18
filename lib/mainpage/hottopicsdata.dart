import 'dart:convert';
import 'package:bookstagram/communities/models/book.dart';
import 'package:http/http.dart' as http;

class HotTopicBooks {
  Future<List<Book>> fetchBooks() async {
    var url = Uri.parse(
        'http://localhost:8000/book/api/book/'); // Replace with your actual URL
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      List<dynamic> booksJson = json.decode(response.body);

      List<Book> tenStarBooks = booksJson
          .map((json) => Book.fromJson(json))
          .where((book) => book.rating == 10)
          .toList();

      List<Book> limitedBooks =
          tenStarBooks.length > 5 ? tenStarBooks.sublist(0, 5) : tenStarBooks;

      return limitedBooks;
    } else {
      throw Exception('Failed to load books');
    }
  }
}