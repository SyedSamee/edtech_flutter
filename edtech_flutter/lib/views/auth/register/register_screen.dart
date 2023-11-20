import 'package:edtech_flutter/config/utils.dart';
import 'package:edtech_flutter/views/auth/register/bloc/register_bloc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RegisterBloc registerBloc = RegisterBloc();
  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    registerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            "Wellcome To Register",
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: screenHeight * .1,
          ),
          Container(
            width: screenWidth * .8,
            height: screenHeight * .07,
            decoration: BoxDecoration(
                border: Border.all(color: Utils().primaryColor, width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: name,
              decoration: Utils().defualtInputDecoration("Name"),
            ),
          ),
          SizedBox(
            height: screenHeight * .03,
          ),
          Container(
            width: screenWidth * .8,
            height: screenHeight * .07,
            decoration: BoxDecoration(
                border: Border.all(color: Utils().primaryColor, width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: email,
              decoration: Utils().defualtInputDecoration("Email"),
            ),
          ),
          SizedBox(
            height: screenHeight * .03,
          ),
          Container(
            width: screenWidth * .8,
            height: screenHeight * .07,
            decoration: BoxDecoration(
                border: Border.all(color: Utils().primaryColor, width: 2),
                borderRadius: BorderRadius.circular(10)),
            child: TextField(
              controller: password,
              obscureText: true,
              decoration: Utils().defualtInputDecoration(
                "Password",
              ),
            ),
          ),
          SizedBox(
            height: screenHeight * .03,
          ),
          BlocConsumer<RegisterBloc, RegisterState>(
            bloc: registerBloc,
            buildWhen: (previous, current) =>
                current is RegisterLoadingState || current is RegisterInitial,
            listenWhen: (previous, current) => current is RegisterMsgState,
            listener: (context, state) {
              state as RegisterMsgState;

              Utils().defualtMessenger(context, state.msg, state.isError);
            },
            builder: (context, state) {
              switch (state.runtimeType) {
                case RegisterLoadingState:
                  {
                    return Utils().defualtLoadingIndicator();
                  }

                case RegisterInitial:
                  {
                    return GestureDetector(
                      onTap: () {
                        registerBloc.add(RegisterUserEvent(
                            context: context,
                            name: name.text,
                            email: email.text,
                            password: password.text));
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
                          "Register",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: Colors.white),
                        ),
                      ),
                    );
                  }
                default:
                  {
                    return SizedBox();
                  }
              }
            },
          ),
        ]),
      )),
    );
  }
}
