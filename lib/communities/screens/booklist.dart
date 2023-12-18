import 'package:bookstagram/communities/models/book.dart';
import 'package:bookstagram/communities/screens/bookdata.dart';
import 'package:flutter/material.dart';

class BookListPage extends StatefulWidget {
  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  late Future<List<Book>> books;

  @override
  void initState() {
    super.initState();
    books = BookRepository().fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book List'),
      ),
      body: FutureBuilder<List<Book>>(
        future: books,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return Center(child: Text('No books found'));
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
                childAspectRatio: (1 / 1.5), 
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                final book = snapshot.data![index];
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch, 
                    children: <Widget>[
                      Expanded(
                        child: Image.network(
                          book.imageL, 
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center, 
                          children: <Widget>[
                            Text(
                              book.judul,
                              style: TextStyle(
                                fontSize: 16, 
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center, 
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 4), 
                            Text(
                              'Author: ${book.penulis}',
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center, 
                            ),
                            Text(
                              'Publisher: ${book.publisher}',
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              'Rating: ${book.rating}',
                              style: TextStyle(fontSize: 12),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
