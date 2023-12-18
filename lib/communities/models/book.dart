class Book {
  final int pk;
  final String isbn;
  final String judul;
  final String penulis;
  final int publikasi;
  final String publisher;
  final String imageS;
  final String imageM;
  final String imageL;
  final int rating;
  final int urutan;

  Book({
    required this.pk,
    required this.isbn,
    required this.judul,
    required this.penulis,
    required this.publikasi,
    required this.publisher,
    required this.imageS,
    required this.imageM,
    required this.imageL,
    required this.rating,
    required this.urutan,
  });

  Book.newBook({
  required this.urutan,
  required this.isbn,
  required this.judul,
  required this.penulis,
  required this.publikasi,
  required this.publisher,
  required this.imageS,
  required this.imageM,
  required this.imageL,
  required this.rating,
}) : pk = 0;

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      pk: json['pk'],
      isbn: json['fields']['ISBN'],
      judul: json['fields']['Judul'],
      penulis: json['fields']['Penulis'],
      publikasi: json['fields']['Publikasi'],
      publisher: json['fields']['Publisher'],
      imageS: json['fields']['ImageS'],
      imageM: json['fields']['ImageM'],
      imageL: json['fields']['ImageL'],
      rating: json['fields']['Rating'],
      urutan: json['fields']['Urutan'],
    );
  }

// factory Book.fromJson(Map<String, dynamic> json) {
//   return Book(
//     pk: json['pk'] ?? 0,
//     isbn: json['fields']['ISBN'] ?? '',
//     judul: json['fields']['Judul'] ?? '',
//     penulis: json['fields']['Penulis'] ?? '',
//     publikasi: json['fields']['Publikasi'] ?? 0,
//     publisher: json['fields']['Publisher'] ?? '',
//     imageS: json['fields']['ImageS'] ?? '',
//     imageM: json['fields']['ImageM'] ?? '',
//     imageL: json['fields']['ImageL'] ?? '',
//     rating: json['fields']['Rating'] ?? 0,
//     urutan: json['fields']['Urutan'] ?? 0,
//   );
// }

  Map<String, dynamic> toJson() {
    return {
      'pk': pk,
      'fields': {
        'ISBN': isbn,
        'Judul': judul,
        'Penulis': penulis,
        'Publikasi': publikasi,
        'Publisher': publisher,
        'ImageS': imageS,
        'ImageM': imageM,
        'ImageL': imageL,
        'Rating': rating,
        'Urutan': urutan,
      }
    };
  }
}
