import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nana_alert/models/task_card.dart';

class DocumentService {
  final guidesCollection = "guides";
  final tasksCollection = "tasks";
  final listChildCollection = "list";

  Future<String> getAll() async {
    final snapshot = await FirebaseFirestore.instance
        .collection(guidesCollection)
        .get()
        .then((value) => value.docs);

    for (int i = 0; i < snapshot.length; i++) {
      FirebaseFirestore.instance
          .collection(guidesCollection)
          .doc(snapshot[i].id.toString())
          .collection("list")
          .snapshots()
          .listen((event) {
        print(event.docs.map((DocumentSnapshot document) {
          return document.data() as Map<String, dynamic>;
        }).toList());
      });
    }

    // print(snapshot.docs);

    // final dataList = snapshot.docs.map((DocumentSnapshot document) {
    //   return document.data() as Map<String, dynamic>;
    // }).toList();

    print(snapshot.first);

    return "Ran";
  }

  Future<Map<String, dynamic>> getDocument(String name) async {
    final docRef =
        FirebaseFirestore.instance.collection(guidesCollection).doc(name);

    final docData = await docRef.get();

    final jsonData = docData.data()!;

    if (docData.data()!.containsValue("list")) {
      // Declare a merger variable
      Map<String, dynamic> merger = {};

      // Obtain all documents of the subcollection
      final listDocQuery = await docRef.collection(listChildCollection).get();
      final listDocData = listDocQuery.docs;

      // Insert each of the data into the merger
      for (final mergeDocData in listDocData) {
        merger.addAll({mergeDocData.id: mergeDocData.data()});
      }

      // Insert the finalized list into the jsonData object
      jsonData["list"] = merger;
    }

    return jsonData;
  }

  Future<List<Map<String, dynamic>>> getTasks(String uid) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(tasksCollection);

    final qs = await collectionReference.where('uid', isEqualTo: uid).get();

    List<Map<String, dynamic>> obj = [];

    for (var snapshot in qs.docs) {
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        data.addAll({"id": snapshot.id});
        obj.add(data);
      }
    }

    print(obj);

    return obj;
  }

  Future<void> publishTaskToFirestore(String uid, TaskCard task) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(tasksCollection);

    Map<String, dynamic> toAdd = {'uid': uid};
    toAdd.addAll(task.toJSON());

    await collectionReference.add(toAdd);
  }

  Future<void> removeTaskFromFirestore(String did) async {
    // Use the document ID to remove the data from the database
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(tasksCollection);

    await collectionReference.doc(did).delete();
  }
}
