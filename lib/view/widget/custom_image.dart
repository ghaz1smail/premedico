import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/widgets.dart';

class CustomImage extends StatelessWidget {
  final String url;
  final double radius, width, height;
  final bool network;
  final BoxFit? boxFit;
  const CustomImage(
      {super.key,
      required this.url,
      this.radius = 100,
      this.width = 50,
      this.height = 50,
      this.boxFit,
      this.network = true});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(radius)),
      child: url.isEmpty || !network
          ? Image.asset(
              network ? 'assets/images/icon.png' : '',
              height: height,
              width: width,
              fit: boxFit ?? BoxFit.contain,
            )
          : CachedNetworkImage(
              imageUrl: url,
              height: width,
              width: width,
              fit: boxFit ?? BoxFit.contain,
            ),
    );
  }
}
