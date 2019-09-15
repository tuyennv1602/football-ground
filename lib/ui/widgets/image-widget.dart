import 'package:flutter/cupertino.dart';
import 'package:footballground/res/images.dart';

class ImageWidget extends StatelessWidget {
  final String source;
  final double size;
  final double radius;
  final String placeHolder;

  ImageWidget(
      {Key key,
      this.source,
      @required this.placeHolder,
      this.size = 50,
      this.radius = 5})
      : assert(placeHolder != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return source != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(radius),
            child: FadeInImage.assetNetwork(
              image: source,
              placeholder: placeHolder,
              width: size,
              height: size,
              fit: BoxFit.cover,
              fadeInDuration: Duration(milliseconds: 100),
              fadeOutDuration: Duration(milliseconds: 100),
            ),
          )
        : Image.asset(
            placeHolder,
            width: size,
            height: size,
            fit: BoxFit.cover,
          );
  }
}
