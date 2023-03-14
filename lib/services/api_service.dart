import 'dart:convert';

import 'package:http/http.dart';
import 'package:restapp/models/cases.dart';

class ApiService {
  //final Uri apiUrl = Uri.parse('http://192.168.0.7:3000/api');
  final Uri apiUrl = Uri.parse('http://127.0.0.1:3004/cases');
  Future<List<Cases>> getCases() async {
    Response res = await get(apiUrl);
    
    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);
      List<Cases> cases =
          body.map((dynamic item) => Cases.fromJson(item)).toList();
         // print(cases);
      return cases;
    } else {
      throw Exception('Failed to load cases list');
    }
  }

  Future<Cases> getCaseById(String id) async {
    final response = await get(Uri.parse('http://127.0.0.1:3004/cases/$id'));

    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load a case');
    }
  }

  Future<Cases> createCase(Cases cases) async {
    Map data = {
      'name': cases.name,
      'gender': cases.gender,
      'age': cases.age,
      'address': cases.address,
      'city': cases.city,
      'country': cases.country,
      'status': cases.status,
      'updated': DateTime.now().toString().substring(0, 10)
    };

    final Response response = await post(
      apiUrl,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 201) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to post cases');
    }
  }

  Future<Cases> updateCases(String id, Cases cases) async {
    Map data = {
      'name': cases.name,
      'gender': cases.gender,
      'age': cases.age,
      'address': cases.address,
      'city': cases.city,
      'country': cases.country,
      'status': cases.status,
      'updated': DateTime.now().toString().substring(0, 10)
    };

    final Response response = await put(
     // '$apiUrl/$id' as Uri,
     Uri.parse('http://127.0.0.1:3004/cases/$id'),

      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      return Cases.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<void> deleteCase(String id) async {
    Response res = await delete(Uri.parse('http://127.0.0.1:3004/cases/$id'));

    if (res.statusCode == 200) {
      print("Case deleted");
    } else {
      throw "Failed to delete a case.";
    }
  }
}