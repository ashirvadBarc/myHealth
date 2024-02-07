// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:medical_app/authantication/loginScreen.dart';
import 'package:medical_app/constants/colors_const.dart';
import 'package:medical_app/constants/string_const.dart';
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
    // Set the login status to false

    print('-----1');
    await saveLoginStatus(false);

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              child: const Text("No"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        );
      },
    );

    // Navigate to the login screen
  }

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }
}
