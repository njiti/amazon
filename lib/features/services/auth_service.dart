import 'package:amazon/constants/utils.dart';
import 'package:flutter/cupertino.dart';

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
}