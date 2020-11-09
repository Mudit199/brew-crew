import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user_models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseCollectionService {
  final String uid;
  DatabaseCollectionService({this.uid});

  final CollectionReference brewCollection =
      Firestore.instance.collection("brews");

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.document(uid).setData({
      "Sugars": sugars,
      "Name": name,
      "Strength": strength,
    });
  }

  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Brew(
          name: doc.data["name"] ?? "",
          sugars: doc.data["sugars"] ?? "0",
          strength: doc.data["strength"] ?? 100);
    }).toList();
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        name: snapshot.data["name"],
        sugars: snapshot.data["sugars"],
        strength: snapshot.data["strength"]);
  }

  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  Stream<UserData> get userData {
    return brewCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }
}
