// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:medical_app/authantication/loginScreen.dart';
import 'package:medical_app/constants/colors_const.dart';
import 'package:medical_app/constants/string_const.dart';
import 'package:medical_app/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BottomContainer extends StatefulWidget {
  const BottomContainer({super.key});

  @override
  State<BottomContainer> createState() => _BottomContainerState();
}

class _BottomContainerState extends State<BottomContainer> {
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
              _logout();
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

  Future<void> _logout() async {
    try {
      print('-----1');
      await showLogoutDialog(context);
    } catch (e) {
      print("----error from login---$e");
    }
  }

  Future<void> showLogoutDialog(BuildContext context) async {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text(
        "Cancel",
        style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop('dialog');
      },
    );

    Widget continueButton = TextButton(
      child: const Text(
        "Continue",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      onPressed: () async {
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
        " Are you sure to logout from this device.",
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

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }
}
