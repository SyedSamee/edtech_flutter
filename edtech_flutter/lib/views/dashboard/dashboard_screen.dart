import 'package:edtech_flutter/config/utils.dart';
import 'package:edtech_flutter/views/dashboard/widget/dashboard_card.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * .1,
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Explore Courses",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * .36,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return DashboardCard(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          isEnroll: true,
                        );
                      }),
                ),
              ],
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Enrolled Courses",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: screenHeight * .35,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return DashboardCard(
                          screenHeight: screenHeight,
                          screenWidth: screenWidth,
                          isEnroll: false,
                        );
                      }),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
