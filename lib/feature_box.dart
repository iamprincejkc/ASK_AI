import 'package:ask_ai/pallete.dart';
import 'package:flutter/material.dart';

class FeatureBox extends StatelessWidget {
  final Color color;
  final String headearText;
  final String descriptionText;
  const FeatureBox(
      {super.key,
      required this.color,
      required this.headearText,
      required this.descriptionText});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headearText,
                style: const TextStyle(
                  fontFamily: Constants.mainFont,
                  color: Pallete.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 3),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                descriptionText,
                style: const TextStyle(
                  fontFamily: Constants.mainFont,
                  color: Pallete.blackColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
