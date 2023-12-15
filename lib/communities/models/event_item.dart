// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

List<Product> productFromJson(String str) => List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
    String model;
    int pk;
    Fields fields;

    Product({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String namaEvent;
    DateTime tanggalPelaksanaan;
    String foto;
    int harga;

    Fields({
        required this.namaEvent,
        required this.tanggalPelaksanaan,
        required this.foto,
        required this.harga,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        namaEvent: json["nama_event"],
        tanggalPelaksanaan: DateTime.parse(json["tanggal_pelaksanaan"]),
        foto: json["foto"],
        harga: json["harga"],
    );

    Map<String, dynamic> toJson() => {
        "nama_event": namaEvent,
        "tanggal_pelaksanaan": "${tanggalPelaksanaan.year.toString().padLeft(4, '0')}-${tanggalPelaksanaan.month.toString().padLeft(2, '0')}-${tanggalPelaksanaan.day.toString().padLeft(2, '0')}",
        "foto": foto,
        "harga": harga,
    };
}