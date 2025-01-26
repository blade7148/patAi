import 'package:petai/models/pet.dart';

class AnalyzeModel {
  Pet? pet;
  Check? check;
  Define? define;
  String? conclusion;
  String? disclaimer;

  AnalyzeModel(
      {this.pet, this.check, this.define, this.conclusion, this.disclaimer});

  AnalyzeModel.fromJson(Map<Object?, Object?> json) {
    final Map<String, dynamic> data = Map<String, dynamic>.from(json);
    pet = data['pet'] != null
        ? Pet.fromJson(Map<String, dynamic>.from(data['pet'] as Map))
        : null;
    check = data['check'] != null
        ? Check.fromJson(Map<String, dynamic>.from(data['check'] as Map))
        : null;
    define = data['define'] != null
        ? Define.fromJson(Map<String, dynamic>.from(data['define'] as Map))
        : null;
    conclusion = data['conclusion'] as String?;
    disclaimer = data['disclaimer'] as String?;
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

  Check.fromJson(Map<Object?, Object?> json) {
    final Map<String, dynamic> data = Map<String, dynamic>.from(json);
    medicalConditions = data['medical_conditions'] as List<dynamic>?;
    psychologicalBehaviors = data['psychological_behaviors'] as List<dynamic>?;
    careSuggestions = data['care_suggestions'] as List<dynamic>?;
    entertainment = data['entertainment'] as String?;
    nutritionAndDiet = data['nutrition_and_diet'] as String?;
    environment = data['environment'] as String?;
    temperatureFit = data['temperature_fit'] as String?;
    toys = data['toys'] as String?;
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

  Define.fromJson(Map<Object?, Object?> json) {
    final Map<String, dynamic> data = Map<String, dynamic>.from(json);
    breed = data['breed'] as String?;
    age = data['age'] as String?;
    characteristics = data['characteristics'] != null
        ? Characteristics.fromJson(
            Map<String, dynamic>.from(data['characteristics'] as Map))
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

  Characteristics.fromJson(Map<Object?, Object?> json) {
    final Map<String, dynamic> data = Map<String, dynamic>.from(json);
    furColor = data['fur_color'] as String?;
    size = data['size'] as String?;
    weight = data['weight'] as String?;
    uniqueFeatures = data['unique_features'] as List<dynamic>?;
    commonIssues = data['common_issues'] as List<dynamic>?;
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
