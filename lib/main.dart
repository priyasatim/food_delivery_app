import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:food_delivery_app/features/presentation/bloc/food/food_bloc.dart';
import 'package:food_delivery_app/features/presentation/bloc/food/food_event.dart';

import 'features/domain/repository/categories_repository.dart';
import 'features/domain/repository/explore_repository.dart';
import 'features/domain/repository/restaurant_repository.dart';
import 'features/presentation/bloc/category/category_bloc.dart';
import 'features/presentation/bloc/category/category_event.dart';
import 'features/presentation/bloc/explore/explore_bloc.dart';
import 'features/presentation/bloc/explore/explore_event.dart';
import 'features/presentation/bloc/restaurant/restaurant_bloc.dart';
import 'features/presentation/bloc/restaurant/restaurant_event.dart';
import 'features/presentation/view/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    ProviderScope(
      // Riverpod root
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                CategoryBloc(repository: CategoriesRepository())
                  ..add(LoadCategories()),
          ),

          BlocProvider(
            create: (_) =>
                ExploreBloc(repository: ExploreRepository())
                  ..add(LoadExplore()),
          ),
          BlocProvider(
            create: (_) =>
                RestaurantBloc(repository: RestaurantRepository())
                  ..add(LoadAllFood()),
          ),
          BlocProvider(
            create: (_) =>
                FoodBloc(repository: RestaurantRepository())
                  ..add(LoadFoodDetail(0)),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Poppins',
        textTheme: Theme.of(context).textTheme.apply(fontFamily: 'Poppins'),

        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}
