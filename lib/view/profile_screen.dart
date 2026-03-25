import 'package:flutter/material.dart';
import 'package:zomato_app/utility/app_colors.dart';
import 'package:zomato_app/view/edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/app_circle_icon.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "Priyanka";
  String mobile = "";
  String dob = "";
  String gender = "";

  final List<Map<String, dynamic>> sections = [
    {
      "title": "Your Preferences",
      "items": [
        {"icon": null, "image": "assets/images/veg.jpg", "title": "Veg Mode"},
        {
          "icon": null,
          "image": "assets/images/star.png",
          "title": "Show personalised ratings",
        },
        {
          "icon": null,
          "image": "assets/images/appearance.png",
          "title": "Appearance",
        },
        {
          "icon": null,
          "image": "assets/images/credit-card.png",
          "title": "Payment Methods",
        },
      ],
    },
    {
      "title": "Food Delivery",
      "items": [
        {"icon": Icons.shopping_bag, "title": "Your orders"},
        {"icon": Icons.location_on, "title": "Address book"},
        {"icon": Icons.bookmark, "title": "Your collections"},
        {"icon": Icons.manage_accounts, "title": "Manage recommendations"},
        {"icon": Icons.train, "title": "Order on train"},
        {"icon": Icons.hide_source_outlined, "title": "Hidden Restaurants"},
        {"icon": Icons.house_outlined, "title": "Hear from Restaurants"},
      ],
    },
    {
      "title": "Dinning & experiences",
      "items": [
        {"icon": Icons.timer_outlined, "title": "Your dinning transactions"},
        {"icon": Icons.card_giftcard, "title": "Your dining rewards"},
        {"icon": Icons.dinner_dining, "title": "Your bookings"},
        {"icon": Icons.bookmark, "title": "Your collections"},
        {"icon": Icons.help_outline, "title": "Dinning help"},
        {"icon": Icons.card_giftcard, "title": "Claim invite code"},
      ],
    },

    {
      "title": "Gift cards & credits",
      "items": [
        {"icon": Icons.card_membership, "title": "Buy Gift Card"},
        {"icon": Icons.credit_card, "title": "Claim Gift Card"},
        {"icon": Icons.credit_card, "title": "Zomato Credits"},
      ],
    },
    {
      "title": "Zomato For Enterprise",
      "items": [
        {"icon": Icons.person, "title": "For employers"},
        {"icon": Icons.person, "title": "For employees"},
      ],
    },

    {
      "title": "Feeding India",
      "items": [
        {"icon": Icons.person, "title": "Your impact"},
        {"icon": Icons.sd_card, "title": "Get Feeding India receipt"},
      ],
    },

    {
      "title": "Membership & rewards",
      "items": [
        {"icon": Icons.airplanemode_active, "title": "Air India Maharaja Club"},
        {
          "icon": Icons.disabled_by_default_outlined,
          "title": "Redeem Gold coupon",
        },
      ],
    },

    {
      "title": "More",
      "items": [
        {"icon": Icons.thumb_up_alt_outlined, "title": "Your feedback"},
        {"icon": Icons.info_outline, "title": "About"},
        {"icon": Icons.edit_calendar, "title": "Send feedback"},
        {
          "icon": Icons.emergency_outlined,
          "title": "Report a safety emergency",
        },
        {"icon": Icons.person, "title": "Accessibility"},
        {"icon": Icons.settings, "title": "Settings"},
        {"icon": Icons.logout, "title": "Log out"},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // User info card
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              elevation: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 36,
                          backgroundColor: Colors.blue[200],
                          child: Text(
                            "P",
                            style: TextStyle(
                              color: Colors.blue[800],
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                            ),
                          ),
                        ),
                        SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              userName,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfilePage(userName: userName),
                                  ),
                                ).then((_) {
                                  getUserData();
                                });
                              },
                              child: Text(
                                "Edit Profile",
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 8),

                  // Full-width Zomato Gold (no padding)
                  Container(
                    width: double.infinity,
                    height: 48,
                    // fixed height instead of padding
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Join Zomato Gold",
                        style: TextStyle(
                          color: Colors.orange[200],
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8),

          Padding(padding: EdgeInsets.symmetric(horizontal: 12),child:
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Card 1
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(6.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppCircleIcon(
                              imagePath: "assets/images/wallet.png",
                              backgroundColor: Colors.grey.shade200,
                              iconSize: 15,
                              padding: 4,
                            ),
                            const SizedBox(width: 8),

                            // 👇 Text + Amount Column
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Zomato Money",
                                  style: TextStyle(fontSize: 12),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  "₹120",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: 6), // spacing between cards

              // Card 2
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            AppCircleIcon(
                              imagePath: "assets/filters/discount.png",
                              backgroundColor: Colors.grey.shade200,
                              iconSize: 15,
                              padding: 4,
                            ),
                            const SizedBox(width: 8),

                            // Text + Amount Column
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "Zomato Money",
                                  style: TextStyle(fontSize: 12),
                                ),

                                SizedBox(height: 4),

                                Text(
                                  "₹120",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        const SizedBox(height: 6),
                      ],
                    ),
                  ),
                ),
              ),

            ],
          )),
          SizedBox(height: 8),

          // Your Preferences
          Expanded(
            child: ListView.builder(
              itemCount: sections.length,
              itemBuilder: (context, index) {
                final section = sections[index];

                return buildSection(section["title"], section["items"]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      userName = prefs.getString("name") ?? "";
      mobile = prefs.getString("mobile") ?? "";
      dob = prefs.getString("dob") ?? "";
      gender = prefs.getString("gender") ?? "";
    });
  }

  Widget buildSection(String title, List items) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Card(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Row(
              children: [
                Container(width: 3, height: 30, color: AppColors.textPrimary),
                const SizedBox(width: 8),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),

            Divider(height: 1, color: Colors.grey[100]),

            // List Items
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              separatorBuilder: (_, __) =>
                  Divider(height: 1, color: Colors.grey[300]),
              itemBuilder: (context, index) {
                final item = items[index];

                return ListTile(
                  leading:
                      (item["image"] != null &&
                          item["image"].toString().isNotEmpty)
                      ? Image.asset(item["image"], width: 22, height: 22)
                      : Icon(item["icon"] ?? Icons.help_outline),

                  title: Text(
                    item["title"],
                    style: const TextStyle(fontSize: 13),
                  ),

                  trailing: const Icon(Icons.arrow_forward_ios, size: 14),

                  onTap: () {
                    print("Tapped ${item["title"]}");
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
