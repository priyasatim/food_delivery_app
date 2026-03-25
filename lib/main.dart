import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zomato_app/database/CartService.dart';
import 'package:zomato_app/view/home_screen.dart';

import 'bloc/category/categories_repository.dart';
import 'bloc/category/category_bloc.dart';
import 'bloc/category/category_event.dart';
import 'bloc/explore/explore_bloc.dart';
import 'bloc/explore/explore_event.dart';
import 'bloc/explore/explore_repository.dart';
import 'bloc/restaurant/restaurant_bloc.dart';
import 'bloc/restaurant/restaurant_event.dart';
import 'bloc/restaurant/restaurant_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await CartService().init();

  runApp(
    ProviderScope( // Riverpod root
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CategoryBloc(
              repository: CategoriesRepository(),
            )..add(LoadCategories()),
          ),
          BlocProvider(
            create: (_) => ExploreBloc(
              repository: ExploreRepository(),
            )..add(LoadExplore()),
          ),
          BlocProvider(
            create: (_) => RestaurantBloc(
              repository: RestaurantRepository(),
            )..add(LoadAllFood()),
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
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Poppins',
        ),
       
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: HomePage(),
    );
  }
}

