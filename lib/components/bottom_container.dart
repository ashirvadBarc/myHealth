// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:medical_app/authantication/loginScreen.dart';
import 'package:medical_app/constants/colors_const.dart';
import 'package:medical_app/constants/string_const.dart';
import 'package:medical_app/models/userModel.dart';
import 'package:medical_app/routes.dart';

import 'package:http/http.dart' as http;
import 'package:medical_app/utilities/database_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomContainer extends StatefulWidget {
  const BottomContainer({super.key});

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
  UserModel user = UserModel();
  DatabaseProvider db = DatabaseProvider();

  getUser() async {
    await db.retrieveUserFromTabe().then((value) {
      setState(() {
        user = value;
      });

      print(user.userName);
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color(0xff55BE00), Color(0xff3171DD)],
                      end: Alignment.bottomRight,
                      begin: Alignment.topLeft),
                  borderRadius: BorderRadius.circular(6)),
              child: const Center(
                child: Text(
                  backText,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              showLogoutDialog(context, user.userName);
            },
            child: Container(
              height: 50,
              width: 150,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: darkGreenColor,
                  ),
                  borderRadius: BorderRadius.circular(6)),
              child: const Center(
                child: Text(
                  logOutText,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: darkGreenColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future showLogoutDialog(BuildContext context, userName) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Container(
        // width: 70,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
              colors: [Color(0xff55BE00), Color(0xff3171DD)],
              end: Alignment.bottomRight,
              begin: Alignment.topLeft),
          borderRadius: BorderRadius.circular(7),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Text(
            "Cancel",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    Widget continueButton = TextButton(
      child: const Text(
        "Continue",
        style: TextStyle(
          // fontWeight: FontWeight.bold,
          color: Colors.black,
          fontSize: 20,
        ),
      ),
      onPressed: () async {
        logOutUser(userName);
        print('----continue button tapped');
        await saveLoginStatus(false);
        Navigator.pushReplacementNamed(context, loginScreen);

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('User LogOut Successfully')));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Confirm Logout"),
      content: Text(
        "${user.userName}, Are you sure to logout from this device.",
      ),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  logOutUser(String userName) async {
    try {
      // final username = user.userName;
      // await DatabaseProvider().clearUserTable();
      // setState(() {
      //   user = UserModel();
      // });
      final url = Uri.parse(
          'http://ec2-54-159-209-201.compute-1.amazonaws.com:8080/user-api/unsubscribe/${userName}');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // await showLogoutDialog(context);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }
}
