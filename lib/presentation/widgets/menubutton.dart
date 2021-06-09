import 'package:flutter/material.dart';
import 'package:news_app/utils/utility.dart';

class MenuButton extends StatelessWidget {
  final Function ontap;
  final String text;
  final IconData icon;
  final Color color;
  const MenuButton({Key key, this.ontap, this.text, this.icon, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      height: 45.h,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      onPressed: ontap,
      child: Row(
        children: [
          Icon(
            icon,
            color: color,
            size: 30,
          ),
          horizontalSpaceMedium20,
          Expanded(
            child: Text(
              text,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: text20.copyWith(
                  color: AppColors.secondaryColor, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
