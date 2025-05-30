import 'package:flutter/material.dart';

class InfoItemWidget extends StatelessWidget {
  final String description;
  final String subTitle;

  const InfoItemWidget({super.key, required this.description, required this.subTitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          subTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          description,
          style: const TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}