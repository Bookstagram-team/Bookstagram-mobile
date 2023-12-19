import 'package:flutter/material.dart';
import 'package:bookstagram/communities/models/book.dart';
import 'package:flutter/material.dart';
import 'package:bookstagram/communities/models/book.dart';
import 'package:bookstagram/katalog_buku/api.dart';

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


// class BookDetailPage extends StatefulWidget {
//   final int bookId;

//   BookDetailPage({required this.bookId});

//   @override
//   _BookDetailPageState createState() => _BookDetailPageState();
// }

// class _BookDetailPageState extends State<BookDetailPage> {
//   late Future<Book> futureBook;
//   final apiService = ApiService();  // create instance of ApiService

//   @override
//   void initState() {
//     super.initState();
//     futureBook = apiService.fetchBookDetails(widget.bookId);  // use instance method
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Book Details'),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.0),
//         child: FutureBuilder<Book>(
//           future: futureBook,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Center(
//                     child: snapshot.data!.imageL.isEmpty
//                         ? Image.asset('assets/images/no_image.png', width: 200)
//                         : Image.network(snapshot.data!.imageL, width: 200),
//                   ),
//                   SizedBox(height: 20),
//                   Text('Title: ${snapshot.data!.judul}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                   Text('Author: ${snapshot.data!.penulis}', style: TextStyle(fontSize: 16)),
//                   Text('Publisher: ${snapshot.data!.publisher}', style: TextStyle(fontSize: 16)),
//                   Text('Publication Year: ${snapshot.data!.publikasi}', style: TextStyle(fontSize: 16)),
//                   Text('ISBN: ${snapshot.data!.isbn}', style: TextStyle(fontSize: 16)),
//                   Text('Rating: ${snapshot.data!.rating}', style: TextStyle(fontSize: 16)),
//                 ],
//               );
//             } else if (snapshot.hasError) {
//               return Text("${snapshot.error}");
//             }

//             // By default, show a loading spinner.
//             return CircularProgressIndicator();
//           },
//         ),
//       ),
//     );
//   }
// }
