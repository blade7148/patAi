import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:petai/models/pet_analysis.dart';

class FireStoreService {
  static final FireStoreService _instance = FireStoreService._internal();
  factory FireStoreService() => _instance;
  FireStoreService._internal();

  final _firestore = FirebaseFirestore.instance;
  final _storageRef = FirebaseStorage.instance.ref();

  // print the documents in the collection
  Future<void> printData() async {
    final reference = _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("datas");

    final snapshot = await reference.get();

    for (final doc in snapshot.docs) {
      print(doc.data());
    }
  }

  Future<void> setData(AnalyzeModel data, Uint8List petImage) async {
    final reference = _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("datas")
        .doc();

    await uploadImage(reference.id, petImage);
    data.pet!.imageUrl = await getImageUrl(reference.id);
    await reference.set(data.toJson());
  }

  Future<void> deleteData(String id) async {
    final reference = _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("datas")
        .doc(id);

    await reference.delete();
  }

  Future<void> uploadImage(String id, Uint8List image) async {
    final reference = _storageRef
        .child("users/${FirebaseAuth.instance.currentUser!.uid}/$id");
    await reference.putData(image);
  }

  Future<String> getImageUrl(String id) async {
    final reference = _storageRef
        .child("users/${FirebaseAuth.instance.currentUser!.uid}/$id");
    return await reference.getDownloadURL();
  }

  Future<List<AnalyzeModel>> getData() async {
    final reference = _firestore
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection("datas");

    final snapshot = await reference.get();

    final List<AnalyzeModel> data = [];
    for (final doc in snapshot.docs) {
      final pet = doc.data();
      // final imageUrl = await getImageUrl(doc.id);
      // pet['pet']['image'] = imageUrl;
      data.add(AnalyzeModel.fromJson(pet));
    }

    return data;
  }
}
