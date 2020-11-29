import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth {
  String _token;
  String _email;
  String _userId;



  Future<void> signUp(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCyvygD9iTay_4iOXkBj5GfM0Wg8DDFwOs";
    final response = await http.post(
      url,
      body: jsonEncode(
        {
          'email': email,
          'password': password,
          'returnSecureToken': true,
        },
      ),
    );
    if(response.statusCode == 200) {
      final responseData = await jsonDecode(response.body);
      // print(responseData);
      _token = responseData['idToken'];
      _email = responseData['email'];
      prefs.setString('token', responseData['idToken']);
    }

  }

  Future<void> signIn(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCyvygD9iTay_4iOXkBj5GfM0Wg8DDFwOs";
    final response = await http.post(
      url,
      body: jsonEncode({
        'email': email,
        'password': password,
        'returnSecureToken': true,
      }),
    );
    if(response.statusCode == 200) {
      final responseData = await jsonDecode(response.body);
      _token = responseData['idToken'];
      _email = responseData['email'];
      _userId = responseData['localId'];
      prefs.setString('token', responseData['idToken']);
    }

  }

  String get token {
    return _token;
  }

  String get email {
    return _email;
  }

  String get userId {
    return _userId;
  }

  bool get isAuth{
    return token != null;
  }

  
}
