import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget option(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    margin: const EdgeInsets.only(right: 10, bottom: 10),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: Colors.grey.shade300),
    ),
    child: Text(text,style: TextStyle(fontSize: 10)),
  );
}
