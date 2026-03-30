import 'package:flutter/material.dart';
import 'package:food_delivery_app/view/view_cart_screen.dart';

import '../Utility/app_colors.dart';

class Bottomsheetscrollui extends StatelessWidget {
  final double progress;
  final double baseBottom = 8;

  const Bottomsheetscrollui({
    super.key,
    required this.progress,
  });


  @override
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: Stack(
          children: [
            /// HOME BAR (MOVES DOWN & OUT)
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,

              bottom: baseBottom - (70 * progress),
              left: 12,
              right: 100,

              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: (1 - progress).clamp(0.0, 1.0),
                child: _homeBottomBar(),
              ),
            ),

            /// VIEW CART (MOVES FROM ROW1 → ROW2)
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: progress),
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              builder: (context, value, child) {
                return Positioned(
                  bottom: baseBottom + (70 * (1 - value)),
                  left: 12,
                  right: 10 + (value * 48),
                  child: child!,
                );
              },
              child: _viewCartBar(context),
            ),

            /// HEALTHY (STAYS FIXED)
            Positioned(
              right: 0,
              bottom: baseBottom,
              child: _healthyButton(progress < 0.5),
            ),
          ],
      ),
    );
  }
}

Widget _viewCartBar(BuildContext context, {Key? key}) {
  return Container(
    key: key,
    height: 60,
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 8),
      ],
    ),
    child: SizedBox.expand(

        child: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage("assets/images/burger.png"),
            ),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                "McDonald's\nView Menu",
                style: TextStyle(fontSize: 12),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewCartPage(),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xffFF5A5F), Color(0xffFF2D55)],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "View Cart",
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            )        ],
        )),
  );
}

Widget _homeBottomBar({Key? key}) {
  return Container(
    key: key,
    height: 60,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(50),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 10,
          offset: Offset(0, 3),
        ),
      ],
    ),
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const [
        _BottomItem(Icons.home, "Home"),
        _BottomItem(Icons.local_offer, "Under ₹250"),
        _BottomItem(Icons.discount, "Offers"),
        _BottomItem(Icons.restaurant, "Dining"),
      ],
    ),
  );
}

Widget _healthyButton(bool showText) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    height: 60,
    width: showText ? 90 : 50,
    decoration: BoxDecoration(
      color: AppColors.darkGreen,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        bottomLeft: Radius.circular(25),
      ),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.monitor_heart,
            color: Colors.white, size: 20),
        if (showText)
          const Text(
            "Healthy Mode",
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
      ],
    ),
  );
}
class _BottomItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _BottomItem(this.icon, this.label);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 18),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 8)),
      ],
    );
  }
}
