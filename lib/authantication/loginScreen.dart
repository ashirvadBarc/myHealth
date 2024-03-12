// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medical_app/Screen/home_screen.dart';
import 'package:medical_app/authantication/OtpScreen.dart';
import 'package:medical_app/authantication/RegisterationScreen.dart';
import 'package:medical_app/constants/ApiConst.dart';
import 'package:medical_app/constants/colors_const.dart';
import 'package:medical_app/constants/image_const.dart';
import 'package:http/http.dart' as http;
import 'package:medical_app/models/userModel.dart';
import 'package:medical_app/provider/homeProvider.dart';
import 'package:medical_app/routes.dart';
import 'package:medical_app/utilities/apiClients.dart';
import 'package:medical_app/utilities/database_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();
  UserModel user = UserModel();

  bool _isGmail(String email) {
    return email.endsWith('@gmail.com') ||
        email.endsWith('.com') ||
        email.endsWith('.co') ||
        email.endsWith('.in');
  }

  bool _obsecureText = true;
  void passVisibility() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  Future<void> updateUser(BuildContext context) async {
    try {
      final url = Uri.parse(
        'http://ec2-54-159-209-201.compute-1.amazonaws.com:8080/user-api/validate',
      );

      final response = await http.post(
        url,
        headers: {
          'accept': '*/*',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'userName': emailController.text,
          'password': passController.text,
        }),
      );

      final bool success = json.decode(response.body);

      print('Response Status Code: ${response.statusCode}');
      print('Response Body: $success');

      if (success == true) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              content: Row(
                children: [
                  CircularProgressIndicator(),
                  SizedBox(width: 20),
                  Text("Updating user..."),
                ],
              ),
            );
          },
          barrierDismissible: false,
        );
        await saveLoginStatus(true);

        Navigator.pushNamedAndRemoveUntil(
          context,
          homeScreen,
          (route) => false,
        );
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              Widget continueButton = TextButton(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xff55BE00), Color(0xff3171DD)],
                          end: Alignment.bottomRight,
                          begin: Alignment.topLeft),
                      borderRadius: BorderRadius.circular(7)),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "OK",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );

              return AlertDialog(
                title: const Text("User logged in successfully"),
                actions: [continueButton],
                actionsAlignment: MainAxisAlignment.center,
              );
            });
      } else {
        showDialog(
            barrierDismissible: true,
            context: context,
            builder: (BuildContext context) {
              Widget continueButton = TextButton(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Color(0xff55BE00), Color(0xff3171DD)],
                          end: Alignment.bottomRight,
                          begin: Alignment.topLeft),
                      borderRadius: BorderRadius.circular(7)),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "OK",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              );

              return AlertDialog(
                title: const Text("Invalide Credentials"),
                actions: [continueButton],
                actionsAlignment: MainAxisAlignment.center,
              );
            });

        if (success == false) {
          showDialog(
              barrierDismissible: true,
              context: context,
              builder: (BuildContext context) {
                Widget continueButton = TextButton(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                            colors: [Color(0xff55BE00), Color(0xff3171DD)],
                            end: Alignment.bottomRight,
                            begin: Alignment.topLeft),
                        borderRadius: BorderRadius.circular(7)),
                    child: const Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "OK",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );

                return AlertDialog(
                  title: const Text("Login status is false"),
                  actions: [continueButton],
                  actionsAlignment: MainAxisAlignment.center,
                );
              });
        }
      }
    } catch (e) {
      showDialog(
          barrierDismissible: true,
          context: context,
          builder: (BuildContext context) {
            Widget continueButton = TextButton(
              child: Container(
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Color(0xff55BE00), Color(0xff3171DD)],
                        end: Alignment.bottomRight,
                        begin: Alignment.topLeft),
                    borderRadius: BorderRadius.circular(7)),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "OK",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );

            return AlertDialog(
              title: const Text("Error while updating user"),
              content: Text('$e}'),
              actions: [continueButton],
              actionsAlignment: MainAxisAlignment.center,
            );
          });
    } finally {
      Navigator.pop(context); // Dismiss the updating user pop-up
    }
  }

  // Future<void> fetchData(BuildContext context, String username) async {
  //   try {
  //     final response =
  //         await ApiClient().callGetAPI("$getUserDataEndpoint$username");

  //     // Log the URL for debugging
  //     print('URL  from ftech user: $response');

  //     if (response.statusCode == 200) {
  //       // Parse the response JSON
  //       final Map<String, dynamic> data = jsonDecode(response.body);

  //       // Do something with the data
  //       print('Title: ${data['title']}');
  //     } else {
  //       // Handle error response
  //       print(
  //           'Error  while fetch user - Status Code: ${response.statusCode}, Body: ${response.body}');

  //       // Display a user-friendly message
  //     }
  //   } catch (e) {
  //     // Handle exceptions during HTTP request or JSON decoding
  //     print('Error:  --------while fetch user-------------$e');

  //     // Display a user-friendly message
  //   }
  // }

  // Future<void> updateUser() async {
  //   try {
  //     final response = await http.post(
  //       Uri.parse(
  //           'http://ec2-54-159-209-201.compute-1.amazonaws.com:8080/user-api/validate'),
  //       headers: <String, String>{
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: {
  //         "userName": emailController.text,
  //         "password": passController.text,
  //       },
  //     );

  //     emailController.clear();
  //     passController.clear();
  //     if (response.statusCode == 200) {
  //       // Request successful, handle the response as needed
  //       print('Response: ${response.body}');
  //       // Save user login status
  // await saveLoginStatus(true);
  // // Navigate to the home screen
  // await Navigator.pushReplacement(
  //     context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //     } else {
  //       // Request failed, handle the error
  //       print(
  //           'Error - Status Code: ${response.statusCode}, Body: ${response.body}');
  //       // You might want to show an error message to the user here
  //     }
  //   } catch (e) {
  //     // Handle exceptions
  //     print('Error: $e');
  //     // You might want to show an error message to the user here
  //   }
  // }

  Future<void> saveLoginStatus(bool isLoggedIn) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', isLoggedIn);
  }

  Future<bool> getLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  validateAndSave() async {
    final FormState form = _formKey.currentState!;

    if (form.validate()) {
      try {
        await updateUser(context);

        return true;
      } catch (e) {
        // Handle exceptions
        print('Error:  ------in--validateAndSave  $e');

        Navigator.pop(context);

        return false;
      }
    } else {
      return false;
    }
  }

  void checkLoginStatus() async {
    bool isLoggedIn = await getLoginStatus();
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
    } else {
      // User is not logged in, show login screen
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      checkLoginStatus();
    });
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        bool shouldPop = await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Are you sure you want to close the App?"),
              actions: [
                TextButton(
                  child: const Text(
                    "No",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(false); // User tapped "No"
                  },
                ),
                TextButton(
                  child: Container(
                    width: 70,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(7),
                    ),
                    child: const Center(
                      child: Text(
                        "Yes",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(true); // User tapped "Yes"
                  },
                ),
              ],
            );
          },
        );

        // Return true if the user tapped "Yes" and false otherwise
        return shouldPop;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: false,
          body: SingleChildScrollView(
            child: Stack(children: [
              Positioned(
                bottom: 15,
                child: Image.asset(
                  bgImg,
                  fit: BoxFit.fitWidth,
                ),
              ),
              Column(
                children: [
                  Container(
                    height: 110,
                    width: size.width * .28,
                    decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(color: Colors.black38, blurRadius: 2)
                        ],
                        color: whiteColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(53),
                            bottomRight: Radius.circular(53))),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 3),
                      child: SizedBox(
                        child: Image.asset(
                          logoImg,
                          // scale: 1.75,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: size.height * .66,
                      width: size.width,
                      decoration: BoxDecoration(
                        border: Border.all(color: blueColor, width: 2),
                        color: Colors.transparent,
                        borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(35),
                          topLeft: Radius.circular(35),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 16.0),
                              child: Text(
                                "Welcome!",
                                style: TextStyle(
                                  color: blueColor,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            const Divider(
                              color: blueColor,
                              thickness: 4,
                              endIndent: 170,
                              indent: 170,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 30.0,
                              ),
                              child: Column(
                                children: [
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Email ID/Username",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: authscreenTextcolor),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: TextFormField(
                                              controller: emailController,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: 'your email id...',
                                                hintStyle: TextStyle(
                                                    color: Color(0xff747474),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                suffixIcon: Icon(
                                                  Icons.email_outlined,
                                                  color: Color(0xff747474),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                        vertical: 12.0,
                                                        horizontal: 16.0),
                                              ),
                                              validator: (authResult) {
                                                if (authResult!.isEmpty ||
                                                    !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                                        .hasMatch(authResult)) {
                                                  return 'Please enter a valid email/username';
                                                }

                                                if (!_isGmail(authResult)) {
                                                  return 'Please enter a valid email address';
                                                }

                                                return null;
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                            ),
                                          ),
                                        ),
                                        const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Password",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: authscreenTextcolor),
                                            )),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10.0),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            child: TextFormField(
                                              controller: passController,
                                              obscureText: _obsecureText,
                                              decoration: InputDecoration(
                                                border:
                                                    const OutlineInputBorder(),
                                                hintText: 'password',
                                                hintStyle: const TextStyle(
                                                    color: Color(0xff747474),
                                                    fontSize: 13,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                suffixIcon: IconButton(
                                                    onPressed: () {
                                                      passVisibility();
                                                    },
                                                    icon: Icon(_obsecureText
                                                        ? Icons.lock_outline
                                                        : Icons.lock_open)),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12.0,
                                                        horizontal: 16.0),
                                              ),
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Please enter your password';
                                                } else if (value.length < 8 ||
                                                    value.length > 16) {
                                                  return 'Password should be 8-16 characters.';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                    onTap: validateAndSave,
                                    child: Container(
                                      height: 50,
                                      decoration: BoxDecoration(
                                          gradient: const LinearGradient(
                                              colors: [
                                                Color(0xff55BE00),
                                                Color(0xff3171DD)
                                              ],
                                              end: Alignment.bottomRight,
                                              begin: Alignment.topLeft),
                                          color: authButtoncolor,
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: const Center(
                                        child: Text(
                                          "LOGIN",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 13),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const OtpScreen()));
                                },
                                child: const Text(
                                  "Forgot Password?",
                                  style: TextStyle(
                                      color: authscreenTextcolor,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 25),
                              child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisterScreen()));
                                  },
                                  child: RichText(
                                      text: const TextSpan(children: [
                                    TextSpan(
                                      text: 'Don’t have account? ',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: authscreenTextcolor),
                                    ),
                                    TextSpan(
                                      text: ' Sign up',
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: authscreenTextcolor),
                                    )
                                  ]))),
                            ),
                            SizedBox(
                              height: size.height / 2.5,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
