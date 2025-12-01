import 'package:flutter/material.dart';
import 'package:we/presentation/molecules/image/image_carousel_item.dart';
import 'package:we/presentation/molecules/indicator/carousel_indicator.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> imageUrls;
  final double? height;

  const ImageCarousel({
    super.key,
    required this.imageUrls,
    this.height, // e.g. 200
  });

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PageView.builder(
            itemCount: widget.imageUrls.length,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return ImageCarouselItem(imageUrl: widget.imageUrls[index]);
            },
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: CarouselIndicator(
              itemCount: widget.imageUrls.length,
              currentIndex: _currentIndex,
            ),
          ),
        ],
      ),
    );
  }
}
