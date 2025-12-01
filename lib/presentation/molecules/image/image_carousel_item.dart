import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/image_radio.dart';

class ImageCarouselItem extends StatelessWidget {
  final String imageUrl;

  const ImageCarouselItem({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AppImage(
      imageUrl: imageUrl,
      ratioType: ImageRatioType.ratio3x2, // Or make this configurable
      fit: BoxFit.cover,
    );
  }
}
