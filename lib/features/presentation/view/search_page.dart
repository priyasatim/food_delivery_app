import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final List<Map<String, String>> items = [
    {"title": "Burger", "image": "assets/images/burger.png"},
    {"title": "Cake", "image": "assets/images/cake.png"},
    {"title": "Pizza", "image": "assets/images/pizza.png"},
    {"title": "Chicken", "image": "assets/images/chicken.png"},
    {"title": "Waffle", "image": "assets/images/waffle.png"},
    // add more items
  ];

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final filteredItems = items
        .where(
          (item) =>
              item["title"]!.toLowerCase().contains(searchQuery.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      appBar: AppBar(title: Text("Search")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            // Search TextField
           Padding(
                padding: EdgeInsets.all(16),
                child: Container(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: Color(0xFFE23744)),
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey),

                      border: InputBorder.none,
                    ),
                      onChanged: (value) {
                      setState(() {
                        searchQuery = value;
                      });
                      }
                  ),
                ),
              ),

            SizedBox(height: 8),

      Padding(
        padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child:   Text(
                "WHAT'S ON YOUR MIND?",
                style: TextStyle(fontSize:12,color: Colors.grey[500]),
                textAlign: TextAlign.left,
              ),
            ),
      ),
            // GridView of filtered items
            Expanded(
              child: GridView.builder(
                itemCount: filteredItems.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // two items per row
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  final item = filteredItems[index];
                  return  Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Image.asset(
                          item["image"]!,
                          fit: BoxFit.contain,
                          width: 80,
                          height: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            item["title"]!,
                            style: TextStyle(fontSize:12,fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
