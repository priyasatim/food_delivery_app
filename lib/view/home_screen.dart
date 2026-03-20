import 'package:flutter/material.dart';
import 'package:zomato_app/Widgets/SliderPage.dart';
import 'package:zomato_app/view/explore_more.dart';
import 'package:zomato_app/view/category_screen.dart';
import 'package:zomato_app/view/product_details_screen.dart';
import 'package:zomato_app/view/profile_screen.dart';
import 'package:zomato_app/view/search_page.dart';
import 'package:zomato_app/view/view_cart_screen.dart';

import 'address_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String locationPlace = "Home";
  String currentLocation = "Fetching location...";
  List<ScrollController> _controllers = [];
  bool _isSyncing = false;


  final List<Map<String, String>> explore_more = [
    {"name": "Offers", "image": "assets/images/price_tag.png"},
    {"name": "Food on train", "image": "assets/images/train.jpg"},
  ];

  final List<Map<String, String>> categories = [
    {"name": "All", "image": "assets/images/all.png"},
    {"name": "Burger", "image": "assets/images/burger.png"},
    {"name": "Cake", "image": "assets/images/cake.png"},
    {"name": "Fries", "image": "assets/images/fries.png"},
    {"name": "Chicken", "image": "assets/images/chicken.png"},
    {"name": "Waffle", "image": "assets/images/waffle.png"},
  ];

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
  final List<String> sliderImages = [
    'assets/images/screen1.jpg',
    'assets/images/screen2.jpg',
  ];

  final rowsData = [
    [
      {"image": "assets/images/pizza.jpg", "title": "Domino's Pizza","timing":"12-15mins"},
      {"image": "assets/images/burger.jpg", "title": "7Eleven","timing":"20-25mins"},
      {"image": "assets/images/salad.jpg", "title": "Salad","timing":"30-40mins"},
    ],
    [
      {"image": "assets/images/salad.jpg", "title": "Salad","timing":"40-45mins"},
      {"image": "assets/images/pizza.jpg", "title": "Pizza","timing":"12-15mins"},
      {"image": "assets/images/burger.jpg", "title": "Burger","timing":"45-50mins"},
    ],
  ];



  @override
  void initState() {
    super.initState();

    _getCurrentLocation();

    _controllers = List.generate(rowsData.length, (_) => ScrollController());

    _setupScrollSync();

  }

  void _setupScrollSync() {
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        if (_isSyncing) return; // skip if we are syncing
        _isSyncing = true;

        double offset = _controllers[i].offset;
        for (int j = 0; j < _controllers.length; j++) {
          if (j != i && _controllers[j].hasClients) {
            // Smoothly animate the other rows
            _controllers[j].jumpTo(offset);
          }
        }

        _isSyncing = false;
      });
    }
  }

  @override
  void dispose() {
    _disposeScrollSync();
    super.dispose();
  }

  void _disposeScrollSync() {
    for (var controller in _controllers) {
      controller.dispose();
    }
  }

    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Stack(
        children: [
          CustomScrollView(
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
                            horizontal: 16,
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
                                                overflow: TextOverflow.ellipsis,
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

                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProfilePage(),
                                        ),
                                      );
                                    },
                                    child: CircleAvatar(
                                      radius: 20,
                                      backgroundColor: Colors.blue[200],
                                      child: Text(
                                        "P",
                                        style: TextStyle(
                                          color: Colors.blue[800],
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),

                                  ),
                                ],
                              ),

                              SizedBox(height: 12),

                              // Search bar
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SearchPage(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 48,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(Icons.search, color: Colors.grey),
                                        SizedBox(width: 8),
                                        Text(
                                          "Search food",
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Categories
              SliverPersistentHeader(
                pinned: true,
                delegate: CategoryScreen(categories),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    "RECOMMENDED FOR YOU",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
              ),

              // Dynamic horizontal rows
              for (int rowIndex = 0; rowIndex < rowsData.length; rowIndex++)
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 180, // increase height to fit image + text
                    child: ListView.builder(
                      controller: _controllers[rowIndex],
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      itemCount: rowsData[rowIndex].length,
                      itemBuilder: (context, index) {
                        final item =
                            rowsData[rowIndex][index];
                        return Container(
                          width: 140,
                          margin: EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 4,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              // Image
                              ClipRRect(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(12),
                                ),
                                child: Image.asset(
                                  item["image"]!,
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(height: 8),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    item["title"]!,
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    item["timing"]!,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.green
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

              // explore more
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Text(
                    "EXPLORE MORE",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
              ),

              SliverPersistentHeader(
                pinned: true,
                delegate: ExploreMoreScreen(explore_more),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 4.0,
                  ),
                  child: Text(
                    "12 Restaurants Delivering to you",
                    style: TextStyle(color: Colors.grey[600], fontSize: 16),
                  ),
                ),
              ),
              // Restaurant list
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {

                    final item = items[index];
                    return
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          child: InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProductDetailPage(item: item),
                                  ),
                                );
                              },
                     child:  Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.asset(
                              item["image"]!,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 4),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Text(
                              item["title"]!,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Text(
                              item["time"]!,
                              style: TextStyle(
                                color: Colors.grey[700],
                                fontSize: 10,
                              ),
                            ),
                          ),
                          SizedBox(height: 2),

                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12.0,
                            ),
                            child: Text(
                              item["discount"]!,
                              style: TextStyle(
                                color: Colors.grey[800],
                                fontSize: 10,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),

                          SizedBox(height: 12),
                        ],
                      ),
                    )));
                  },
                  childCount: items.length,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(height: 120),
              ),
            ],
          ),

          Positioned(
            bottom: 24,
            left: 16,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Clickable text to open ViewCartPage
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => ViewCartPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    child: Text(
                      "View Cart",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange, // highlight as clickable
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 8),

                // Existing bottom navigation row
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: const [
                            BoxShadow(
                                color: Colors.black26,
                                blurRadius: 10,
                                offset: Offset(0, 3))
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _bottomItem(Icons.home, "Home"),
                            _bottomItem(Icons.local_offer, "Under ₹250"),
                            _bottomItem(Icons.discount, "Offers"),
                            _bottomItem(Icons.restaurant, "Dining"),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Healthy Mode button
                    Container(
                      height: 50,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Colors.green[700],
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          bottomLeft: Radius.circular(25),
                        ),
                        boxShadow: const [
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 3)),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _bottomItem(Icons.monitor_heart, "Healthy Mode"),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        currentLocation = "Location services are disabled.";
      });
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          currentLocation = "Location permissions are denied";
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        currentLocation = "Location permissions are permanently denied.";
      });
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    List<Placemark> placemarks = await placemarkFromCoordinates(
      position.latitude,
      position.longitude,
    );

    Placemark place = placemarks[0];

    setState(() {
      currentLocation =
          [
                place.name,
                place.subThoroughfare,
                place.thoroughfare,
                place.subLocality,
                place.locality,
                place.administrativeArea,
                place.postalCode,
                place.country,
              ]
              .where(
                (e) => e != null && e!.trim().isNotEmpty,
              )
              .join(', ');
    });
  }

}

Widget _bottomItem(IconData icon, String label) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(icon, size: 20, color: Colors.grey[800]),
      const SizedBox(height: 2),
      Text(label, style: const TextStyle(fontSize: 8, color: Colors.black)),
    ],
  );
}

