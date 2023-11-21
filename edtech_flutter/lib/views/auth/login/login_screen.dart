import 'package:edtech_flutter/config/utils.dart';
import 'package:edtech_flutter/views/auth/login/bloc/login_bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  LoginBloc loginBloc = LoginBloc();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    loginBloc.close();
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
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Wellcome To Login",
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
            BlocConsumer<LoginBloc, LoginState>(
              bloc: loginBloc,
              listenWhen: (previous, current) => current is LoginMsgState,
              listener: (context, state) => {
                state as LoginMsgState,
                Utils().defualtMessenger(context, state.msg, state.isError)
              },
              buildWhen: (previous, current) =>
                  current is LoginLoadingState || current is LoginInitial,
              builder: (context, state) {
                switch (state.runtimeType) {
                  case LoginLoadingState:
                    {
                      return Utils().defualtLoadingIndicator();
                    }

                  case LoginInitial:
                    {
                      return GestureDetector(
                        onTap: () {
                          loginBloc.add(LoginUser(
                              email: email.text,
                              password: password.text,
                              context: context));
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
        ),
      )),
    );
  }
}
