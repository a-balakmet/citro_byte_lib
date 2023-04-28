import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

enum ImageFit { fitWidth, fitHeight, fill }

class UrlImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final ImageFit imageFit;
  final double cornersRadius;
  final bool? sideRoundCorners;
  final Widget? placeholder;
  final Widget errorWidget;
  final Color? baseColor;
  final Color? highlightColor;
  const UrlImage({
    Key? key,
    required this.url,
    required this.width,
    required this.height,
    required this.imageFit,
    required this.cornersRadius,
    this.sideRoundCorners,
    this.placeholder,
    required this.errorWidget,
    required this.baseColor,
    required this.highlightColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BoxFit boxFit;

    boxFit = <ImageFit, BoxFit Function()>{
      ImageFit.fill: () => BoxFit.fill,
      ImageFit.fitHeight: () => BoxFit.fitHeight,
      ImageFit.fitWidth: () => BoxFit.fitWidth
    }[imageFit]!();

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
                fit: boxFit,
              ),
            ),
          ),
          placeholder: (context, _) {
            return Builder(builder: (context) {
              if (placeholder == null) {
                return Shimmer.fromColors(
                  baseColor: baseColor ?? Colors.grey.shade500,
                  highlightColor: highlightColor ?? Colors.white,
                  child: Container(
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
                    ),
                  ),
                );
              } else {
                return Container(
                  width: width / 2,
                  height: height / 2,
                  alignment: Alignment.center,
                  child: placeholder,
                );
              }
            });
          },
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
