import 'package:cloud_firestore/cloud_firestore.dart';

import 'models.dart';

class FirestoreService {
  /// Shorthand to reduce the typing
  final FirebaseFirestore _database = FirebaseFirestore.instance;

  Future<List<Person>> getPeople() async {
    var reference = _database.collection("users");
    var snapshot = await reference.get();
    var data = snapshot.docs.map((document) => document.data());
    var people = data.map((documentData) => Person.fromJson(documentData));
    return people.toList();
  }

  Future<Person> getPerson(String name) async {
    var reference = _database.collection("users").doc(name);
    var snapshot = await reference.get();
    var data = snapshot.data();
    if (data == null) {
      throw Exception("Person $name does not exist");
    } else {
      return Person.fromJson(data);
    }
  }

  Future<void> createPerson(Person person) async {
    var reference =
        _database.collection("users").doc(person.name).set(person.toJson());
    await reference;
  }

  Future<void> updatePerson(Person person) async {
    var reference = _database.collection("users").doc(person.name);
    var newData = {"city": person.city};
    return reference.set(newData, SetOptions(merge: true));
  }

  Future<void> boostPersonScore(Person person) async {
    var reference = _database.collection("users").doc(person.name);
    var updateThis = {"score": FieldValue.increment(10)};
    return reference.set(updateThis, SetOptions(merge: true));
  }
}
