import 'dart:convert';
import 'package:http/http.dart' as http;

class KnowUserWell {
  final int id;
  final String attribute1;

  KnowUserWell({
    required this.id,
    required this.attribute1,
  });

  factory KnowUserWell.fromJson(Map<String, dynamic> json) {
    return KnowUserWell(
      id: json['id'],
      attribute1: json['attribute1'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'attribute1': attribute1,
    };
  }
}

// Method to fetch serialized JSON data
Future<List<KnowUserWell>> fetchKnowUserWellList() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:8000/know_user_well-single-json/'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<KnowUserWell> knowUserWellList = jsonList.map((json) => KnowUserWell.fromJson(json)).toList();

      return knowUserWellList;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error: $e');
    throw Exception('Failed to load data');
  }
}
