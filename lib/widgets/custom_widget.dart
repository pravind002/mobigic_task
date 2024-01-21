import 'package:flutter/material.dart';

Container customButton(String buttonName) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
        color: Colors.greenAccent, borderRadius: BorderRadius.circular(10)),
    child: Center(
        child: Text(
      buttonName,
      style: const TextStyle(
          fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
    )),
  );
}
