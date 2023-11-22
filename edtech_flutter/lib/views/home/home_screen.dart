import 'package:edtech_flutter/config/global.dart';
import 'package:edtech_flutter/config/utils.dart';
import 'package:edtech_flutter/views/home/bloc/home_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeBloc homeBloc = HomeBloc();
  @override
  void initState() {
    // homeBloc.add(HomeLoginChecker(context: context));
    listenFirebaseUser(context);
    super.initState();
  }

  @override
  void dispose() {
    homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: screenHeight * .1,
              ),
              Text(
                "Wellcome To Edtech Flutter",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: screenHeight * .25,
              ),
              GestureDetector(
                onTap: () {
                  homeBloc.add(HomeAuthNavigation(
                    routeName: "login",
                  ));
                },
                child: Container(
                  width: screenWidth * .4,
                  height: screenHeight * .07,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Utils().primaryColor,
                  ),
                  child: Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * .04,
              ),
              GestureDetector(
                onTap: () {
                  homeBloc.add(HomeAuthNavigation(
                    routeName: "register",
                  ));
                },
                child: Container(
                  width: screenWidth * .4,
                  height: screenHeight * .07,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xff77DEFF),
                  ),
                  child: Text(
                    "Register",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
