import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/presentation/Widgets/sort_section.dart';
import 'package:food_delivery_app/features/presentation/Widgets/text_with_icon.dart';

import '../../../core/common/app_colors.dart';
import 'option.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final ScrollController _scrollController = ScrollController();

  final List<String> sections = [
    "Sort By",
    "Time",
    "Rating",
    "Offers",
    "Dish Price",
    "Trust Markers",
    "Collections",
  ];

  List<String> icons = [
    "assets/filters/sort_by.png",
    "assets/filters/time.png",
    "assets/filters/star.png",
    "assets/filters/discount.png",
    "assets/filters/trust.png",
    "assets/filters/rupee.png",
    "assets/filters/collections.png",
  ];

  int selectedIndex = 0;
  bool isUserScrolling = true;
  final GlobalKey _scrollContainerKey = GlobalKey();
  late List<GlobalKey> _sectionKeys;

  List<double> sectionOffsets = [];
  final double screenTop = 0;
  final double visibleTop = 120;

  @override
  void initState() {
    super.initState();

    _sectionKeys = List.generate(sections.length, (_) => GlobalKey());

    _scrollController.addListener(onScroll);
  }

  void scrollToIndex(int index) {
    isUserScrolling = false;

    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 300),
      );
    }

    setState(() {
      selectedIndex = index;
      print("Item clicked $selectedIndex");
    });

    /// Re-enable after scroll finishes
    Future.delayed(const Duration(milliseconds: 500), () {
      isUserScrolling = true;
    });
  }

  void onScroll() {
    if (!isUserScrolling) return;
    if (!_scrollController.hasClients) return;

    final scrollBox =
        _scrollContainerKey.currentContext?.findRenderObject() as RenderBox?;

    if (scrollBox == null) return;

    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final context = _sectionKeys[i].currentContext;

      if (context != null) {
        final renderObject = context.findRenderObject();

        if (renderObject is RenderBox) {
          final position = renderObject.localToGlobal(
            Offset.zero,
            ancestor: scrollBox,
          );

          //  for smooth UX
          if (position.dy <= 20) {
            if (selectedIndex != i) {
              setState(() {
                selectedIndex = i;
              });
            }
            break;
          }
        }
      }
    }
  }

  Widget sectionCard(String title, Widget child, int index) {
    final bool hasTitle = title.trim().isNotEmpty;

    return Container(
      key: _sectionKeys[index],

      /// remove vertical margin if no title
      margin: hasTitle
          ? const EdgeInsets.symmetric(vertical: 10)
          : EdgeInsets.zero,

      /// adjust padding
      padding: hasTitle
          ? const EdgeInsets.all(16)
          : const EdgeInsets.symmetric(horizontal: 16, vertical: 8),

      decoration: BoxDecoration(
        color: Color(0xF4F3F5F6),
        borderRadius: BorderRadius.circular(12),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasTitle) ...[
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
          ],

          child,
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Filters and sorting",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    "Clear all",
                    style: TextStyle(fontSize: 14, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
          const Divider(),

          Expanded(
            child: Row(
              children: [
                /// LEFT MENU
                Container(
                  width: 80,
                  color: Colors.white,
                  child: ListView.builder(
                    itemCount: sections.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () => scrollToIndex(index),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: selectedIndex == index
                                ? AppColors.selectedBg
                                : Colors.transparent,
                            border: Border(
                              right: BorderSide(
                                color: selectedIndex == index
                                    ? Colors.red
                                    : Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                icons[index],
                                width: 20,
                                height: 20,
                                color: selectedIndex == index
                                    ? Colors.red
                                    : Colors.grey,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                sections[index],
                                style: TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                /// ADD DIVIDER HERE
                Container(
                  width: 0.5,
                  height: double.infinity,
                  color: Colors.grey.shade300,
                ),

                /// RIGHT CONTENT
                Expanded(
                  child: ListView(
                    key: _scrollContainerKey,
                    controller: _scrollController,
                    padding: const EdgeInsets.all(12),
                    children: [
                      sectionCard("", SortSection(), 0),

                      sectionCard(
                        "Time",
                        Row(
                          children: [
                            Expanded(
                              child: TextWithIcon(
                                text: "Schedule",
                                icon: "assets/filters/time.png",
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextWithIcon(
                                text: "Near & Fast",
                                icon: "assets/filters/near_fast.png",
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                        1,
                      ),

                      sectionCard(
                        "Rating",
                        Row(
                          children: [
                            Expanded(
                              child: TextWithIcon(
                                text: "Schedule",
                                icon: "assets/images/fill_star.png",
                                color: Colors.green.shade700,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: TextWithIcon(
                                text: "Near & Fast",
                                icon: "assets/images/fill_star.png",
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                        2,
                      ),

                      sectionCard(
                        "Offers",
                        Wrap(
                          children: [
                            option("Buy 1 Get 1 and more"),
                            option("Deals of the Day"),
                          ],
                        ),
                        3,
                      ),

                      sectionCard(
                        "Dish Price",
                        Row(
                          children: [
                            Expanded(
                              child: TextWithIcon(
                                text: "Under 200",
                                icon: "assets/filters/rupee.png",
                                color: Colors.green.shade900,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextWithIcon(
                                text: "200-350",
                                icon: "assets/filters/rupee.png",
                                color: Colors.green.shade900,
                              ),
                            ),
                            SizedBox(width: 5),
                            Expanded(
                              child: TextWithIcon(
                                text: "Above 350",
                                icon: "assets/filters/rupee.png",
                                color: Colors.green.shade900,
                              ),
                            ),
                          ],
                        ),
                        4,
                      ),
                      sectionCard(
                        "Trust Markers",
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            children: [
                              /// First Row
                              Row(
                                children: [
                                  Expanded(
                                    child: TextWithIcon(
                                      text: "Pure Veg",
                                      icon: "assets/filters/rupee.png",
                                      color: Colors.green.shade900,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: TextWithIcon(
                                      text: "No Packaging",
                                      icon: "assets/filters/rupee.png",
                                      color: Colors.green.shade900,
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),

                              /// Second Row
                              Row(
                                children: [
                                  Expanded(
                                    child: TextWithIcon(
                                      text: "Low plastic packaging",
                                      icon: "assets/filters/rupee.png",
                                      color: Colors.green.shade900,
                                    ),
                                  ),

                                  /// 👇 empty space to balance layout
                                  const Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        5,
                      ),

                      sectionCard(
                        "Collections",
                        Wrap(children: [option("Gourment")]),
                        6,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// BOTTOM BUTTONS
          Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        backgroundColor: AppColors.textPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Show results",
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
