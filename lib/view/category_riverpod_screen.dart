import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/repository_provider.dart';

class CategoryRiverpodScreen extends ConsumerWidget {
  final Function(String, int) onCategoryTap;

  const CategoryRiverpodScreen({
    super.key,
    required this.onCategoryTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryAsync = ref.watch(categoryProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return categoryAsync.when(
      loading: () => const CircularProgressIndicator(),

      error: (e, _) => Text("Error: $e"),

      data: (categories) {
        return SizedBox(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 24),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final item = categories[index];

              return GestureDetector(
                onTap: () {
                  ref.read(selectedCategoryProvider.notifier).state = item.name;

                  // send correct index
                  onCategoryTap(item.name, index);
                },
                child: AspectRatio(
                  aspectRatio: 0.8,
                  child: Column(
                    children: [
                      Image.asset(item.image, height: 40),
                      Text(item.name,style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      )),
                      Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: selectedCategory == item.name ? Colors.orange: Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                ),
              );
              },
          ),
        );
      },
    );
  }
}