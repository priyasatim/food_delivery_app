import 'package:flutter/material.dart';
import 'package:zomato_app/view/edit_profile_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String userName = "Priyanka";
  String mobile = "";
  String dob = "";
  String gender = "";

  final List<Map<String, dynamic>> menuItems = [
    {
      "icon": Icons.circle, // Use asset instead of icon
      "title": "Veg Mode",
    },
    {"icon": Icons.star, "title": "Show personalised ratings"},
    {"icon": Icons.star, "title": "Appearance"},
    {"icon": Icons.payment, "title": "Payment Methods"},
  ];

  final List<Map<String, dynamic>> food_delivery = [
    {"icon": Icons.person, "title": "Your orders"},
    {"icon": Icons.person, "title": "Address book"},
    {"icon": Icons.person, "title": "Your collections"},
  ];

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // User info card
          Padding(
            padding: const EdgeInsets.all(16.0), // <-- this is your margin
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
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 8),
                        Text("Zomato Money", style: TextStyle(fontSize: 12)),
                        SizedBox(height: 4),
                        Text(
                          "₹120", // amount
                          style: TextStyle(fontSize: 12, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(width: 12), // spacing between cards
              // Card 2
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(height: 8),
                        Text("Your coupons", style: TextStyle(fontSize: 12)),
                        SizedBox(height: 4),
                        Text(
                          "5", // number of orders
                          style: TextStyle(fontSize: 12, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Your Preferences
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsetsGeometry.all(12),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Container(width: 3, height: 30, color: Colors.green),

                        SizedBox(width: 8),

                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Your Preferences",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),

                    Divider(height: 1, color: Colors.grey[300]),

                    Column(
                      children: [
                        ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: menuItems.length,
                          separatorBuilder: (context, index) =>
                              Divider(height: 1, color: Colors.grey[300]),
                          itemBuilder: (context, index) {
                            final item = menuItems[index];
                            return ListTile(
                              leading: Icon(item["icon"]),
                              title: Text(
                                item["title"],
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.black,
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios, size: 16),
                              onTap: () {
                                print("Tapped ${item['title']}");
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
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
}
