import 'package:petai/models/pet.dart';

class AnalyzeModel {
  Pet? pet;
  Check? check;
  Define? define;
  String? conclusion;
  String? disclaimer;

  AnalyzeModel(
      {this.pet, this.check, this.define, this.conclusion, this.disclaimer});

  AnalyzeModel.fromJson(Map<String, dynamic> json) {
    pet = json['pet'] != null ? Pet.fromJson(json['pet']) : null;
    check = json['check'] != null ? Check.fromJson(json['check']) : null;
    define = json['define'] != null ? Define.fromJson(json['define']) : null;
    conclusion = json['conclusion'];
    disclaimer = json['disclaimer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pet != null) {
      data["pet"] = pet!.toJson();
    }
    if (check != null) {
      data['check'] = check!.toJson();
    }
    if (define != null) {
      data['define'] = define!.toJson();
    }
    data['conclusion'] = conclusion;
    data['disclaimer'] = disclaimer;
    return data;
  }

  @override
  String toString() {
    return 'AnalyzeModel{pet: $pet ,check: $check, define: $define, conclusion: $conclusion, disclaimer: $disclaimer}';
  }
}

class Check {
  List<dynamic>? medicalConditions;
  List<dynamic>? psychologicalBehaviors;
  List<dynamic>? careSuggestions;
  String? entertainment;
  String? nutritionAndDiet;
  String? environment;
  String? temperatureFit;
  String? toys;

  Check(
      {this.medicalConditions,
      this.psychologicalBehaviors,
      this.careSuggestions,
      this.entertainment,
      this.nutritionAndDiet,
      this.environment,
      this.temperatureFit,
      this.toys});

  Check.fromJson(Map<String, dynamic> json) {
    medicalConditions = json['medical_conditions'].cast<String>();
    psychologicalBehaviors = json['psychological_behaviors'].cast<String>();
    careSuggestions = json['care_suggestions'].cast<String>();
    entertainment = json['entertainment'];
    nutritionAndDiet = json['nutrition_and_diet'];
    environment = json['environment'];
    temperatureFit = json['temperature_fit'];
    toys = json['toys'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medical_conditions'] = medicalConditions;
    data['psychological_behaviors'] = psychologicalBehaviors;
    data['care_suggestions'] = careSuggestions;
    data['entertainment'] = entertainment;
    data['nutrition_and_diet'] = nutritionAndDiet;
    data['environment'] = environment;
    data['temperature_fit'] = temperatureFit;
    data['toys'] = toys;
    return data;
  }

  @override
  String toString() {
    return 'Check{medicalConditions: $medicalConditions, psychologicalBehaviors: $psychologicalBehaviors, careSuggestions: $careSuggestions, entertainment: $entertainment, nutritionAndDiet: $nutritionAndDiet, environment: $environment, temperatureFit: $temperatureFit, toys: $toys}';
  }
}

class Define {
  String? breed;
  String? age;
  Characteristics? characteristics;

  Define({this.breed, this.age, this.characteristics});

  Define.fromJson(Map<String, dynamic> json) {
    breed = json['breed'];
    age = json['age'];
    characteristics = json['characteristics'] != null
        ? Characteristics.fromJson(json['characteristics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['breed'] = breed;
    data['age'] = age;
    if (characteristics != null) {
      data['characteristics'] = characteristics!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Define{breed: $breed, age: $age, characteristics: $characteristics}';
  }
}

class Characteristics {
  String? furColor;
  String? size;
  String? weight;
  List<dynamic>? uniqueFeatures;
  List<dynamic>? commonIssues;

  Characteristics(
      {this.furColor,
      this.size,
      this.weight,
      this.uniqueFeatures,
      this.commonIssues});

  Characteristics.fromJson(Map<String, dynamic> json) {
    furColor = json['fur_color'];
    size = json['size'];
    weight = json['weight'];
    uniqueFeatures = json['unique_features'].cast<String>();
    commonIssues = json['common_issues'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fur_color'] = furColor;
    data['size'] = size;
    data['weight'] = weight;
    data['unique_features'] = uniqueFeatures;
    data['common_issues'] = commonIssues;
    return data;
  }

  @override
  String toString() {
    return 'Characteristics{furColor: $furColor, size: $size, weight: $weight, uniqueFeatures: $uniqueFeatures, commonIssues: $commonIssues}';
  }
}
