import 'dart:convert';

import 'package:amazon/constants/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/error_handling.dart';
import '../../constants/global_variables.dart';
import '../../models/user.dart';
import 'package:http/http.dart' as http;

class AuthService {
  // sign up user
  void signUpUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try{
      User user = User(
          id: '',
          name: '',
          email: '',
          password: '',
          address: '',
          type: '',
          token: '',
      );
      
      http.Response res = await http.post(
        Uri.parse('$uri/api/accounts/'),
           body: user.toJson(),
           headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
           },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Account created!');
          },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try{
      http.Response res = await http.post(
        Uri.parse('$uri/api/token/'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}