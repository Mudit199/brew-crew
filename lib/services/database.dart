import 'package:brew_crew/models/brew.dart';
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

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data["name"] ?? " ",
          strength: doc.data["Strength"] ?? 0,
          sugar: doc.data["sugar"] ?? "0");
    }).toList();
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }
}
