// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medical_app/Screen/medicine_screen.dart';
import 'package:medical_app/components/app_Bar.dart';
import 'package:medical_app/components/bottom_container.dart';
import 'package:medical_app/components/drawer.dart';
import 'package:medical_app/constants/colors_const.dart';
import 'package:medical_app/constants/image_const.dart';
import 'package:medical_app/constants/string_const.dart';
import 'package:medical_app/models/userModel.dart';
import 'package:medical_app/utilities/database_provider.dart';

class LabUpload extends StatefulWidget {
  final selectedIndex;
  final controller;

  const LabUpload({
    super.key,
    this.selectedIndex,
    this.controller,
  });

  @override
  State<LabUpload> createState() =>
      _LabUploadState(selectedIndex: selectedIndex);
}

class _LabUploadState extends State<LabUpload> {
  int? selectedIndex;
  _LabUploadState({required this.selectedIndex});
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

  final List pages = [
    const Pages(),
    const Pages1(),
  ];

  List<Color> gradiantcontainerColor = [
    const Color(0xff55BE00),
    const Color(0xff3171DD)
  ];

  final PageController _pageController = PageController();
  final ScrollController _listController = ScrollController();

  final ScrollController controller = ScrollController();
  @override
  void dispose() {
    _pageController.dispose();
    _listController.dispose();
    super.dispose();
  }

  _updatePageIndex(int index) {
    setState(() {
      selectedIndex = index;
    });

    // // Move selected item to the first position in the lists
    // String selectedImage = gridImages[index];
    // String selectedText = gridImagesText[index];

    // // Remove the selected item from the original position
    // gridImages.removeAt(index);
    // gridImagesText.removeAt(index);

    // gridImages.insert(0, selectedImage);
    // gridImagesText.insert(0, selectedText);

    // controller.jumpTo(0);

    _pageController.jumpToPage(index);
  }

  UserModel user = UserModel();
  DatabaseProvider db = DatabaseProvider();

  getUser() async {
    await db.retrieveUserFromTabe().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 1,
        automaticallyImplyLeading: true,
        title: Text(
          gridImagesText[selectedIndex ?? 0],
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 12),
              child: InkWell(
                  onTap: () {},
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
            child: Stack(fit: StackFit.loose, children: [
              Positioned(
                bottom: 5,
                child: Image.asset(
                  bgImg,
                  color: bgImageColor,
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: pages.length,
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (ctx, index) {
                        return pages[index];
                      },
                      onPageChanged: (index) {
                        _updatePageIndex(index);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: SizedBox(
                      height: size.width / 3.6,
                      child: Row(
                        children: [
                          // ListView.builder(
                          //   itemCount: 1,
                          //   controller: controller,
                          //   scrollDirection: Axis.horizontal,
                          //   shrinkWrap: true,
                          //   padding: EdgeInsets.zero,
                          //   itemBuilder: (context, index) {
                          //     return Padding(
                          //       padding: const EdgeInsets.all(8.0),
                          //       child: Container(
                          //         width: size.width / 3,
                          //         decoration: BoxDecoration(
                          //           gradient: LinearGradient(
                          //             colors: selectedIndex == index
                          //                 ? gradiantcontainerColor
                          //                 : [
                          //                     Colors.transparent,
                          //                     Colors.transparent
                          //                   ],
                          //             end: Alignment.bottomRight,
                          //             begin: Alignment.topLeft,
                          //           ),
                          //           border: Border.all(color: gridTextColor),
                          //           borderRadius: BorderRadius.circular(8),
                          //         ),
                          //         child: Column(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           children: [
                          //             Image.asset(
                          //               gridImages[index],
                          //               scale: 3,
                          //               color: selectedIndex == index
                          //                   ? whiteColor
                          //                   : Colors.green,
                          //             ),
                          //             const SizedBox(
                          //               height: 7,
                          //             ),
                          //             Text(
                          //               gridImagesText[index],
                          //               style: TextStyle(
                          //                   color: selectedIndex == index
                          //                       ? whiteColor
                          //                       : Colors.green,
                          //                   fontWeight: FontWeight.w700),
                          //             )
                          //           ],
                          //         ),
                          //       ),
                          //     );
                          //   },
                          // ),

                          Flexible(
                            child: ListView.builder(
                              controller: controller,
                              itemCount: gridImages.length,
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: ((context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    _updatePageIndex(index);

                                    print('---------index---${index}');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: size.width / 3,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: selectedIndex == index
                                              ? [
                                                  Colors.transparent,
                                                  Colors.transparent
                                                ]
                                              : gradiantcontainerColor,
                                          end: Alignment.bottomRight,
                                          begin: Alignment.topLeft,
                                        ),
                                        border: Border.all(
                                            color: selectedIndex == index
                                                ? gridTextColor
                                                : Colors.transparent),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            gridImages[index],
                                            scale: 3,
                                            color: selectedIndex == index
                                                ? Colors.green
                                                : whiteColor,
                                          ),
                                          const SizedBox(
                                            height: 7,
                                          ),
                                          Text(
                                            gridImagesText[index],
                                            style: TextStyle(
                                                color: selectedIndex == index
                                                    ? Colors.green
                                                    : whiteColor,
                                                fontWeight: FontWeight.w700),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * .08,
                  )
                ],
              ),
            ]),
          ),
          const BottomContainer()
        ],
      ),
    );
  }
}

class Pages extends StatefulWidget {
  const Pages({super.key});

  @override
  State<Pages> createState() => _PagesState();
}

class _PagesState extends State<Pages> {
  File? _pickedImage;
  Future<void> _pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    } else {
      // User canceled the image picking
    }
  }

  Future<void> _captureImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    } else {
      // User canceled the image capturing
    }
  }

  Future<void> _showImageSourceDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              child: const Text("Gallery"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              child: const Text("Camera"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      // Do something with the selected/captured image
    } else {
      // User canceled the image picking/capturing
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    _showImageSourceDialog(context);
                  },
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                        color: const Color.fromARGB(255, 255, 247, 233),
                        borderRadius: BorderRadius.circular(8)),
                    child: _pickedImage != null
                        ? Image.file(_pickedImage!)
                        : const Column(children: [
                            SizedBox(
                              height: 20,
                            ),
                            Icon(
                              Icons.add,
                              color: Color(0xff439488),
                              size: 25,
                            ),
                            Text(
                              uploadText,
                              style: TextStyle(
                                  color: Color(0xff439488),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ]),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color(0xff55BC07),
                      borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      labAnalysisText,
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: blueColor, borderRadius: BorderRadius.circular(8)),
                  child: const Center(
                    child: Text(
                      labRecomedText,
                      style: TextStyle(
                          color: whiteColor,
                          fontSize: 18,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}

class Pages1 extends StatefulWidget {
  const Pages1({super.key});

  @override
  State<Pages1> createState() => _Pages1State();
}

class _Pages1State extends State<Pages1> {
  File? _pickedImage;
  Future<void> _pickImageFromGallery() async {
    final ImagePicker _picker = ImagePicker();

    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    } else {
      // User canceled the image picking
    }
  }

  Future<void> _captureImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        _pickedImage = File(image.path);
      });
    } else {
      // User canceled the image capturing
    }
  }

  Future<void> _showImageSourceDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Select Image Source"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.gallery);
              },
              child: const Text("Gallery"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _pickImage(ImageSource.camera);
              },
              child: const Text("Camera"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      // Do something with the selected/captured image
    } else {
      // User canceled the image picking/capturing
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 27),
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    _showImageSourceDialog(context);
                  },
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                        color: const Color.fromARGB(255, 255, 247, 233),
                        borderRadius: BorderRadius.circular(8)),
                    child: _pickedImage != null
                        ? Image.file(_pickedImage!)
                        : const Column(children: [
                            SizedBox(
                              height: 20,
                            ),
                            Icon(
                              Icons.add,
                              color: Color(0xff439488),
                              size: 25,
                            ),
                            Text(
                              'Medicine Name/Upload Prescription',
                              style: TextStyle(
                                  color: Color(0xff439488),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500),
                            ),
                          ]),
                  ),
                ),
                const Text(
                  'OR',
                  style: const TextStyle(
                      color: textColor,
                      fontSize: 32,
                      fontWeight: FontWeight.w500),
                ),
                Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38),
                        color: const Color.fromARGB(255, 255, 247, 233),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: TextField(
                        maxLines: 4,
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write your prescription here',
                            hintStyle:
                                TextStyle(fontSize: 14, color: Colors.grey)),
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
