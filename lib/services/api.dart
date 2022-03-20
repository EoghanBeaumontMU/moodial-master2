import 'dart:convert';
import 'package:Moodial/models/entry.dart';

import '../models/user.dart';
import 'package:http/http.dart' as http;

class URLS {
  static const String BASE_URL = 'https://infinite-river-03426.herokuapp.com';
}

class ApiService {
  static Future<User> login(username, password) async {
    final response = await http.post(
      Uri.parse('${URLS.BASE_URL}/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      //Successful log in
      return User.fromJSON(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      //Invalid username/password
      return User.fromJSON(jsonDecode(response.body));
    } else {
      throw Exception('Failed to log in due to server error.');
    }
  }

  static Future<int> register(username, email, password) async {
    final response = await http.post(
      Uri.parse('${URLS.BASE_URL}/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode == 201) {
      //Successful registration
      return 201;
    } else if (response.statusCode == 400) {
      // Error message
      return 400;
    } else {
      return 404;
    }
  }

  static Future<Entry> getEntry(userToken) async {
    final response = await http.get(
      Uri.parse('${URLS.BASE_URL}/entry'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + userToken,
      },
    );
    if (response.statusCode == 200) {
      //Successful
      Iterable body = jsonDecode(response.body);
      return Entry.fromJSON(body.first);
    } else {
      // Error message
      throw Exception('Failed to get entry due to server error.');
    }
  }

  static Future<List<Entry>> getEntryList(userToken) async {
    final response = await http.get(
      Uri.parse('${URLS.BASE_URL}/entrylist'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + userToken,
      },
    );
    if (response.statusCode == 200) {
      //Successful
      Iterable body = jsonDecode(response.body);
      List<Entry> responseList = [];
      body.forEach((entry) => responseList.add(Entry.fromJSON(entry)));
      return responseList;
    } else {
      // Error message
      throw Exception('Failed to get entry list due to server error.');
    }
  }

  static Future<int> postEntry(userToken, formData) async {
    final response = await http.post(
      Uri.parse('${URLS.BASE_URL}/entry'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + userToken,
      },
      body: jsonEncode(<String, Object>{
        'mood': formData['mood'],
        'sleep': int.parse(formData['sleep']),
        'iritability': formData['iritability'],
        'medication': [
          {
            'name': formData['medName'].toString(),
            'dose': formData['medDose'].toString(),
          }
        ],
        'diet': [
          {
            'food': formData['dietFood'].toString(),
            'amount': formData['dietAmount'].toString(),
          }
        ],
        'exercise': formData['exercise'].toString(),
        'notes': formData['notes'].toString(),
      }),
    );
    if (response.statusCode == 201) {
      //Successful
      return response.statusCode;
    } else {
      // Error message
      print(userToken);
      throw Exception('Failed to get entry due to server error.');
    }
  }

  static Future<int> updateEntry(userToken, formData, id) async {
    final response = await http.put(
      Uri.parse('${URLS.BASE_URL}/entry/' + id.toString()),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + userToken,
      },
      body: jsonEncode(<String, Object>{
        'mood': formData['mood'],
        'sleep': int.parse(formData['sleep']),
        'iritability': formData['iritability'],
        'medication': [
          {
            'name': formData['medName'].toString(),
            'dose': formData['medDose'].toString(),
          }
        ],
        'diet': [
          {
            'food': formData['dietFood'].toString(),
            'amount': formData['dietAmount'].toString(),
          }
        ],
        'exercise': formData['exercise'].toString(),
        'notes': formData['notes'].toString(),
      }),
    );
    if (response.statusCode == 204) {
      //Successful
      return response.statusCode;
    } else {
      // Error message
      throw Exception('Failed to get entry due to server error.');
    }
  }

  static Future<String> deleteUser(userToken, username) async {
    final response = await http.delete(
      Uri.parse('${URLS.BASE_URL}/deleteuser/' + username),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ' + userToken,
      },
    );
    if (response.statusCode == 204) {
      //Successful delete
      return 'User and entries deleted';
    } else if (response.statusCode == 401) {
      //auth error
      return 'You do not have the authorization for this';
    } else if (response.statusCode == 404) {
      //user not found
      return 'User does not exist';
    } else {
      throw Exception('Failed to log in due to server error.');
    }
  }
}
