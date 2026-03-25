import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/repository_provider.dart';

class ExploreRiverpodScreen extends ConsumerWidget {
  const ExploreRiverpodScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final exploreAsync = ref.watch(exploreProvider);

    return exploreAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text("Error: $e")),
      data: (explores) {
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: explores.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final item = explores[index];

            return Container(
              width: 100,
              margin: EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(item.image!, width: 40, height: 40),
                  SizedBox(height: 4),
                  Text(
                    item.title!,
                    style: TextStyle(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}