import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MapAutoCompletePage extends StatefulWidget {
  const MapAutoCompletePage({super.key});

  @override
  State<MapAutoCompletePage> createState() => _MapAutoCompletePageState();
}

class _MapAutoCompletePageState extends State<MapAutoCompletePage> {
  GoogleMapController? mapController;

  final LatLng initialPosition = const LatLng(19.1176, 72.9060);

  LatLng? selectedLatLng;
  String selectedAddress = "Search location";

  final TextEditingController controller = TextEditingController();

  final String apiKey =
      "AIzaSyDxWdMcfTOLNuaYuJh7GmWuSisrjx2jV1Q";

  String name = "";
  String mobile = "";


  @override
  void initState() {
    loadUserData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: initialPosition,
              zoom: 14,
            ),
            onMapCreated: (c) => mapController = c,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,

            onTap: (LatLng position) async {
              FocusScope.of(context).unfocus(); // close search

              setState(() {
                selectedLatLng = position;
                selectedAddress = "Loading...";
              });

              String address = await getAddressFromLatLng(
                  position.latitude, position.longitude);

              setState(() {
                selectedAddress = address;
              });

              mapController?.animateCamera(CameraUpdate.newLatLng(position));
            },

            markers: selectedLatLng == null
                ? {}
                : {
                    Marker(
                      markerId: const MarkerId("selected"),
                      position: selectedLatLng!,
                    ),
                  },
          ),

          /// SEARCH BAR
          Positioned(
            top: 50,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: GooglePlaceAutoCompleteTextField(
                containerHorizontalPadding: 0,
                textEditingController: controller,
                googleAPIKey: apiKey,

                inputDecoration: InputDecoration(
                  hintText: "Search location...",
                  fillColor: Colors.white,
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search),
                ),

                debounceTime: 800,
                countries: ["in"],

                isLatLngRequired: true,

                /// When user selects place
                getPlaceDetailWithLatLng: (prediction) {
                  final lat = double.parse(prediction.lat!);
                  final lng = double.parse(prediction.lng!);

                  setState(() {
                    selectedLatLng = LatLng(lat, lng);
                    selectedAddress = prediction.description!;
                  });

                  mapController?.animateCamera(
                    CameraUpdate.newLatLng(selectedLatLng!),
                  );
                },

                /// When user taps suggestion
                itemClick: (prediction) {
                  controller.text = prediction.description!;
                  controller.selection = TextSelection.fromPosition(
                    TextPosition(offset: prediction.description!.length),
                  );
                },
              ),
            ),
          ),

          /// BOTTOM ADDRESS CARD
          Positioned(
            bottom: 20,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery details",
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 12),

                  /// ADDRESS CARD
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on, color: Colors.red),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            selectedAddress,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, size: 14),
                      ],
                    ),
                  ),

                  const SizedBox(height: 6),
                  const Text(
                    "E.g. Floor, House no.",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),

                  const SizedBox(height: 16),

                  const Text(
                    "Receiver details for this address",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),

                  const SizedBox(height: 10),

                  _textField("Name",name),
                  const SizedBox(height: 10),
                  _textField("Phone number",mobile),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: () {
                      print("Save address tapped");

                      // 👉 your logic here
                      saveAddress();
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Center(
                        child: Text(
                          "Save address",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
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
    );
  }

  Widget _textField(String hint,String value) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text((value != null && value.isNotEmpty) ? value : hint, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }


  Future<String> getAddressFromLatLng(double lat, double lng) async {
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(lat, lng);

      Placemark place = placemarks.first;
      String address = formatAddress(place);

      return address;
    } catch (e) {
      print("Error: $e");
      return "Unable to get address";
    }
  }

  String formatAddress(Placemark place) {
    return [
      place.name,
      place.street,
      place.subLocality,
      place.locality,
      place.administrativeArea,
      place.postalCode,
      place.country
    ]
        .where((e) => e != null && e!.isNotEmpty)
        .join(", ");
  }

  Future<void> loadUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      name = prefs.getString("name") ?? "";
      mobile = prefs.getString("mobile") ?? "";
      selectedAddress = prefs.getString("address") ?? "";
    });
  }

  Future<void> saveAddress() async {
    final prefs = await SharedPreferences.getInstance();

    prefs.setString("address", selectedAddress);

    Fluttertoast.showToast(
      msg: "Address saved successfully",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 14.0,
    );

    Navigator.pop(context);
  }
}
