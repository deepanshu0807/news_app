import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:news_app/presentation/screens/categoryscreen.dart';
import 'package:news_app/presentation/screens/mainscreen.dart';
import 'package:news_app/utils/utility.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller = PageController(initialPage: 0);
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: screenHeight(context),
        width: screenWidth(context),
        child: Stack(
          children: [
            PageView(
              controller: _controller,
              physics: NeverScrollableScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [MainScreen(), CategoriesScreen()],
            ),

            //Arrows to control pageview
            if (currentPage == 0)
              Positioned(
                bottom: 0,
                right: 0,
                top: 0,
                child: Center(
                  child: Container(
                    color: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        topLeft: Radius.circular(50),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50),
                              topLeft: Radius.circular(50),
                            ),
                            color: Colors.white54,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      currentPage = 1;
                                    });
                                    _controller.animateToPage(1,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeIn);
                                  },
                                  icon: Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                    size: 30,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            if (currentPage == 1)
              Positioned(
                bottom: 0,
                left: 0,
                top: 0,
                child: Center(
                  child: Container(
                    color: Colors.transparent,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(50),
                        topRight: Radius.circular(50),
                      ),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                            color: Colors.white54,
                          ),
                          child: Row(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    setState(() {
                                      currentPage = 0;
                                    });
                                    _controller.animateToPage(0,
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.easeIn);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                    size: 30,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
