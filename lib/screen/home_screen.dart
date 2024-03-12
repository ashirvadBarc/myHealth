import 'package:flutter/material.dart';
import 'package:medical_app/Screen/lab_upload.dart';
import 'package:medical_app/authantication/loginScreen.dart';
import 'package:medical_app/components/drawer.dart';
import 'package:medical_app/constants/colors_const.dart';
import 'package:medical_app/constants/image_const.dart';
import 'package:medical_app/constants/string_const.dart';
import 'package:medical_app/models/userModel.dart';
import 'package:medical_app/routes.dart';

import 'package:http/http.dart' as http;
import 'package:medical_app/utilities/database_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  final selectedindex;
  HomeScreen({super.key, this.selectedindex});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState(selectedindex: selectedindex);
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedindex = -1;
  _HomeScreenState({required this.selectedindex});
  final List gridImages = [
    labImg,
    medicineImg,
    serviceImg,
    doctorImg,
    optionalImg,
    optionalImg
  ];

  final List gridImagesText = [
    labText,
    medicineText,
    serviceText,
    doctorText,
    optionText,
    option2Text
  ];

  final ScrollController controller = ScrollController();

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
    return WillPopScope(
      onWillPop: () async {
        bool shouldPop = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                  "${user.userName}, Are you sure you want to close the App?"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // User tapped "No"
                  },
                  child: Container(
                    width: 70,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xff55BE00), Color(0xff3171DD)],
                          end: Alignment.bottomRight,
                          begin: Alignment.topLeft),
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: Center(
                      child: const Text(
                        "No",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // User tapped "Yes"
                  },
                  child: Text(
                    "Yes",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            );
          },
        );

        return shouldPop; // Return true if null or false, otherwise return the value from the dialog
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 1,
          automaticallyImplyLeading: true,
          title: Image.asset(
            'assets/logo.png',
            scale: 5,
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.only(right: 12),
                child: InkWell(
                    onTap: () {
                      print("--username--------${user.userName}");
                    },
                    child: Image.asset('assets/notification-icon.png')))
          ],
          backgroundColor: whiteColor,
          leading: Builder(builder: (context) {
            return InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    user.userName.toString().substring(0, 2).toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                      color: Colors.black, // Adjust the text color as needed
                    ),
                  ),
                ),
              ),
            );
          }),
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(100), // Adjust the radius as needed
            ),
          ),
        ),
        drawer: const MyDrawer(),
        body: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Stack(children: [
                  // Image.asset(
                  //   bgImg,
                  //   color: const Color(0xff91C9C4),
                  // ),
                  Stack(children: [
                    Positioned(
                      bottom: -60,
                      child: Image.asset(
                        bgImg,
                        color: bgImageColor,
                      ),
                    ),
                    SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 27),
                        child: Column(
                          children: [
                            Image.asset(bannerImg),
                            const SizedBox(
                              height: 25,
                            ),
                            GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: gridImages.length,
                                shrinkWrap: true,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        childAspectRatio: 14 / 8,
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 15,
                                        crossAxisSpacing: 15),
                                itemBuilder: ((context, index) {
                                  return InkWell(
                                    onTap: () {
                                      setState(() {
                                        selectedindex = index;
                                      });
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LabUpload(
                                                    selectedIndex:
                                                        selectedindex,
                                                  )));
                                    },
                                    child: Container(
                                      height: 45,
                                      width: 45,
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              colors: [
                                                Color(0xff55BE00),
                                                Color(0xff3171DD)
                                              ],
                                              end: Alignment.bottomRight,
                                              begin: Alignment.topLeft),
                                          borderRadius:
                                              BorderRadius.circular(8)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            gridImages[index],
                                            scale: 2,
                                            color: whiteColor,
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            gridImagesText[index],
                                            style: const TextStyle(
                                                color: whiteColor,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                })),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
                ]),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () {
                    logOutUser(user.userName.toString());
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
                ))
          ],
        ),
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

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', isLoggedIn);
    } catch (e) {
      print("Error saving login status: $e");
    }
  }

  Future<void> showLogoutDialog(BuildContext context) async {
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
        await showLogoutDialog(context);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
    }
  }
}
