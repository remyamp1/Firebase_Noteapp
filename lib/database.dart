import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Database {
  static Future addNoteitems(
      Map<String, dynamic> noteInfoMap, String id) async {
    return await FirebaseFirestore.instance.collection("Note").doc(id).set(noteInfoMap);
  }

  static Future <Stream<QuerySnapshot>> getNoteitems()async{
    return await FirebaseFirestore.instance.collection("Note").snapshots();
  }
}
