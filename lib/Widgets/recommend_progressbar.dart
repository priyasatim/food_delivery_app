import 'package:flutter/material.dart';

class RecommendationProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final String text;
  final Color progressColor;
  final Color backgroundColor;

  const RecommendationProgressBar({
    super.key,
    required this.progress,
    required this.text,
    this.progressColor = Colors.green,
    this.backgroundColor = const Color(0xFFE8F5E9),
  });

  @override
  Widget build(BuildContext context) {

    double progress = (4 / 5).clamp(0.0, 1.0);

    return Row(
      children: [


        Container(
            width: 60,
            height: 4,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: LinearProgressIndicator(
                value: progress,
                backgroundColor: Colors.grey.shade300,
                valueColor: AlwaysStoppedAnimation(Colors.green),
              ),
            ),),
        const SizedBox(width: 8),
        Text(text,
            style: const TextStyle(
              fontSize: 10,
              color: Colors.grey,
              fontWeight: FontWeight.w300,
            )),

      ],
    );
  }
}