
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:bookstagram/communities/models/book.dart';

// Future<void> addBook(Book book) async {
//   var url = Uri.parse('http://localhost:8000/add-flutter/');  // Ganti dengan URL API Anda
//   var response = await http.post(
//     url,
//     body: json.encode({
//       'isbn': book.isbn,
//       'judul': book.judul,
//       'penulis': book.penulis,
//       'publikasi': book.publikasi.toString(),
//       'publisher': book.publisher,
//       'imageS': book.imageS,
//       'imageM': book.imageM,
//       'imageL': book.imageL,
//       'rating': book.rating.toString(),
//       'urutan': book.rating.toString(),
//     }),
//     headers: {"Content-Type": "application/json"},
//   );

//   if (response.statusCode != 201) {
//     throw Exception('Failed to add book');
//   }
// }

// class ApiService {
//   Future<Book> fetchBookDetails(int pk) async {
//     final response = await http.get(Uri.parse('http://127.0.0.1:8000/get-book-details/$pk/'));
//     if (response.statusCode == 200) {
//       dynamic body = jsonDecode(response.body);
//       Book book = Book.fromJson(body[0]);
//       return book;
//     } else {
//       throw Exception('Failed to load book details.');
//     }
//   }
// }
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
import 'dart:convert' as convert;
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

// class Api {
//   final String baseUrl = "http://localhost:8000";

//   Future<List<Book>> getBooks() async {
//     final response = await http.get(Uri.parse('$baseUrl/book/api/book/'));

//     if (response.statusCode == 200) {
//       List jsonResponse = json.decode(response.body);
//       return jsonResponse.map((item) => Book.fromJson(item)).toList();
//     } else {
//       throw Exception('Failed to load books from API');
//     }
//   }
// }

class Api {
  final String baseUrl = "http://localhost:8000";

  Future<List<Book>> getBooks() async {
    final response = await http.get(Uri.parse('$baseUrl/book/api/book/'));

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Book.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load books from API');
    }
  }
}

// class Api {
//   static const String baseUrl = 'http://localhost:8000/';

//   Future<List<Book>> getBooks({required String sort}) async {
//     var url = Uri.parse(baseUrl + 'book/api/book/' + (sort == 'az' 
//       ? 'sort_az/' 
//       : sort == 'za' ? 'sort_za/' : ''));

//     var response = await http.get(url);
    
//     if (response.statusCode == 200) {
//       var jsonResponse = json.decode(response.body) as List;
//       return jsonResponse.map((book) => Book.fromJson(book)).toList();
//     } else {
//       throw Exception('Failed to load books from API');
//     }
//   }
// }

class ApiService {
  final String baseUrl = "http://localhost:8000/book/api/book/";

  Future<Book> fetchBookDetails(int pk) async {
    final response = await http.get(Uri.parse('$baseUrl$pk/'));

    if (response.statusCode == 200) {
      dynamic body = jsonDecode(response.body);
      Book book = Book.fromJson(body);
      return book;
    } else {
      throw Exception('Failed to load book details.');
    }
  }

  Future<List<Book>> fetchBooks({String sort = ''}) async {
    final response = await http.get(Uri.parse('$baseUrl?sort=$sort'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<Book> books = body.map((dynamic item) => Book.fromJson(item)).toList();
      return books;
    } else {
      throw Exception('Failed to load books.');
    }
  }
  
}