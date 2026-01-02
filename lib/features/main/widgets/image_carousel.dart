import 'package:flutter/material.dart';
import 'package:we/core/theme/colors.dart';
import 'package:we/core/theme/radius.dart';
import 'package:we/core/theme/spacing.dart';

class ImageCarousel extends StatefulWidget {
  final List<String> images;
  final double height;

  const ImageCarousel({super.key, required this.images, this.height = 220});

  @override
  State<ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<ImageCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: widget.images.length,
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: AppRadius.lg,
                  image: DecorationImage(
                    image: AssetImage(widget.images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          Positioned(
            bottom: AppSpacing.space8,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
                  List.generate(
                        widget.images.length,
                        (index) => _buildIndicator(index == _currentPage),
                      )
                      .expand((widget) => [widget, const SizedBox(width: 8)])
                      .toList()
                    ..removeLast(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIndicator(bool isActive) {
    // 인디케이터 크기 설정
    final double defaultSize = 8;
    final double selectedSize = 10;

    // 인디케이터 색상 설정
    final Color activeColor = AppColors.primaryDefault;
    final Color inactiveColor = AppColors.textDisabled;

    // TODO: 크기 변화 애니메이션
    return Container(
      width: isActive ? selectedSize : defaultSize,
      height: isActive ? selectedSize : defaultSize,
      decoration: BoxDecoration(
        color: isActive ? activeColor : inactiveColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
