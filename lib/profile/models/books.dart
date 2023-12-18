class BookAmbil {
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

  BookAmbil({
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
  });

  factory BookAmbil.fromJson(Map<String, dynamic> json) {
    return BookAmbil(
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
    );
  }

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
      }
    };
  }
}
