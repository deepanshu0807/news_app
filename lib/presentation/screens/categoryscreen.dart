import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/api/categorydata.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/presentation/screens/news_of_category.dart';
import 'package:news_app/presentation/widgets/cached_network_widget.dart';
import 'package:news_app/utils/utility.dart';
import 'package:parallax_animation/parallax_animation.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({Key key}) : super(key: key);

  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  List<CategoryModel> categories = <CategoryModel>[];

  @override
  void initState() {
    super.initState();
    categories = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Container(
          height: screenHeight(context),
          width: screenWidth(context),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              verticalSpaceMedium15,
              Container(
                padding: EdgeInsets.only(left: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "All",
                      style: text30,
                    ),
                    Text(
                      "Categories",
                      style: text40.copyWith(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              verticalSpaceMedium20,
              SizedBox(
                height: screenHeight(context) / 1.3,
                width: screenWidth(context),
                child: Stack(
                  children: [
                    ParallaxArea(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          final thisCat = categories[index];
                          return Container(
                            height: 200.h,
                            width: screenWidth(context),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => NewsOfCategory(
                                      newsCategory: thisCat,
                                    ),
                                  ),
                                );
                              },
                              child: ParallaxWidget(
                                parallaxPadding: EdgeInsets.symmetric(
                                    vertical: 15.h, horizontal: 20.w),
                                child: Center(
                                  child: Text(
                                    thisCat.categoryName,
                                    textAlign: TextAlign.center,
                                    style: text40.copyWith(color: Colors.white),
                                  ),
                                ),
                                background: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Hero(
                                    tag: thisCat.categoryName,
                                    child: ImageDisplayWidget(
                                      url: thisCat.imageUrl,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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
              verticalSpaceMedium30,
            ],
          ),
        ),
      ),
    );
  }
}
