// product.dart
// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  List<PostList> postList;

  Product({
    required this.postList,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        postList: List<PostList>.from(
            json["post_list"].map((x) => PostList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "post_list": List<dynamic>.from(postList.map((x) => x.toJson())),
      };
}

class PostList {
  int id;
  String author;
  String title;
  String content;
  DateTime createdOn;

  PostList({
    required this.id,
    required this.author,
    required this.title,
    required this.content,
    required this.createdOn,
  });

  factory PostList.fromJson(Map<String, dynamic> json) => PostList(
        id: json["id"],
        author: json["author"],
        title: json["title"],
        content: json["content"],
        createdOn: DateTime.parse(json["created_on"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "author": author,
        "title": title,
        "content": content,
        "created_on": createdOn.toIso8601String(),
      };
}
