import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:news_app/utils/colors.dart';

class Loading extends StatelessWidget {
  final double size;
  const Loading({Key key, this.size = 50.0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitPouringHourglass(
      color: AppColors.primaryColor,
      size: size,
    );
  }
}
