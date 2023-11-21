import 'package:edtech_flutter/config/utils.dart';
import 'package:flutter/material.dart';

class DashboardCard extends StatelessWidget {
  const DashboardCard(
      {super.key,
      required this.screenHeight,
      required this.screenWidth,
      required this.isEnroll});

  final double screenHeight;
  final double screenWidth;
  final bool isEnroll;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * .02,
              ),
              Container(
                width: screenWidth * .48,
                height: screenHeight * .3,
                decoration: BoxDecoration(
                    color: Utils().secColor,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(children: [
                  SizedBox(
                    height: screenHeight * .02,
                  ),
                  Container(
                    width: screenWidth * .43,
                    height: screenHeight * .15,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://img.freepik.com/premium-psd/youtube-video-thumbnail-start-trading-today_475351-168.jpg?w=2000"),
                            fit: BoxFit.fill),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  SizedBox(
                    height: screenHeight * .01,
                  ),
                  Container(
                      width: screenWidth * .43,
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Course 101",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )),
                  Spacer(),
                  Container(
                      height: screenHeight * .044,
                      color: Utils().primaryColor,
                      alignment: Alignment.center,
                      child: Text(
                        isEnroll ? "Enroll" : "Continue Course",
                        style: TextStyle(
                            color: Colors.white,
                            // decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w500),
                      ))
                ]),
              )
            ],
          ),
        ),
      ],
    );
  }
}
