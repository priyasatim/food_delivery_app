import 'dart:async';
import 'package:flutter/material.dart';

import '../../data/model/BannerModel.dart';
import 'offer_banner.dart';

class SliderPage extends StatefulWidget {
  const SliderPage({super.key});

  @override
  State<SliderPage> createState() => _SliderPageState();
}

class _SliderPageState extends State<SliderPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _timer;

  final List<BannerModel> banners = [
    BannerModel(
      title: "ITEMS AT",
      subtitle: "50% OFF",
      colors: [Color(0xffFF3D3D), Color(0xffFF0000)],
      image: "assets/images/burger.png"
    ),
    BannerModel(
      title: "GOLD",
      subtitle: "₹1 for 3 months",
      colors: [Color(0xffFFD700), Color(0xffFFC107)],
      image: "assets/images/pizza.png"
    ),
    BannerModel(
      title: "FREE DELIVERY",
      subtitle: "Above ₹199",
      colors: [Color(0xff00C853), Color(0xff009624)],
      image: "assets/images/fries.png"
    ),
  ];

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_currentPage < banners.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: banners.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              final banner = banners[index];

              return AnimatedOfferBanner(
                title: banner.title,
                subtitle: banner.subtitle,
                colors: banner.colors,
                image: banner.image,
              );
            },
          ),

          /// DOT INDICATOR
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                banners.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 10 : 6,
                  height: _currentPage == index ? 10 : 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index
                        ? Colors.orange
                        : Colors.white70,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}