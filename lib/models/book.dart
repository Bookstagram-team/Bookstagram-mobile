class Book {
  final int pk;
  final int urutan;
  final String isbn;
  final String judul;
  final String penulis;
  final int publikasi;
  final String publisher;
  final String imageS;
  final String imageM;
  final String imageL;
  final int rating;

  Book({
    required this.pk,
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
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      pk: json['pk'],
      urutan: json['fields']['Urutan'],
      isbn: json['fields']['ISBN'],
      judul: json['fields']['Judul'],
      penulis: json['fields']['Penulis'],
      publikasi: json['fields']['Publikasi'],
      publisher: json['fields']['Publisher'],
      imageS: json['fields']['ImageS'],
      imageM: json['fields']['ImageM'],
      imageL: json['fields']['ImageL'],
      rating: json['fields']['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pk': pk,
      'fields': {
        'Urutan': urutan,
        'ISBN': isbn,
        'Judul': judul,
        'Penulis': penulis,
        'Publikasi': publikasi,
        'Publisher': publisher,
        'ImageS': imageS,
        'ImageM': imageM,
        'ImageL': imageL,
        'rating': rating,
      }
    };
  }
}