import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationBottomSheet extends StatefulWidget {
  final VoidCallback onPermissionGranted;
  final Function(String address) onLocationSelected;

  const LocationBottomSheet({
    super.key,
    required this.onPermissionGranted,
    required this.onLocationSelected
  });

  @override
  State<LocationBottomSheet> createState() => _LocationBottomSheetState();
}

class _LocationBottomSheetState extends State<LocationBottomSheet> {

  String savedAddress = "Loading...";
  bool isLoading = false;
  bool isPermissionGranted = false;

  @override
  void initState() {
    super.initState();
    loadAddress();
  }

  Future<void> loadAddress() async {
    final prefs = await SharedPreferences.getInstance();
    String? address = prefs.getString("address");

    setState(() {
      savedAddress = address ?? "No saved address";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          /// CLOSE BUTTON
          Center(
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.close),
              ),
            ),
          ),

          const SizedBox(height: 16),

          /// LOCATION PERMISSION CARD
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_off, color: Colors.red, size: 30),
                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Location permission is off",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Enable your location permission for a better experience",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    LocationPermission permission = await Geolocator.requestPermission();

                    // ❌ Denied
                    if (permission == LocationPermission.denied) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Location permission denied")),
                      );
                      return;
                    }

                    // ❌ Denied Forever
                    if (permission == LocationPermission.deniedForever) {
                      await Geolocator.openAppSettings();

                      return;
                    }

                    // ✅ Permission Granted
                    if (permission == LocationPermission.always ||
                        permission == LocationPermission.whileInUse) {

                      Navigator.pop(context); // close bottom sheet

                      widget.onPermissionGranted();
                    }
                  },
                  child: const Text("Enable",style: TextStyle(color: Colors.white)),
                )
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Select a saved address",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              // Text(
              //   "See all",
              //   style: TextStyle(
              //     color: Colors.red,
              //     fontWeight: FontWeight.w600,
              //   ),
              // ),
            ],
          ),

          const SizedBox(height: 12),

          /// ✅ DYNAMIC ADDRESS
          _addressTile(
            title: "Current Location",
            subtitle: savedAddress,
          ),

          const SizedBox(height: 16),

          /// SEARCH FIELD
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.search),
                hintText: "Search location manually",
                border: InputBorder.none,
              ),
            ),
          ),

          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _addressTile({
    required String title,
    required String subtitle,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // close bottom sheet

        widget.onLocationSelected(subtitle); // 🔥 send selected address
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.home_outlined),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}