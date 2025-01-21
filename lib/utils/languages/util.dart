import 'dart:io';

String getLanguageCode() {
  String deviceLanguage = Platform.localeName.substring(0, 2);
  // if (deviceLanguage != "tr") {
  //   deviceLanguage = "en";
  // }
  return "en";
}

String getCountryCode() {
  // String deviceCountry = Platform.localeName.substring(3, 5);
  // if (getLanguageCode() != "tr") {
  //   deviceCountry = "US";
  // }
  return "US";
}
