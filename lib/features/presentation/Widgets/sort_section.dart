import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../core/common/app_colors.dart';
import 'radio_item.dart';

class SortSection extends StatefulWidget {
  const SortSection({super.key});

  @override
  State<SortSection> createState() => _SortSectionState();
}

class _SortSectionState extends State<SortSection> {
  bool isSortExpanded = false;
  int selectedIndex = 0;

  List<String> items = [
    "Relevance",
    "Distance Low to High",
    "Ratings: High to Low",
    "Delivery Time: Low to High",
    "Cost for one: Low to High",
    "Cost for one: High to Low",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          GestureDetector(
            onTap: () {
              setState(() {
                isSortExpanded = !isSortExpanded;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                /// Left: Title
                const Text(
                  "Sort by",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                /// Right: Selected + Arrow
                Row(
                  children: [
                    if (!isSortExpanded) ...[
                      Text(
                        "Relevance",
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 4),
                    ],
                    Icon(
                      isSortExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.textPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ),

          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: isSortExpanded
                ? Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: List.generate(items.length, (index) {
                    return Column(
                      children: [
                        RadioItem(
                          text: items[index],
                          isSelected: selectedIndex == index,
                          onTap: () {
                            setState(() {
                              selectedIndex = index;
                              isSortExpanded = false;
                            });
                          },
                        ),

                        /// Divider (skip last item)
                        if (index != items.length - 1)
                          Divider(
                            height: 0.5,
                            thickness: 0.5,
                            color: Colors.grey.shade300,
                          ),
                      ],
                    );
                  }),
                ),
              ),
            )
                : const SizedBox(),
          ),        ],
      ),
    );
  }
}
