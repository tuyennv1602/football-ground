import 'package:flutter/material.dart';
import 'package:footballground/res/styles.dart';

class ItemOptionWidget extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;
  final TextStyle titleStyle;
  final double iconHeight;
  final double iconWidth;
  final Color iconColor;

  ItemOptionWidget(this.image, this.title,
      {Key key,
      this.onTap,
      this.titleStyle,
      this.iconHeight,
      this.iconWidth,
      this.iconColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  image,
                  width: this.iconWidth ?? 25,
                  height: this.iconHeight ?? 25,
                  color: this.iconColor,
                ),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    this.title,
                    style: this.titleStyle ?? Styles.regular(size: 16),
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
