import 'package:flutter/material.dart';
import 'package:news_app/api/news.dart';
import 'package:news_app/models/category.dart';
import 'package:news_app/presentation/widgets/cached_network_widget.dart';
import 'package:news_app/presentation/widgets/custom_loading.dart';
import 'package:news_app/presentation/widgets/newsCard.dart';
import 'package:news_app/utils/colors.dart';
import 'package:news_app/utils/utility.dart';

class NewsOfCategory extends StatefulWidget {
  final CategoryModel newsCategory;

  const NewsOfCategory({Key key, @required this.newsCategory})
      : super(key: key);

  @override
  _NewsOfCategoryState createState() => _NewsOfCategoryState();
}

class _NewsOfCategoryState extends State<NewsOfCategory> {
  var newslist;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    getNews();
  }

  void getNews() async {
    NewsForCategory news = NewsForCategory();
    await news
        .getNewsForCategory(widget.newsCategory.categoryName.toLowerCase());
    newslist = news.news;
    setState(() {
      _loading = false;
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
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Row(
                children: [
                  horizontalSpaceMedium20,
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Image.asset(
                      "images/back.png",
                      height: 50,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
              ),
              verticalSpaceMedium20,
              Container(
                height: 120.h,
                width: screenWidth(context),
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondaryColor.withOpacity(0.15),
                      blurRadius: 30.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Hero(
                        tag: widget.newsCategory.categoryName,
                        child: ImageDisplayWidgetWithSize(
                          url: widget.newsCategory.imageUrl,
                          fit: BoxFit.cover,
                          width: screenWidth(context),
                          height: 120.h,
                        ),
                      ),
                    ),
                    Container(
                      height: 200.h,
                      width: screenWidth(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        gradient: RadialGradient(
                          colors: [
                            Colors.black.withOpacity(0.8),
                            Colors.transparent,
                          ],
                          radius: 1.5,
                          stops: <double>[0.0, 0.8],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          widget.newsCategory.categoryName,
                          style: text30.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpaceMedium30,
              Container(
                height: screenHeight(context) / 1.4,
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
            ],
          ),
        ),
      ),
    );
  }
}
