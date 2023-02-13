import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

enum ImageFit { fitWidth, fitHeight, fill }

class UrlImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final ImageFit imageFit;
  final double cornersRadius;
  final bool? sideRoundCorners;
  final Widget placeholder;
  final Widget errorWidget;
  const UrlImage({
    Key? key,
    required this.url,
    required this.width,
    required this.height,
    required this.imageFit,
    required this.cornersRadius,
    this.sideRoundCorners,
    required this.placeholder,
    required this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxFit? boxFit;
    
    boxFit = <ImageFit, BoxFit Function()>{
      ImageFit.fill:() => BoxFit.fill,
      ImageFit.fitHeight:() => BoxFit.fitHeight,
      ImageFit.fitWidth:() => BoxFit.fitWidth
    }[ImageFit]!();

    return Builder(builder: ((context) {
      // Shit happens
      if (url.startsWith('http') && url.endsWith('jpg') || url.startsWith('http') && url.endsWith('png')) {
        return CachedNetworkImage(
          imageUrl: url,
          width: width,
          height: height,
          imageBuilder: (context, imageProvider) => Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              borderRadius: sideRoundCorners == null
                  ? BorderRadius.all(Radius.circular(cornersRadius))
                  : sideRoundCorners!
                      ? BorderRadius.only(
                          bottomLeft: Radius.circular(cornersRadius),
                          bottomRight: Radius.circular(cornersRadius),
                        )
                      : BorderRadius.only(
                          topLeft: Radius.circular(cornersRadius),
                          topRight: Radius.circular(cornersRadius),
                        ),
              image: DecorationImage(
                image: imageProvider,
                fit: height == (MediaQuery.of(context).size.width - 40) * 0.411 ? BoxFit.fitWidth : BoxFit.fill,
              ),
            ),
          ),
          placeholder: (context, _) => Container(
            width: width / 2,
            height: height / 2,
            alignment: Alignment.center,
            child: placeholder,
          ),
          errorWidget: (context, url, error) => Container(
            width: width / 2,
            height: height / 2,
            alignment: Alignment.center,
            child: errorWidget,
          ),
          fit: boxFit,
          fadeInDuration: const Duration(microseconds: 0),
          fadeOutDuration: const Duration(microseconds: 0),
          placeholderFadeInDuration: const Duration(microseconds: 0),
        );
      } else {
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            borderRadius: sideRoundCorners == null
                ? BorderRadius.all(Radius.circular(cornersRadius))
                : BorderRadius.only(bottomLeft: Radius.circular(cornersRadius), bottomRight: Radius.circular(cornersRadius)),
          ),
          alignment: Alignment.center,
          child: errorWidget,
        );
      }
    }));
  }
}
