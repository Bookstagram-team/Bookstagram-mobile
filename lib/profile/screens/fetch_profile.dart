import 'dart:convert';
import 'package:bookstagram/profile/models/profile.dart';
import 'package:http/http.dart' as http;

class FetchProfile {
  Future<List<UserProfile>> fetchProfiles() async {
    var url = Uri.parse('http://localhost:8000/show-profile-all/'); // Update the URL based on your API endpoint
    var response = await http.get(url, headers: {"Content-Type": "application/json"});

    if (response.statusCode == 200) {
      List<dynamic> profilesJson = json.decode(response.body)['user_profiles'];
      return profilesJson.map((json) => UserProfile.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load profiles');
    }
  }
}