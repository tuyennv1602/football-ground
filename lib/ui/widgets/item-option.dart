import 'package:flutter/material.dart';
import 'package:footballground/res/colors.dart';

class ItemOptionWidget extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;
  final TextStyle titleStyle;
  final double iconHeight;
  final double iconWidth;
  final Color iconColor;

  ItemOptionWidget(this.image, this.title,
      {this.onTap,
      this.titleStyle,
      this.iconHeight,
      this.iconWidth,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                image,
                width: this.iconWidth ?? 30,
                height: this.iconHeight ?? 30,
                color: this.iconColor,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 5, right: 5),
                child: Text(
                  this.title + '\n',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  style: this.titleStyle ?? Theme.of(context).textTheme.body1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
