import 'package:flutter/material.dart';
import 'package:medical_app/constants/ApiConst.dart';
import 'package:medical_app/models/userModel.dart';
import 'package:medical_app/routes.dart';
import 'package:medical_app/utilities/apiClients.dart';
import 'package:medical_app/utilities/database_provider.dart';

import 'package:sqflite/sqflite.dart';
// Import your UserModel class

class HomeProvider extends ChangeNotifier {
  bool loading = false;
  setLoader() {
    loading = true;
    notifyListeners();
  }

  hideLoader() {
    loading = false;
    notifyListeners();
  }

  Future<void> getUserData(String userName, context) async {
    try {
      if (userName != null) {
        final response =
            await ApiClient().callGetAPI('$getUserDataEndpoint$userName');

        print('-------------getuser------response------------${response}');

        if (response != null) {
          await DatabaseProvider().clearUserTable();

          UserModel user = UserModel.fromJson(response);
          await DatabaseProvider().insertUser(user);

          print('----------user----------${user}');

          Navigator.pushNamedAndRemoveUntil(
              context, homeScreen, (route) => false);

          notifyListeners(); // Notify listeners if needed
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }
}
