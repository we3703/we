import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/image_radio.dart';
import 'package:we/presentation/foundations/colors.dart';

class ImageCarouselItem extends StatelessWidget {
  final String imageUrl;
  final bool isAsset;
  final BoxFit fit;

  const ImageCarouselItem({
    super.key,
    required this.imageUrl,
    this.isAsset = false,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (isAsset) {
      return Container(
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.asset(
            imageUrl,
            fit: fit,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: AppColors.secondaryLight,
                child: const Icon(
                  Icons.broken_image,
                  size: 48,
                  color: AppColors.textDisabled,
                ),
              );
            },
          ),
        ),
      );
    }

    return AppImage(
      imageUrl: imageUrl,
      ratioType: ImageRatioType.ratio3x2,
      fit: fit,
      borderRadius: BorderRadius.circular(12),
    );
  }
}
