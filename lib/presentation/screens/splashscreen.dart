import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/presentation/screens/homepage.dart';
import 'package:news_app/presentation/widgets/custom_loading.dart';
import 'package:news_app/utils/utility.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    startTimer();
    super.initState();
  }

  startTimer() {
    Timer(const Duration(seconds: 3), changeScreen);
  }

  changeScreen() async {
    await Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) => HomePage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Hero(
                      tag: "logo",
                      child: Image.asset(
                        "images/logo.png",
                        width: screenWidth(context) / 1.6,
                        //height: 600.h,
                      ),
                    ),
                  ),
                ),
                verticalSpaceLarge,
                Center(
                  child: Text(
                    "News App",
                    style: text45.copyWith(
                      color: AppColors.secondaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                verticalSpaceMedium20,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Center(
                    child: Text(
                      "Instant news in your hands",
                      textAlign: TextAlign.center,
                      style: text30.copyWith(fontSize: 25.sp
                          //color: AppColors.getPrimaryColor(),
                          ),
                    ),
                  ),
                ),
              ],
            ),
            const Loading(
              size: 70,
            ),
          ],
        ),
      ),
    );
  }
}
