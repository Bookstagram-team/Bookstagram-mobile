import 'package:bookstagram/communities/models/book.dart';
// import 'package:bookstagram/communities/screens/bookdata.dart';
import 'package:flutter/material.dart';
import 'package:bookstagram/katalog_buku/book_detail_page.dart';
import 'package:bookstagram/katalog_buku/api.dart';
import 'package:bookstagram/katalog_buku/add_book_page.dart';
import 'package:bookstagram/communities/screens/bookdata.dart';

class KatalogBukuPage extends StatefulWidget {
@override
_KatalogBukuPageState createState() => _KatalogBukuPageState();
}

class _KatalogBukuPageState extends State<KatalogBukuPage> {
Api api = Api();
late Future<List<Book>> books;

@override
void initState() {
super.initState();
books = api.getBooks();
}

@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar(
title: Text('Katalog Buku'),
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
return ListView.builder(
itemCount: snapshot.data!.length,
itemBuilder: (BuildContext context, int index) {
final book = snapshot.data![index];
return ListTile(
leading: book.imageL.isEmpty
? CircleAvatar(child: Icon(Icons.book))
: CircleAvatar(backgroundImage: NetworkImage(book.imageL)),
title: Text(book.judul),
subtitle: Text('Author: ${book.penulis}\nPublisher: ${book.publisher}'),
trailing: IconButton(
icon: Icon(Icons.info),
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => BookDetailPage(book: book)),

                    // MaterialPageRoute(builder: (context) => BookDetailPage(bookId: book.pk)),  
                  );
                },
              ),
            );
          },
        );
      }
    },
  ),
  floatingActionButton: FloatingActionButton(
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(builder: (context) => AddBookPage()),
).then((_) {
setState(() {
books = api.getBooks();  // Ubah bagian ini
// books = api.fetchBooks(); 
});
});
},
child: Icon(Icons.add),
),
);
}
}

// class KatalogBukuPage extends StatefulWidget {
//   @override
//   _KatalogBukuPageState createState() => _KatalogBukuPageState();
// }

// class _KatalogBukuPageState extends State<KatalogBukuPage> {
//   Api api = Api();
//   late Future<List<Book>> _futureBooks;
//   String _sort = 'az';

//   @override
//   void initState() {
//     super.initState();
//     _futureBooks = api.getBooks(sort: _sort);
//   }

//   void _sortBooks(String sort) {
//     setState(() {
//       _sort = sort;
//       _futureBooks = api.getBooks(sort: _sort);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Katalog Buku'),
//         actions: <Widget>[
//           DropdownButton<String>(
//             value: _sort,
//             onChanged: (String? newValue) {
//               if (newValue != null) {
//                 _sortBooks(newValue);
//               }
//             },
//             items: <String>['az', 'za'].map<DropdownMenuItem<String>>((String value) {
//               return DropdownMenuItem<String>(
//                 value: value,
//                 child: Text(value.toUpperCase()),
//               );
//             }).toList(),
//           )
//         ],
//       ),
//       body: FutureBuilder<List<Book>>(
//         future: _futureBooks,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (!snapshot.hasData) {
//             return Center(child: Text('No books found'));
//           } else {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final book = snapshot.data![index];
//                 return ListTile(
//                   title: Text(book.judul),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }