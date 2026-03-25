import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../view/view_cart_screen.dart';

class Bottomsheetscrollui extends StatelessWidget {
  final double progress; // 0 → 1

  const Bottomsheetscrollui({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    double homeHeight = 72 * (1 - progress);
    double homeOpacity = 1 - progress;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// CART + HEALTHY
        Row(
          children: [
            Expanded(child: _viewCartBar(context)),

            const SizedBox(width: 10),

            /// Healthy button (smooth resize)
            _healthyButton(progress < 0.5),
          ],
        ),

        const SizedBox(height: 8),

        /// HOME BAR (smooth collapse)
        ClipRect(
          child: Align(
            heightFactor: (1 - progress).clamp(0.0, 1.0),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              opacity: homeOpacity,
              child: SizedBox(
                height: homeHeight,
                child: _homeWithHealthy(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// VIEW CART UI
Widget _viewCartBar(BuildContext context) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: const [
        BoxShadow(color: Colors.black12, blurRadius: 8),
      ],
    ),
    child: Row(
      children: [
        const CircleAvatar(
          radius: 18,
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
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
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
        ),
      ],
    ),
  );
}

/// HOME + HEALTHY
Widget _homeWithHealthy() {
  return Row(
    children: [
      Expanded(child: _homeBottomBar()),
      const SizedBox(width: 12),
      _healthyButton(true),
    ],
  );
}

/// HOME BAR
Widget _homeBottomBar() {
  return Container(
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

/// HEALTHY BUTTON
Widget _healthyButton(bool showText) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 400),
    curve: Curves.easeInOut,
    height: 60,
    width: showText ? 90 : 50,
    padding: const EdgeInsets.symmetric(vertical: 6),
    decoration: BoxDecoration(
      color: Colors.green[700],
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(25),
        bottomLeft: Radius.circular(25),
      ),
      boxShadow: const [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 8,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.monitor_heart, color: Colors.white, size: 20),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeInOut,
          switchOutCurve: Curves.easeInOut,
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SizeTransition(
                sizeFactor: animation,
                axis: Axis.vertical,
                child: child,
              ),
            );
          },
          child: showText
              ? const Padding(
            key: ValueKey("text"),
            padding: EdgeInsets.only(top: 2),
            child: Text(
              "Healthy Mode",
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          )
              : const SizedBox(key: ValueKey("empty")),
        ),
      ],
    ),
  );
}

/// Bottom Item
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