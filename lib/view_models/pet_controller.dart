import 'package:get/get.dart';
import 'package:petai/models/pet.dart';

class PetController extends GetxController {
  final _petList = <Pet>[].obs;
  List<Pet> get petList => _petList;

  var currentPet = Pet().obs;

  void addPet(Pet pet) {
    _petList.add(pet);
  }

  void removePet(Pet pet) {
    _petList.remove(pet);
  }

  void setCurrentPet(Pet pet) {
    currentPet.value = pet;
  }

  void clearCurrentPet() {
    currentPet.value = Pet();
  }
}
