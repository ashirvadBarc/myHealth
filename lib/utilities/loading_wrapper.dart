import 'package:flutter/material.dart';
import 'package:medical_app/provider/homeProvider.dart';
import 'package:provider/provider.dart';

class LoadingWrapper extends StatelessWidget {
  final Widget child;
  const LoadingWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        child,
        Consumer<HomeProvider>(builder: (_, homeProvider, __) {
          if (!homeProvider.loading) {
            return const SizedBox.shrink();
          } else {
            return Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: width * 0.25,
                height: width * 0.25,
                decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.circular(5)),
                padding: EdgeInsets.all(32),
                child: const CircularProgressIndicator(
                  color: Colors.green,
                ),
              ),
            );
          }
        })
      ],
    );
  }
}
