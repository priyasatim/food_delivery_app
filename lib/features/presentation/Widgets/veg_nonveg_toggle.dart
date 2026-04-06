
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VegToggle extends StatefulWidget {
  final Function(bool)? onChanged;

  const VegToggle({super.key, this.onChanged});

  @override
  State<VegToggle> createState() => _VegToggleState();
}

class _VegToggleState extends State<VegToggle> {
  bool isVegEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: 4),child: Column(
      children: [
        const Text(
          "VEG",
          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 12,color: Colors.white),
        ),
        const SizedBox(width: 6),

        GestureDetector(
          onTap: () {
            setState(() {
              isVegEnabled = !isVegEnabled;
            });

            // Show dialog when ON
            if (isVegEnabled) {
              showVegDialog(context, widget.onChanged,isVegEnabled);
            } else {
              widget.onChanged?.call(false);
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 42,
            height: 22,
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isVegEnabled
                  ? Colors.green
                  : Colors.grey.shade300,
            ),
            child: Align(
              alignment: isVegEnabled
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}

void showVegDialog(BuildContext context,  Function(bool)? onChanged,bool isVeg) {
  String selectedOption = "all";

  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setStateDialog) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "See veg dishes from",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // Option 1
                  RadioListTile(
                    value: "all",
                    groupValue: selectedOption,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setStateDialog(() {
                        selectedOption = value!;
                      });
                    },
                    title: const Text("All restaurants"),
                    contentPadding: EdgeInsets.zero,
                  ),

                  // Option 2
                  RadioListTile(
                    value: "pureVeg",
                    groupValue: selectedOption,
                    activeColor: Colors.green,
                    onChanged: (value) {
                      setStateDialog(() {
                        selectedOption = value!;
                      });
                    },
                    title: const Text("Pure Veg restaurants only"),
                    contentPadding: EdgeInsets.zero,
                  ),

                  const SizedBox(height: 10),

                  // Apply Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);

                        onChanged?.call(isVeg);

                        print("Selected: $selectedOption");
                      },
                      child: const Text("Apply"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "More settings",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
