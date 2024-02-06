import 'package:flutter/material.dart';
import 'package:medical_app/Screen/lab_upload.dart';
import 'package:medical_app/components/app_Bar.dart';
import 'package:medical_app/components/bottom_container.dart';
import 'package:medical_app/constants/colors_const.dart';
import 'package:medical_app/constants/image_const.dart';
import 'package:medical_app/constants/string_const.dart';

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

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {
                    Navigator.of(context).pop(false); // User tapped "No"
                  },
                  child: const Text(
                    "No",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // User tapped "Yes"
                  },
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
                ),
              ],
            );
          },
        );

        return shouldPop ??
            false; // Return true if null or false, otherwise return the value from the dialog
      },
      child: Scaffold(
        body: Column(
          children: [
            const CustomeAppBar(),
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
      ),
    );
  }
}
