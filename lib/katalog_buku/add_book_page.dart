
import 'package:flutter/material.dart';
import 'package:bookstagram/communities/models/book.dart';
import 'package:bookstagram/katalog_buku/api.dart'; 
class AddBookPage extends StatefulWidget {
  @override
  _AddBookPageState createState() => _AddBookPageState();
}

class _AddBookPageState extends State<AddBookPage> {
  final _formKey = GlobalKey<FormState>();
  final _bookIsbnController = TextEditingController();
  final _bookJudulController = TextEditingController();
  final _bookPenulisController = TextEditingController();
  final _bookPublikasiController = TextEditingController();
  final _bookPublisherController = TextEditingController();
  final _bookImageSController = TextEditingController();
  final _bookImageMController = TextEditingController();
  final _bookImageLController = TextEditingController();
  final _bookRatingController = TextEditingController();
  final _bookUrutanController = TextEditingController();

  @override
  void dispose() {
    _bookIsbnController.dispose();
    _bookJudulController.dispose();
    _bookPenulisController.dispose();
    _bookPublikasiController.dispose();
    _bookPublisherController.dispose();
    _bookImageSController.dispose();
    _bookImageMController.dispose();
    _bookImageLController.dispose();
    _bookRatingController.dispose();
    _bookUrutanController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Book'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _bookIsbnController,
              decoration: InputDecoration(labelText: 'ISBN'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the ISBN';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _bookJudulController,
              decoration: InputDecoration(labelText: 'Judul'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the judul';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _bookPenulisController,
              decoration: InputDecoration(labelText: 'Penulis'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the penulis';
                }
                return null;
              },
            ),
            TextFormField(
  controller: _bookPublikasiController,
  decoration: InputDecoration(labelText: 'Publikasi'),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the publikasi';
    }
    return null;
  },
),
TextFormField(
  controller: _bookPublisherController,
  decoration: InputDecoration(labelText: 'Publisher'),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the publisher';
    }
    return null;
  },
),
TextFormField(
  controller: _bookImageSController,
  decoration: InputDecoration(labelText: 'Image S'),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the Image S';
    }
    return null;
  },
),
TextFormField(
  controller: _bookImageMController,
  decoration: InputDecoration(labelText: 'Image M'),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the Image M';
    }
    return null;
  },
),
TextFormField(
  controller: _bookImageLController,
  decoration: InputDecoration(labelText: 'Image L'),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the Image L';
    }
    return null;
  },
),
TextFormField(
  controller: _bookRatingController,
  decoration: InputDecoration(labelText: 'Rating'),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the rating';
    }
    return null;
  },
),
TextFormField(
  controller: _bookUrutanController,
  decoration: InputDecoration(labelText: 'Urutan'),
  validator: (value) {
    if (value == null || value.isEmpty) {
      return 'Please enter the Urutan';
    }
    return null;
  },
),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  Book newBook = Book.newBook(
                  urutan: int.parse(_bookUrutanController.text),
                  isbn: _bookIsbnController.text,
                  judul: _bookJudulController.text,
                  penulis: _bookPenulisController.text,
                  publikasi: int.parse(_bookPublikasiController.text),
                  publisher: _bookPublisherController.text,
                  imageS: _bookImageSController.text,
                  imageM: _bookImageMController.text,
                  imageL: _bookImageLController.text,
                  rating: int.parse(_bookRatingController.text),
                  );
                  await addBook(newBook);  // Memanggil fungsi addBook dari api.dart
                  Navigator.of(context).pop();
                }
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}