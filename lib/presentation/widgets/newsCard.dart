import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/models/article.dart';
import 'package:news_app/presentation/screens/newsDetail.dart';
import 'package:news_app/presentation/widgets/cached_network_widget.dart';
import 'package:news_app/utils/utility.dart';

class NewsCard extends StatefulWidget {
  final Article news;
  final int index;
  const NewsCard({Key key, @required this.news, @required this.index})
      : super(key: key);

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  onTap() {
    Navigator.push(
      context,
      CupertinoPageRoute(
        builder: (context) => NewsDetail(
          news: widget.news,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index % 2 == 0) {
      return InkWell(onTap: onTap, child: EvenNewsCard(widget: widget));
    } else {
      return InkWell(onTap: onTap, child: OddNewsCard(widget: widget));
    }
  }
}

class EvenNewsCard extends StatelessWidget {
  const EvenNewsCard({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final NewsCard widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      width: double.infinity,
      height: 180.h,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Container(
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
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: widget.news.urlToImage,
                    child: ImageDisplayWidgetWithSize(
                      url: widget.news.urlToImage,
                      height: 170.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            horizontalSpaceSmall,
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.2),
                      Colors.deepPurple.withOpacity(0.4),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondaryColor.withOpacity(0.1),
                      blurRadius: 30.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        widget.news.title,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: text16.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150.w,
                          child: Row(
                            children: [
                              Icon(
                                Icons.source_outlined,
                                color: Colors.black,
                                size: 18,
                              ),
                              horizontalSpaceTiny,
                              Expanded(
                                child: Text(
                                  widget.news.author ?? "Source",
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      text16.copyWith(color: Colors.grey[800]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: AppColors.primaryColor,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OddNewsCard extends StatelessWidget {
  const OddNewsCard({
    Key key,
    @required this.widget,
  }) : super(key: key);

  final NewsCard widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      width: double.infinity,
      height: 180.h,
      child: Container(
        margin: EdgeInsets.all(10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white.withOpacity(0.2),
                      Colors.deepPurple.withOpacity(0.3),
                    ],
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.secondaryColor.withOpacity(0.1),
                      blurRadius: 30.0,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        widget.news.title,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                        style: text16.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 150.w,
                          child: Row(
                            children: [
                              Icon(
                                Icons.source_outlined,
                                color: Colors.black,
                                size: 18,
                              ),
                              horizontalSpaceTiny,
                              Expanded(
                                child: Text(
                                  widget.news.author ?? "Source",
                                  overflow: TextOverflow.ellipsis,
                                  style:
                                      text16.copyWith(color: Colors.grey[800]),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.keyboard_arrow_right_outlined,
                          color: AppColors.primaryColor,
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            horizontalSpaceSmall,
            Expanded(
              flex: 2,
              child: Container(
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
                  borderRadius: BorderRadius.circular(20),
                  child: Hero(
                    tag: widget.news.urlToImage,
                    child: ImageDisplayWidgetWithSize(
                      url: widget.news.urlToImage,
                      height: 170.h,
                      fit: BoxFit.cover,
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
