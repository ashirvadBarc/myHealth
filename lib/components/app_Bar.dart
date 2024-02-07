import 'package:flutter/material.dart';

class CustomeAppBar extends StatelessWidget {
  const CustomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        'assets/user.png',
        scale: 12,
      ),
    );
    // return SafeArea(

    //     child: Container(
    //   height: 70,
    //   decoration: const BoxDecoration(
    //       color: whiteColor,
    //       boxShadow: <BoxShadow>[BoxShadow(blurRadius: 2, color: Colors.grey)]),
    //   width: double.infinity,
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 10),
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         InkWell(
    //           onTap: () {

    //           },
    //           child: const CircleAvatar(
    //             backgroundImage: AssetImage('assets/user.png'),
    //           ),
    //         ),
    //         Image.asset(
    //           'assets/logo.png',
    //           scale: 2,
    //         ),

    //       ],
    //     ),
    //   ),
    // ));
  }
}
