import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:news_app/api/categorydata.dart';
import 'package:news_app/api/news.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/presentation/widgets/cached_network_widget.dart';
import 'package:news_app/presentation/widgets/custom_loading.dart';
import 'package:news_app/presentation/widgets/menubutton.dart';
import 'package:news_app/presentation/widgets/newsCard.dart';
import 'package:news_app/utils/utility.dart';

import 'newsDetail.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool _loading = true;
  double menuH = 60;
  double menuW = 70.h;
  bool isPlaying = false;

  List<Article> newslist = [];
  List<CategoryModel> categories = <CategoryModel>[];

  AnimationController _animationController;

  void getAllNews() async {
    News news = News();
    try {
      await news.getNews();
      newslist = news.news;
      setState(() {
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      throw Exception(e.toString());
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    categories = getCategories();
    getAllNews();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  menuOntap() {
    setState(() {
      isPlaying = !isPlaying;
      isPlaying
          ? _animationController.forward()
          : _animationController.reverse();

      menuH = isPlaying ? screenHeight(context) / 2.2 : 60;
      menuW = isPlaying ? screenWidth(context) / 1.5 : 70.h;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Container(
          height: screenHeight(context),
          width: screenWidth(context),
          child: Stack(
            alignment: Alignment.center,
            children: [
              //Headlines list widget
              Positioned(
                top: 100.h,
                child: Container(
                  height: screenHeight(context) / 1.20,
                  width: screenWidth(context),
                  color: AppColors.backgroundColor,
                  child: _loading
                      ? Center(
                          child: Loading(
                            size: 100,
                          ),
                        )
                      : Stack(
                          children: [
                            if (newslist.length == 0)
                              Opacity(
                                opacity: 0.6,
                                child: Center(
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.asset(
                                        "images/empty.png",
                                        height: screenHeight(context) / 2.6,
                                      )),
                                ),
                              ),
                            if (newslist.length != 0)
                              ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: newslist.length,
                                itemBuilder: (context, index) {
                                  final thisNews = newslist[index];
                                  return NewsCard(news: thisNews, index: index);
                                },
                              ),
                            //For fade look in listview
                            Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [
                                    AppColors.backgroundColor,
                                    Colors.white.withOpacity(0),
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                )),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                  colors: [
                                    AppColors.backgroundColor,
                                    Colors.white.withOpacity(0),
                                  ],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                )),
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              //Search Widget
              Positioned(
                top: 10.h,
                right: 15.w,
                child: Container(
                  height: 60,
                  width: screenWidth(context) / 1.5,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x267088D2),
                        blurRadius: 30.0,
                        offset: Offset(0, 10),
                      ),
                    ],
                  ),
                  child: TypeAheadField<Article>(
                    suggestionsBoxDecoration: SuggestionsBoxDecoration(
                      color: Colors.transparent,
                    ),
                    textFieldConfiguration: TextFieldConfiguration(
                      style: text22,
                      cursorColor: AppColors.primaryColor,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          // borderRadius: BorderRadius.circular(5),
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColors.primaryColor,
                        ),
                        hintStyle: text20,
                        hintText: "Search News",
                      ),
                    ),
                    suggestionsCallback: (pattern) async {
                      return newslist.where((element) => element.title
                          .toLowerCase()
                          .contains(pattern.toLowerCase()));
                    },
                    onSuggestionSelected: (suggestion) {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                          builder: (context) => NewsDetail(
                            news: suggestion,
                          ),
                        ),
                      );
                    },
                    itemBuilder: (context, suggestion) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        child: ClipRect(
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                            child: ListTile(
                              tileColor: Colors.white54,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 10),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: ImageDisplayWidgetWithSize(
                                  height: 50.h,
                                  width: 50.h,
                                  fit: BoxFit.cover,
                                  url: suggestion.urlToImage,
                                ),
                              ),
                              title: Text(
                                suggestion.title,
                                style: text14.copyWith(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              //Menu Widget
              Positioned(
                top: 10.h,
                left: 10.w,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: AnimatedContainer(
                      padding: EdgeInsets.all(10),
                      duration: Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                      height: menuH,
                      width: menuW,
                      decoration: BoxDecoration(
                        color: isPlaying
                            ? AppColors.primaryColor.withOpacity(0.3)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0x267088D2),
                            blurRadius: 30.0,
                            offset: Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          if (isPlaying)
                            Center(
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                children: [
                                  verticalSpaceMassive,
                                  MenuButton(
                                    text: "Refresh page",
                                    color: Colors.green,
                                    icon: Icons.refresh,
                                    ontap: () {
                                      setState(() {
                                        _loading = true;
                                      });
                                      menuOntap();
                                      getAllNews();
                                    },
                                  ),
                                  verticalSpaceMedium20,
                                  MenuButton(
                                    text: "See categories",
                                    color: AppColors.primaryColor,
                                    icon: Icons.category,
                                    ontap: () {
                                      menuOntap();
                                    },
                                  ),
                                  verticalSpaceMedium20,
                                  MenuButton(
                                    text: "Exit",
                                    color: Colors.red,
                                    icon: Icons.exit_to_app,
                                    ontap: () {
                                      menuOntap();
                                      SystemNavigator.pop();
                                    },
                                  ),
                                ],
                              ),
                            ),
                          Positioned(
                            top: 5.h,
                            left: 10.w,
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: menuOntap,
                                  child: AnimatedIcon(
                                    icon: AnimatedIcons.menu_close,
                                    progress: _animationController,
                                    color: AppColors.primaryColor,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
