import 'package:flutter/material.dart';

class AnimatedOfferBanner extends StatefulWidget {
  final String title;
  final String subtitle;
  final List<Color> colors;
  final String image;

  const AnimatedOfferBanner({
    super.key,
    required this.title,
    required this.subtitle,
    required this.colors,
    required this.image,
  });

  @override
  State<AnimatedOfferBanner> createState() => _AnimatedOfferBannerState();
}

class _AnimatedOfferBannerState extends State<AnimatedOfferBanner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> scaleAnim;
  late Animation<Offset> slideAnim;
  late Animation<double> fadeAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    scaleAnim = Tween<double>(begin: 0.7, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    fadeAnim = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant AnimatedOfferBanner oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Restart animation when banner changes
    _controller.reset();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: widget.colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
        child: Column(
            children: [
            /// TOP SPACE (Search / Toolbar placeholder)
            SizedBox(height: 140),

              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16), // add this
                  child: Row(
                    children: [
                      /// LEFT SIDE (TEXT + BUTTON)
                      Expanded(
                        flex: 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SlideTransition(
                              position: slideAnim,
                              child: ScaleTransition(
                                scale: scaleAnim,
                                child: Text(
                                  widget.title,
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                    color: Colors.yellow,
                                  ),
                                ),
                              ),
                            ),

                            ScaleTransition(
                              scale: scaleAnim,
                              child: Text(
                                widget.subtitle,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            const SizedBox(height: 8),

                            FadeTransition(
                              opacity: fadeAnim,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                onPressed: () {},
                                child: const Text("Order now →",style: TextStyle(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),

                      ///  RIGHT SIDE (IMAGE)
                      Expanded(
                        flex: 1,
                        child: ScaleTransition(
                          scale: scaleAnim,
                          child: Image.asset(
                            widget.image,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )            ]
        )
    );
  }
}