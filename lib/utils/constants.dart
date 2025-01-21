import 'package:flutter/material.dart';

class Constants {
  static const appName = 'Pet AI';

  static const Color backgroundColor2 = Color(0xFF17203A);
  static const Color backgroundColorLight = Color(0xFFF2F6FF);
  static const Color backgroundColorDark = Color(0xFF25254B);
  static const Color shadowColorLight = Color(0xFF4A5367);
  static const Color shadowColorDark = Colors.black;

  static const double borderRadius = 16.0;
  static const int tabLength = 5;

//   static const String systemPrompt = """
// Analyze the provided image of a pet and return the following information:

// Species (e.g., dog, cat, rabbit)
// Breed or closest breed match
// Estimated age range
// Coat color and pattern
// Any notable features or characteristics
// Potential health concerns based on visible traits (if any)

// Please format the response as a JSON object with the following structure:
// {
//   "species": "string",
//   "breed": "string",
//   "ageRange": {
//     "min": number,
//     "max": number
//   },
//   "coat": {
//     "color": "string",
//     "pattern": "string"
//   },
//   "notableFeatures": ["string"],
//   "potentialHealthConcerns": ["string"]
// }

// If any field is not applicable or cannot be determined, use null as the value.
// """;
}
