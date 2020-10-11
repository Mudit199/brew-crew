import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseCollectionService {
  final String uid;
  DatabaseCollectionService({this.uid});

  final CollectionReference brewCollection =
      Firestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      "Sugar": sugars,
      "Name": name,
      "Strength": strength,
    });
  }
}
