import 'package:flutter/material.dart';
import 'package:we/presentation/foundations/colors.dart';

class ImageRatios {
  // 1:1 비율
  static const double ratio1x1 = 1.0;

  // 3:2 비율
  static const double ratio3x2 = 3.0 / 2.0;
}

// ==================== Custom Image Widget ====================
enum ImageRatioType { ratio1x1, ratio3x2 }

class AppImage extends StatelessWidget {
  final String imageUrl;
  final ImageRatioType ratioType;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final Widget? placeholder;
  final Widget? errorWidget;

  const AppImage({
    super.key,
    required this.imageUrl,
    required this.ratioType,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.placeholder,
    this.errorWidget,
  });

  double get _aspectRatio {
    switch (ratioType) {
      case ImageRatioType.ratio1x1:
        return ImageRatios.ratio1x1;
      case ImageRatioType.ratio3x2:
        return ImageRatios.ratio3x2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _aspectRatio,
      child: Container(
        color: Colors.white,
        child: ClipRRect(
          borderRadius: borderRadius ?? BorderRadius.zero,
          child: Image.network(
            imageUrl,
            fit: fit,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return placeholder ??
                  Container(
                    color: AppColors.secondaryLight,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                            : null,
                        color: AppColors.primaryDarkGreen,
                      ),
                    ),
                  );
            },
            errorBuilder: (context, error, stackTrace) {
              return errorWidget ??
                  Container(
                    color: AppColors.secondaryLight,
                    child: Icon(
                      Icons.broken_image,
                      size: 48,
                      color: AppColors.textDisabled,
                    ),
                  );
            },
          ),
        ),
      ),
    );
  }
}
