import 'dart:convert';
import 'package:bookstagram/mainpage/comment.dart';
import 'package:http/http.dart' as http;

class ShowComment {
  Future<List<Comment>> fetchComment() async {
    // TODO: Ganti URL dan jangan lupa tambahkan trailing slash (/) di akhir URL!
    var url = Uri.parse('http://localhost:8000/get-item/');
    var response =
        await http.get(url, headers: {"Content-Type": "application/json"});

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Comment> list_comment = [];
    for (var d in data) {
      if (d != null) {
        list_comment.add(Comment.fromJson(d));
      }
    }
    return list_comment;
  }
}