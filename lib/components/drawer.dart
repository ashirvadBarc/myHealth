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

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: whiteColor,
      child: ListView(
        padding: const EdgeInsets.only(top: 50, left: 10),
        children: [
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
    );
  }
}
