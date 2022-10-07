import 'dart:convert';

import 'package:amazone_clone/constants/error_handling.dart';
import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/constants/utils.dart';
import 'package:amazone_clone/features/auth/screens/auth_screen.dart';
import 'package:amazone_clone/models/order.dart';
import 'package:amazone_clone/models/user.dart';

import 'package:amazone_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountServices {
  Future<List<Order>> fetchMyOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    List<Order> orderList = [];

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/orders/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              orderList.add(
                Order.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }

    return orderList;
  }

  void logOut(BuildContext context) async {
    try {
      User uuser = User(
          id: '',
          name: '',
          email: '',
          password: '',
          address: '',
          type: '',
          token: '',
          cart: []);
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString('x-auth-token', '');
      Provider.of<UserProvider>(context, listen: false).setUserFromModel(uuser);

      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
