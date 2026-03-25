import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'select_delivery_location.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  _LocationPageState createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  String currentLocation = "Fetching location...";
  String searchQuery = "";

  final List<Map<String, String>> savedAddresses = [
    {
      "title": "Home",
      "address": "Flat 101, Sai Residency, Andheri East, Mumbai",
    },
    {"title": "Work", "address": "Tech Park, Powai, Mumbai"},
  ];

  final List<Map<String, String>> nearByLocation = [
    {
      "title": "Prathmesh Apartment",
      "address": "Flat 101, Sai Residency, Andheri East, Mumbai",
    },
    {
      "title": "Tata Consultancy Services",
      "address": "Tech Park, Powai, Mumbai",
    },
  ];

  final List<Map<String, String>> recentLocation = [
    {"title": "Home", "address": "Sai Residency, Andheri East, Mumbai"},
    {"title": "Work", "address": "Tech Park, Powai, Mumbai"},
  ];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        title: Text("Select Location"),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: EdgeInsets.all(16),
            child: Container(
              height: 45,
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),

              child: Row(
                children: [
                  Icon(Icons.search, color: Color(0xFFE23744)),
                  SizedBox(width: 8),
                  Text(
                    "Search for area, street...",
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  currentLocationWidget(),

                  // Saved Addresses Title
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "SAVED ADDRESSES",
                        style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                      ),
                    ),
                  ),

                  // Saved Address List
                  ListView.builder(
                    itemCount: savedAddresses.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final item = savedAddresses[index];

                      return Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 6,
                        ),
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // LEFT: Icon + KM
                            Column(
                              children: [
                                Icon(Icons.home_outlined, color: Colors.grey),

                                SizedBox(height: 4),

                                Text(
                                  "2.5 km",
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),

                            SizedBox(width: 12),

                            // Title + Address
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item["title"]!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),

                                  SizedBox(height: 4),

                                  Text(
                                    item["address"]!,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 12,
                                    ),
                                  ),

                                  SizedBox(height: 4),

                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape
                                              .circle,
                                        ),
                                        child: Image.asset(
                                          'assets/images/dots.png',
                                          width: 18,
                                          height: 18,
                                          color: Color(
                                            0xFFE23744,
                                          ), // icon color
                                        ),
                                      ),

                                      Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape
                                              .circle,
                                        ),
                                        child: Image.asset(
                                          'assets/images/share.png',
                                          width: 18,
                                          height: 18,
                                          color: Color(
                                            0xFFE23744,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  // Nearby Location Title
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "NEARBY LOCATIONS",
                        style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                      ),
                    ),
                  ),

                  // Near By Location List
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.separated(
                      itemCount: nearByLocation.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),

                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.grey.shade200,
                      ),

                      itemBuilder: (context, index) {
                        final item = nearByLocation[index];

                        return Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Icon + KM
                              Column(
                                children: [
                                  Icon(Icons.home_outlined, color: Colors.grey),
                                  SizedBox(height: 4),
                                  Text(
                                    "2.5 km",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(width: 12),

                              // Title + Address
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["title"]!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),

                                    SizedBox(height: 4),

                                    Text(
                                      item["address"]!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  // Recent Location Title
                  Padding(
                    padding: EdgeInsets.only(left: 16,right: 16,top: 16,bottom: 8),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "RECENT LOCATIONS",
                        style: TextStyle(fontSize: 16, color: Colors.grey[500]),
                      ),
                    ),
                  ),

                  // RECENT Location List
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    padding: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListView.separated(
                      itemCount: recentLocation.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),

                      separatorBuilder: (context, index) => Divider(
                        height: 1,
                        color: Colors.grey.shade200,
                      ),

                      itemBuilder: (context, index) {
                        final item = recentLocation[index];

                        return Padding(
                          padding: EdgeInsets.all(12),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // LEFT: Icon + KM
                              Column(
                                children: [
                                  Icon(Icons.home_outlined, color: Colors.grey),
                                  SizedBox(height: 4),
                                  Text(
                                    "2.5 km",
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),

                              SizedBox(width: 12),

                              // RIGHT: Title + Address
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item["title"]!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                      ),
                                    ),

                                    SizedBox(height: 4),

                                    Text(
                                      item["address"]!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "powered by",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(width: 4),

                      Image.asset(
                        'assets/images/google.png',
                        height: 60,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget currentLocationWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              _getCurrentLocation();
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(color: Colors.transparent),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.my_location, color: Color(0xFFE23744)),

                  SizedBox(width: 12),

                  // text section
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Use Current Location",
                          style: TextStyle(
                            color: Color(0xFFE23744),
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        SizedBox(height: 4),

                        Text(
                          currentLocation,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          // handle long text
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.grey,
                    size: 20,
                  ),
                ],
              ),
            ),
          ),
          Divider(height: 0.5, color: Colors.grey[100]),
          // Add Address
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MapAutoCompletePage(),
                  ));
              },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add, color: Color(0xFFE23744)),
                      SizedBox(width: 10),
                      Text(
                        "Add Address",
                        style: TextStyle(
                          color: Color(0xFFE23744),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),
          ),
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
    print(position.latitude);
    print(position.longitude);


    Placemark place = placemarks[0];

    setState(() {
      currentLocation = [
        place.name,
        place.subThoroughfare,
        place.thoroughfare,
        place.subLocality,
        place.locality,
        place.administrativeArea,
        place.postalCode,
        place.country,
      ].where((e) => e != null && e!.trim().isNotEmpty).join(', ');
    });
  }
}
