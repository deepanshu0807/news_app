import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/presentation/widgets/cached_network_widget.dart';
import 'package:news_app/utils/utility.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatelessWidget {
  final Article news;
  const NewsDetail({Key key, @required this.news}) : super(key: key);

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Expanded(child: Container()),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondaryColor.withOpacity(0.15),
                          blurRadius: 30.0,
                          offset: Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.timelapse),
                        horizontalSpaceSmall,
                        Text(
                          "${news.publshedAt.day}/${news.publshedAt.month}/${news.publshedAt.year}",
                          style: text16,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              verticalSpaceMedium20,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.2),
                      Colors.deepPurple.withOpacity(0.4),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondaryColor.withOpacity(0.15),
                      blurRadius: 30.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.chrome_reader_mode,
                      color: AppColors.primaryColor,
                      size: 30,
                    ),
                    horizontalSpaceMedium15,
                    Expanded(
                      child: Text(
                        news.title,
                        style: text20.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpaceMedium15,
              Container(
                height: screenHeight(context) / 2.4,
                width: screenWidth(context) / 1.5,
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondaryColor.withOpacity(0.1),
                      blurRadius: 30.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Hero(
                    tag: news.urlToImage,
                    child: ImageDisplayWidget(
                      url: news.urlToImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              verticalSpaceMedium15,
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondaryColor.withOpacity(0.15),
                      blurRadius: 30.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.article,
                          color: AppColors.primaryColor,
                          size: 30,
                        ),
                        horizontalSpaceSmall,
                        Expanded(
                          child: Text(
                            news.author ?? "Author Unknown",
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: text20.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceSmall,
                    Divider(
                      color: Colors.grey,
                    ),
                    verticalSpaceSmall,
                    Text(
                      news.description ?? "",
                      style: text20,
                    ),
                    verticalSpaceSmall,
                    Divider(
                      color: Colors.grey,
                    ),
                    verticalSpaceSmall,
                    Text(
                      news.content ?? "",
                      style: text18,
                    )
                  ],
                ),
              ),
              verticalSpaceMedium15,
              Padding(
                padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
                child: FlatButton(
                  height: 50,
                  color: AppColors.secondaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () async {
                    await launch(news.articleUrl);
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.read_more_outlined,
                        color: Colors.white,
                        size: 30,
                      ),
                      horizontalSpaceMedium20,
                      Text(
                        "Read full article",
                        style: text22.copyWith(color: Colors.white),
                      ),
                    ],
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
