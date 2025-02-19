import 'package:get/get.dart';

class LanguageController extends GetxController {
  var selectedLanguage = 'English'.obs; // Default value

  void updateLanguage(String language) {
    selectedLanguage.value = language;
  }
}
