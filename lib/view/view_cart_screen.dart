import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '/Widgets/DeliveryInfoRow.dart';
import '../Widgets/QuantityBox.dart';
import '../database/CartService.dart';

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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Back arrow
            Icon(Icons.arrow_back, color: Colors.black),

            // name + address
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      cartItems[0]["restaurant"] as String,
                      style: TextStyle(color: Colors.grey[600], fontSize: 10),
                    ),
                  ],
                ),
                Row(
                  children: const [
                    Text(
                      "55-69 mins, Home",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Text(
                      "| 103,sai Building",
                      style: TextStyle(color: Colors.black, fontSize: 12),
                    ),
                    Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                  ],
                ),
              ],
            ),
            // Share Icon
            Icon(Icons.ios_share, color: Colors.grey[500]),
          ],
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.blue[100],
            child: Text(
              "You saved ₹46 on this order",
              style: TextStyle(
                color: Color(0xD52F68DA),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Special offer
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [Color(0xFCFFE4BC), Color(0xFFFFF3E0)],
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
                        const Text(
                          "Special offer for you",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: const [
                            Icon(Icons.local_offer, color: Colors.orange),
                            SizedBox(width: 4),
                            Text(
                              "Get Free Dessert on orders above ₹299",
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          child: const Text(
                            "Free",
                            style: TextStyle(
                              fontSize: 12,
                              color: CupertinoColors.activeBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Right: Gift Box
                  const Icon(
                    Icons.card_giftcard,
                    color: Colors.orange,
                    size: 40,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),


          // Order details
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // Veg / Non-veg logo
                          Container(
                            width: 16,
                            height: 16,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green, // Veg
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Margherita Pizza [6 Pieces]",
                            style: TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ],
                      ),
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
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Edit",
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      const Text(
                        "₹250",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "+ Add more items",
                      style: TextStyle(fontSize: 12, color: Color(0xFFE23744)),
                    ),
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
          const SizedBox(height: 16),

          // Delivery details
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),

              child: Column(
                children: const [
                  // Single line row
                  DeliveryInfoRow(
                    icon: Icons.access_time,
                    text: "Delivery in 55-69 min",
                    subpart: true,
                    subText: "Want this later? Schedule it"
                  ),

                  SizedBox(height: 8),
                  Divider(color: Colors.white70,height: 1),
                  SizedBox(height: 8),

                  // Row with subpart
                  DeliveryInfoRow(
                    icon: Icons.location_on,
                    text: "Delivery at home",
                    subpart: true,
                    subText: "123, Main Street, City",
                  ),

                  SizedBox(height: 8),
                  Divider(color: Colors.white70,height: 1),
                  SizedBox(height: 8),


                  DeliveryInfoRow(
                    icon: Icons.call,
                    text: "Priyanka Satim, +67899896734",
                    subpart: false,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),


          // // Row 8 - Charity section
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
          //       const Text("Donate to Feeding India"),
          //       const SizedBox(height: 8),
          //       Row(
          //         children: [
          //           Expanded(
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
          // const SizedBox(height: 16),

          // Cancellation policy
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Cancellation Policy",
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),
                ),
                SizedBox(height: 4),
                Text("You can cancel within 15 minutes of placing the order.",
                  style: TextStyle(fontSize:8,color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
      // bottomSheet: Container(
      //   padding: const EdgeInsets.all(12),
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       // Zomato Money
      //       Container(
      //         padding: const EdgeInsets.all(12),
      //         decoration: BoxDecoration(
      //           border: Border.all(color: Colors.grey.shade300),
      //           borderRadius: BorderRadius.circular(12),
      //         ),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: const [
      //             Icon(Icons.wallet),
      //             Column(children: [
      //               Text("Zomato Money"),
      //               Text("Single top payments, Zero failures"),
      //             ],),
      //             Icon(Icons.arrow_forward),
      //           ],
      //         ),
      //       ),
      //       const SizedBox(height: 16),
      //
      //       // Payment options
      //       Container(
      //         padding: const EdgeInsets.all(12),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             const Text(
      //               "Pay Using",
      //               style: TextStyle(fontSize: 12),
      //             ),
      //             const SizedBox(height: 2),
      //             Row(
      //               children: const [
      //                 Icon(Icons.money),
      //                 SizedBox(width: 8),
      //                 Text("Pay on Delivery",
      //                   style: TextStyle(fontSize: 10,fontWeight: FontWeight.bold)),
      //               ],
      //             ),
      //             const SizedBox(height: 4),
      //             Text("UPI / Cash", style: TextStyle(fontSize: 8)),
      //             const SizedBox(height: 16),
      //             Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //               children: [
      //                 const Text("Total: ₹123"),
      //                 ElevatedButton.icon(
      //                   onPressed: () {},
      //                   icon: const Icon(Icons.shopping_cart_checkout),
      //                   label: const Text("Place Order"),
      //                   style: ElevatedButton.styleFrom(
      //                     backgroundColor: Colors.orange,
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ],
      //         ),
      //       ),
      //       const SizedBox(height: 16),
      //     ],
      //   ),
      // ),
    );
  }

  Future<void> loadCart() async {
    List<Map<String, dynamic>> items = await CartService().getCartItems();
    setState(() {
      cartItems = items;
    });
  }
}
