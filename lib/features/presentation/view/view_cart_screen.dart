import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/common/app_colors.dart';
import '../../data/database/CartService.dart';
import '../Widgets/app_text_link.dart';
import '../Widgets/delivery_info_row.dart';
import '../Widgets/payment_screen.dart';
import '../Widgets/quantity_box.dart';

class ViewCartPage extends StatefulWidget {
  @override
  _ViewCartPageState createState() => _ViewCartPageState();
}

class _ViewCartPageState extends State<ViewCartPage> {
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();
    loadCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Back arrow
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),

            // name + address
            Expanded(child: Padding(padding: EdgeInsets.symmetric(horizontal: 12), child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      "Burger",
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "55-69 mins, ",
                      style: TextStyle(
                        color: Colors.green[500],
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const Text(
                      "to Home",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "| 103,sai Building",
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  ],
                ),
              ],
            ))),
            // Share Icon
            Image.asset(
              "assets/images/share.png",
              color: Colors.grey[800],
              height: 20,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          /// SCROLLABLE CONTENT
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 16),
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 14,
                    horizontal: 14,
                  ),
                  color: Color(0xD5DEE5F3),
                  child: Text(
                    "You saved ₹46 on this order",
                    style: TextStyle(
                      color: Color(0xD52C6EF1),
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Special offer
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: const LinearGradient(
                        colors: [Color(0xFCFFE4BC), Color(0xFFFFFFFF)],
                        // light orange gradient
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Left: Logo + details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Special offer for you",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Image.asset(
                                    "assets/images/gift.png",
                                    height: 30,
                                  ),
                                ],
                              ),

                              const SizedBox(height: 8),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 24,
                                    backgroundColor: Colors.grey[300],
                                    backgroundImage: AssetImage(
                                      "assets/images/OTTPlay.png",
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        /// 🔹 LEFT COLUMN (Texts)
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Get 30+ OTTs at 140!",
                                                style: const TextStyle(
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Text(
                                                "Claim voucher after order is placed",
                                                style: const TextStyle(
                                                  fontSize: 11,
                                                  color: CupertinoColors
                                                      .activeBlue,
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(width: 8),

                                        /// RIGHT COLUMN (Chip + Free)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 6,
                                                    vertical: 6,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Text(
                                                    "ADDED",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      height: 1,
                                                      color:
                                                          AppColors.textPrimary,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 2),
                                                  Icon(
                                                    Icons.close,
                                                    size: 10,
                                                    color:
                                                        AppColors.textPrimary,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 6),

                                            const Text(
                                              "FREE",
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    CupertinoColors.activeBlue,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Order details
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /// LEFT SIDE (name + icon)
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/veg.jpg",
                                    height: 15,
                                    width: 15,
                                  ),

                                  SizedBox(width: 6),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Margherita Pizza [6 Pieces]",
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: 2),
                                      Text(
                                        "NOT ELIGIBLE FOR COUPON",
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            /// RIGHT SIDE (quantity)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                QuantityBox(
                                  initialCount: 1,
                                  onChanged: (value) async {
                                    if (value == 0) {
                                      await CartService().removeProduct("1");
                                    } else {
                                      await CartService().addProduct(
                                        id: "1",
                                        name: "Margherita Pizza [6 Pieces]",
                                        price: 123,
                                        restaurant: "restaurant",
                                        location: "Mumbai",
                                      );
                                    }
                                  },
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "₹250",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        AppTextLink(
                          text: "+ Add more items",
                          onTap: () {
                            print("Clicked");
                          },
                        ),
                        const SizedBox(height: 4),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              // Note 1
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(0xFFE0E0E0),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.sticky_note_2_outlined,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      "Add a note for restaurant",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(width: 4),

                              // Note 2
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Color(0xFFE0E0E0),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.sticky_note_2_outlined,
                                      size: 18,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(width: 6),
                                    const Text(
                                      "Do not send cutlery",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.black45,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Delivery details
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),

                    child: Column(
                      children: [
                        // Single line row
                        DeliveryInfoRow(
                          icon: Icons.access_time,
                          text: "Delivery in 55-69 min",
                          subpart: true,
                          subText: "Want this later? Schedule it",
                        ),

                        SizedBox(height: 12),
                        Divider(color: Colors.grey.shade300, height: 0.2),
                        SizedBox(height: 12),

                        // Row with subpart
                        DeliveryInfoRow(
                          icon: Icons.location_on,
                          text: "Delivery at home",
                          subpart: true,
                          subText: "123, Main Street, City",
                        ),

                        SizedBox(height: 12),
                        Divider(color: Colors.grey.shade300, height: 0.2),
                        SizedBox(height: 12),

                        DeliveryInfoRow(
                          icon: Icons.call,
                          text: "Priyanka Satim, +67899896734",
                          subpart: false,
                        ),
                      ],
                    ),
                  ),
                ),

                // Row 8 - Charity section
                // Container(
                //   padding: const EdgeInsets.all(12),
                //   decoration: BoxDecoration(
                //     border: Border.all(color: Colors.grey.shade300),
                //     borderRadius: BorderRadius.circular(12),
                //   ),
                //   child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: const [
                //           Text("Let's serve a brighter future"),
                //           Icon(Icons.child_care, color: Colors.orange),
                //         ],
                //       ),
                //       const SizedBox(height: 8),
                //       const SizedBox(height: 8),
                //       Row(
                //         children: [
                //           Expanded(
                //           child: Text("Donate to Feeding India")
                //           ),
                //           Flexible(
                //             child: TextField(
                //               decoration: InputDecoration(
                //                 border: OutlineInputBorder(),
                //                 hintText: "₹2",
                //               ),
                //             ),
                //           ),
                //           const SizedBox(width: 8),
                //           ElevatedButton(onPressed: () {}, child: const Text("Add")),
                //         ],
                //       ),
                //     ],
                //   ),
                // ),

                // Cancellation policy
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Cancellation Policy",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "You can cancel within 15 minutes of placing the order.",
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          PaymentBottomSheet(),
        ],
      ),
    );
  }

  Future<void> loadCart() async {
    List<Map<String, dynamic>> items = await CartService().getCartItems();
    setState(() {
      cartItems = items;
    });
  }
}
