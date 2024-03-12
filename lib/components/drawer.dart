// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:medical_app/constants/colors_const.dart';
import 'package:medical_app/models/userModel.dart';
import 'package:medical_app/utilities/database_provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
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
    return SafeArea(
      child: Drawer(
        backgroundColor: whiteColor,
        child: ListView(
          padding: const EdgeInsets.only(left: 10),
          children: [
            SizedBox(
              height: 80,
              child: DrawerHeader(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Text(
                          user.userName
                              .toString()
                              .substring(0, 2)
                              .toUpperCase(),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color:
                                Colors.black, // Adjust the text color as needed
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "${user.userName}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.close))
                ],
              )),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text(
                  'Use Activity Report',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text(
                  'Analysis Report',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {},
              child: const ListTile(
                title: Text(
                  'Lab Report',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
