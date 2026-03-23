import 'package:flutter/material.dart';

class QuantityBox extends StatefulWidget {
  final int initialCount;
  final Function(int)? onChanged;

  const QuantityBox({super.key, this.initialCount = 1, this.onChanged});

  @override
  State<QuantityBox> createState() => _QuantityBoxState();
}

class _QuantityBoxState extends State<QuantityBox> {
  late int count;

  @override
  void initState() {
    super.initState();
    count = widget.initialCount;
  }

  void _increment() {
    setState(() {
      count++;
    });
    widget.onChanged?.call(count);
  }

  void _decrement() {
    if (count > 0) {
      setState(() {
        count--;
      });
      widget.onChanged?.call(count);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red[50], // light red background
        border: Border.all(color: Colors.redAccent),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Minus button
          InkWell(
            onTap: _decrement,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3), // smaller padding
              child: const Icon(Icons.remove, color: Colors.redAccent,size: 18,),
            ),
          ),
          // Count
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              '$count',
              style: const TextStyle(
                  fontSize: 12, color: Colors.black),
            ),
          ),
          // Plus button
          InkWell(
            onTap: _increment,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3), // smaller padding
              child: const Icon(Icons.add, color: Colors.redAccent,size: 18),
            ),
          ),
        ],
      ),
    );
  }
}