import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/repository_provider.dart';

class CategoryRiverpodScreen extends ConsumerWidget {
  final Function(String, int) onCategoryTap;
  final bool? isVeg;

  const CategoryRiverpodScreen({
    super.key,
    required this.onCategoryTap,
    this.isVeg
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoryAsync = ref.watch(categoriesProvider(isVeg));
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return categoryAsync.when(
      loading: () => const CircularProgressIndicator(),

      error: (e, _) => Text("Error: $e"),

      data: (categories) {
        return Container(
          color: Color(0xFFF8F8F8),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,   
            itemBuilder: (context, index) {
              final cat = categories[index];
              return  GestureDetector(
                  onTap: () {
                    ref.read(selectedCategoryProvider.notifier).state = cat.name;

                    // send correct index
                    onCategoryTap(cat.name, index);
                  },
                  child: Container(
                width: 80,
                margin: EdgeInsets.only(right: 4),
                  child: AspectRatio(
                    aspectRatio: 0.8,
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(cat.image, width: 46, height: 46),
                    const SizedBox(height: 2),
                    Text(
                      cat.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 2),
                    // Line below category
                    Container(
                      height: 3,
                      decoration: BoxDecoration(
                        color: selectedCategory == cat.name ? Colors.orange: Colors.transparent,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                )),
              ));
            },
          ),
        );
      },
    );
  }
}