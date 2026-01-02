import 'package:flutter/material.dart';
import 'package:we/core/config/constant.dart';
import 'package:we/features/main/widgets/image_carousel.dart';

class BannerSection extends StatelessWidget {
  const BannerSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ImageCarousel(
      images: AppConstant.banners,
      height: 220
    );
  }
}
