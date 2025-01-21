import 'dart:typed_data';

class Pet {
  Uint8List? image;
  String? name;
  String? breed;
  String? age;
  String? imageUrl;

  Pet({
    this.image,
    this.name,
    this.breed,
    this.age,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['breed'] = breed;
    data['age'] = age;
    data['imageURL'] = imageUrl ?? '';
    return data;
  }

  Pet.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    breed = json['breed'];
    age = json['age'];
    imageUrl = json['imageURL'] ?? '';
  }

  void setImage(Uint8List image) {
    this.image = image;
  }

  @override
  String toString() {
    // check nullable values if they are null create text without them
    if (name == null && breed == null && age == null) {
      return 'Here is the image of a pet';
    } else if (name == null && breed == null) {
      return 'Here is the image of a pet, $age years old';
    } else if (name == null && age == null) {
      return 'Here is the image of a pet, breed: $breed';
    } else if (breed == null && age == null) {
      return 'Here is the image of a pet, named $name';
    } else if (name == null) {
      return 'Here is the image of a pet, $breed, $age years old';
    } else if (breed == null) {
      return 'Here is the image of a pet, $name, $age years old';
    } else if (age == null) {
      return 'Here is the image of a pet, $name, breed: $breed';
    } else {
      return 'Here is the image of a pet, $name, $breed, $age years old';
    }
  }
}
