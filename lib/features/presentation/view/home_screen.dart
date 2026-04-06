import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/presentation/view/product_details_screen.dart';
import 'package:food_delivery_app/features/presentation/view/profile_screen.dart';
import 'package:food_delivery_app/features/presentation/view/search_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/database/CartService.dart';
import '../../data/database/local/db_helper.dart';
import '../../data/model/location.dart';
import '../Widgets/app_circle_icon.dart';
import '../Widgets/bottom_sheet_scroll_ui.dart';
import '../Widgets/explore_more_screen.dart';
import '../Widgets/filter_bottom_sheet.dart';
import '../Widgets/location_bottom_sheet.dart';
import '../Widgets/restaurant_card.dart';
import '../Widgets/slider_page.dart';
import '../Widgets/veg_nonveg_toggle.dart';
import '../bloc/explore/explore_bloc.dart';
import '../bloc/explore/explore_state.dart';
import '../bloc/restaurant/restaurant_bloc.dart';
import '../bloc/restaurant/restaurant_event.dart';
import '../bloc/restaurant/restaurant_state.dart';
import 'restaurant_list_item.dart';
import 'category_riverpod_screen.dart';
import 'address_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver{
  String locationPlace = "Home";
  String currentLocation = "Fetching location...";
  int cartCount = 0;
  late ScrollController _scrollController;
  double progress = 0;
  bool showHome = true;
  // late final CategoryBloc categoryBloc;
  File? _profileImage;
  bool isVegOnly = false;


  final List<Map<String, String>> items = [
    {
      "image": "assets/images/idali.jpg",
      "title": "Masala Idli",
      "time": "30-40 min",
      "discount": "Flat ₹120 OFF above ₹299",
    },
    {
      "image": "assets/images/upma.jpg",
      "title": "Upma",
      "subtitle": "Testy and healthy",
      "time": "25-35 min",
      "discount": "Flat ₹140 OFF above ₹299",
    },
  ];

  final rowsData = [
    [
      {
        "image": "assets/images/pizza.jpg",
        "title": "Domino's Pizza",
        "timing": "12-15mins",
      },
      {
        "image": "assets/images/burger.jpg",
        "title": "7Eleven",
        "timing": "20-25mins",
      },
      {
        "image": "assets/images/salad.jpg",
        "title": "Salad",
        "timing": "30-40mins",
      },
    ],
    [
      {
        "image": "assets/images/salad.jpg",
        "title": "Salad",
        "timing": "40-45mins",
      },
      {
        "image": "assets/images/pizza.jpg",
        "title": "Pizza",
        "timing": "12-15mins",
      },
      {
        "image": "assets/images/burger.jpg",
        "title": "Burger",
        "timing": "45-50mins",
      },
    ],
  ];

  // filter data
  final List<String> filters = [
    "Filters",
    "Near & Fast",
    "Gourmet",
    "Great offers",
    "Pure Veg",
  ];

  late final List<Map<String, String>> categories = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _loadCartCount();
    // categoryBloc = CategoryBloc(repository: CategoriesRepository())
    //   ..add(LoadCategories());


    checkAddressAndFetch();

    _scrollController = ScrollController();

    _scrollController.addListener(() {
      if (!_scrollController.hasClients) return;

      final offset = _scrollController.offset;

      final newProgress = (offset / 120).clamp(0.0, 1.0);

      if ((progress - newProgress).abs() > 0.01) {
        setState(() {
          progress = newProgress;
          print("Progress: $progress");
        });
      }
    });


    loadUserData();
  }


  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    String? imagePath = prefs.getString("profile_image");

    if (imagePath != null) {
      setState(() {
        _profileImage = File(imagePath);
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
       _getCurrentLocation();
    }
  }


  Future<void> _loadCartCount() async {
    int count = await CartService().getTotalCount();
    setState(() {
      cartCount = count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  expandedHeight: 300,
                  pinned: false,
                  floating: false,
                  backgroundColor: Colors.black,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Stack(
                      fit: StackFit.expand,
                      children: [
                        //Background slider
                        SliderPage(),

                        SafeArea(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 16,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LocationPage(),
                                            ),
                                          );
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                                SizedBox(width: 5),

                                                Text(
                                                  locationPlace,
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  ),
                                                ),

                                                SizedBox(width: 5),

                                                Icon(
                                                  Icons.keyboard_arrow_down,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ],
                                            ),

                                            Text(
                                              currentLocation,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 10),

                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
                                        'assets/images/district.jpg',
                                        fit: BoxFit.cover,
                                        width: 60,
                                        height: 35,
                                      ),
                                    ),

                                    SizedBox(width: 10),

                                    GestureDetector(
                                      onTap: () {},
                                      child: AppCircleIcon(
                                        imagePath: "assets/images/wallet.png",
                                        backgroundColor: Colors.white,
                                        iconSize: 20,
                                        padding: 4,
                                      ),
                                    ),

                                    SizedBox(width: 10),

                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => ProfilePage(),
                                          ),
                                        ).then((_) {
                                          loadUserData();
                                        });;
                                      },
                                      child: CircleAvatar(
                                        radius: 20,
                                        backgroundColor: Colors.blue[200],
                                        backgroundImage: _profileImage != null
                                            ? FileImage(_profileImage!)
                                            : null,
                                        child: _profileImage == null
                                            ? const Text(
                                          "P", // 👉 or dynamic text
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        )
                                            : null,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 12),

                                Row(
                                  children: [
                                    // Search bar
                                    Expanded(
                                      child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    SearchPage(),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 48,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              border: Border.all(
                                                color: Colors.grey.shade300,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.search,
                                                  color: Colors.grey,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  "Search restaurant",
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    VegToggle(
                                      onChanged: (isVeg) {
                                        print("Veg selected: $isVeg");
                                        setState(() {
                                          isVegOnly = isVeg;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Categories - Bloc
                // BlocBuilder<CategoryBloc, CategoryState>(
                //   builder: (context, state) {
                //     if (state is CategoryLoading) {
                //       return SliverToBoxAdapter(
                //         child: SizedBox(
                //           height: 100,
                //           child: Center(child: CircularProgressIndicator()),
                //         ),
                //       );
                //     }
                //
                //     if (state is CategoryLoaded) {
                //       return SliverPersistentHeader(
                //         pinned: true,
                //         delegate: CategoryScreen(
                //           state.categories
                //               .map((e) => {"name": e.name, "image": e.image})
                //               .toList()
                //         ),
                //       );
                //     }
                //
                //     if (state is CategoryError) {
                //       return SliverToBoxAdapter(child: Text(state.message));
                //     }
                //
                //     return const SliverToBoxAdapter(child: SizedBox());
                //   },
                // ),

      SliverToBoxAdapter(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [

              /// 🔹 IMAGE (fixed width)
              SizedBox(
                width: 60,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    'assets/explore_offer.png',
                    height: 80,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(width: 12),

              /// 🔹 CATEGORY (takes full remaining width)
              Expanded(
                child: SizedBox(
                  height: 80,
                  child: CategoryRiverpodScreen(
                      isVeg: isVegOnly,
                    onCategoryTap: (category, index) {
                      context.read<RestaurantBloc>().add(
                        FetchFoodByCategory(category),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Row(
                      children: filters.map((filter) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              if (filters[0] == filter) {
                                showModalBottomSheet(
                                  context: context,
                                  builder: (context) => FilterBottomSheet(),
                                );
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(color: Colors.grey.shade300),
                              ),
                              child: Text(
                                filter,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8.0,
                    ),
                    child: Text(
                      "RECOMMENDED FOR YOU",
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Column(
                      children: List.generate(rowsData.length, (rowIndex) {
                        final row = rowsData[rowIndex];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            children: row.map((item) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: SizedBox(
                                  width: 140, // FIX width
                                  child: GestureDetector(
                                    onTap: () {

                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetailPage(
                                            title: "a",        // ✅ named
                                            restaurantId: 1,             // ✅ named
                                          ),
                                        ),
                                      );
                                      },
                                    child: RestaurantCard(
                                    image: item["image"] ?? "",
                                    discount: item["discount"] ?? "50% OFF",
                                    name: item["title"] ?? "",
                                    rating: item["rating"] ?? "4.5",
                                    time: item["timing"] ?? "",
                                    category: item["category"] ?? "",
                                  )
                                  )
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                    ),
                  ),
                ),


                BlocBuilder<ExploreBloc, ExploreState>(
                  builder: (context, state) {
                    if (state is ExploreLoading) {
                      return SliverToBoxAdapter(
                        child: SizedBox(
                          height: 100,
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      );
                    }

                    if (state is ExploreLoaded) {
                      return SliverPersistentHeader(
                        pinned: true,
                        delegate: ExploreMoreScreen(
                          state.explore
                              .map(
                                (e) => {
                                  "title": e.title ?? "",
                                  "image": e.image ?? "",
                                },
                              )
                              .toList(),
                        ),
                      );
                    }

                    if (state is ExploreError) {
                      return SliverToBoxAdapter(child: Text(state.message));
                    }

                    return const SliverToBoxAdapter(child: SizedBox());
                  },
                ),

                // SliverToBoxAdapter(
                //   child: SizedBox(
                //     height: 100,
                //     child: Center(child: ExploreRiverpodScreen()),
                //   ),
                // ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12.0,
                      top: 16.0),
                    child: Text(
                      "12 Restaurants Delivering to you",
                      style: TextStyle(color: Colors.grey[600], fontSize: 16),
                    ),
                  ),
                ),

                BlocBuilder<RestaurantBloc, RestaurantBlocState>(
                  builder: (context, state) {
                    if (state is RestaurantBlocLoading) {
                      return const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (state is RestaurantBlocLoaded) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final item = state.food[index];

                          return RestaurantListItem(
                            item: {
                              "image": item.image,
                              "title": ?item.title,
                              "time": item.time,
                              "rating": "4",
                              "price":item.price.toString(),
                            },
                            onTap: () {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductDetailPage(
                                    title: item.title ?? "",
                                    restaurantId: item.id ??1
                                  ),
                                ),
                              );
                            },
                          );
                        }, childCount: state.food.length),
                      );
                    }

                    if (state is RestaurantBlocError) {
                      return SliverToBoxAdapter(child: Text(state.message));
                    }

                    return const SliverToBoxAdapter(child: SizedBox());
                  },
                ),
                SliverToBoxAdapter(child: SizedBox(height: 120)),
              ],
            ),

            Positioned(
              bottom: 24,
              left: 4,
              right: 0,

              child: Bottomsheetscrollui(progress: progress),
            )
          ],
        ),
      );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // 1. Check if location service is ON
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        currentLocation = "Please enable location services";
      });

      await Geolocator.openLocationSettings();
      return;
    }

    // 2. Check permission
    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
          builder: (_) => LocationBottomSheet(
            onPermissionGranted: _getCurrentLocation,
            onLocationSelected: (selectedAddress) {
              setState(() {
                currentLocation = selectedAddress;
              });
            },
      ));
    }

    // 3. Permanently denied (system dialog won't show again)
    if (permission == LocationPermission.deniedForever) {
      setState(() {
        currentLocation = "Permission permanently denied. Enable from settings.";
      });

      await Geolocator.openAppSettings();
      return;
    }

    // 4. Get location
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks.first;

    String address = [
      place.name,
      place.subThoroughfare,
      place.thoroughfare,
      place.subLocality,
      place.locality,
      place.administrativeArea,
      place.postalCode,
      place.country,
    ].where((e) => e != null && e!.trim().isNotEmpty).join(', ');

    UserLocation location = UserLocation(latitude: position.latitude, longitude:  position.longitude, address:  address, area: place.locality ?? "");
    await DBHelper.instance.insertLocation(location);

    setState(() {
      currentLocation = address;
    });

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("address", address);

  }

  Future<void> checkAddressAndFetch() async {
    final prefs = await SharedPreferences.getInstance();

    String address = prefs.getString("address") ?? "";

      _getCurrentLocation();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

