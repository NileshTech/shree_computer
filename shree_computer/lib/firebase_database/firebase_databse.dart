import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:shree_computer/exam_helper/exam_model.dart';
import 'package:shree_computer/exam_helper/inventory.dart';

class FirebaseDatabaseUtil {
  static DatabaseReference _rootRef;
  DatabaseReference _examsRef;
  DatabaseReference _inventoryRef;
  static FirebaseDatabaseUtil _instance;

  static destroyInstance() {
    print("Destroying the current Firebase DB instance.");
    _instance = null;
  }

  FirebaseDatabaseUtil._internal() {
    print("Creating all the refs.");
    FirebaseDatabase database;
    database = FirebaseDatabase.instance;
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
    _rootRef = FirebaseDatabase.instance.reference();
    _inventoryRef = _rootRef.child(Inventory.refName);
    _examsRef = _inventoryRef.child("subjects").child(ExamsModel.refName);
  }

  factory FirebaseDatabaseUtil() {
    if (_instance == null) {
      _instance = new FirebaseDatabaseUtil._internal();
    }
    return _instance;
  }

  DatabaseReference get rootRef => _rootRef;
  DatabaseReference get inventoryRef => _inventoryRef;
  DatabaseReference get examsRef => _examsRef;

  //DatabaseReference get usersRef => _usersRef;

  Stream<dynamic> getModelStreamFromDbReference(
      DatabaseReference databaseRefName, StreamTransformer streamTransformer) {
    Stream<Event> modelStream = databaseRefName.onValue;
    Stream<dynamic> modelStreamToReturn =
        modelStream.transform(streamTransformer);
    return modelStreamToReturn;
  }

  Stream<dynamic> getModelStreamFromDbQuery(
      Query query, StreamTransformer streamTransformer) {
    Stream<Event> modelStream = query.onValue;
    Stream<dynamic> modelStreamToReturn =
        modelStream.transform(streamTransformer);
    return modelStreamToReturn;
  }

  static FirebaseDatabaseUtil get instance => _instance;
}
