import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ItemImageView extends StatelessWidget {
  final Uint8List bytes;
  const ItemImageView({
    super.key,
    required this.bytes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.memory(
          bytes,
          width: Get.width,
          height: Get.height * 0.8 * 0.25,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
