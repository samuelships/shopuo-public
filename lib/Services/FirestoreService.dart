import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  FirestoreService() {
    String host = defaultTargetPlatform == TargetPlatform.android
        ? '10.0.2.2:8080'
        : 'localhost:8080';

    // FirebaseFirestore.instance.settings =
    //     Settings(host: host, sslEnabled: false, persistenceEnabled: false);
    //FirebaseFirestore.instance.settings = Settings(persistenceEnabled: false);
    _firestore = FirebaseFirestore.instance;
  }

  FirebaseFirestore _firestore;
  Future<void> setData({String path, Map<String, dynamic> data}) async {
    await _firestore.doc(path).set(data, SetOptions(merge: true));
  }

  Future<DocumentReference> addDocument({
    String path,
    Map<String, dynamic> data,
  }) async {
    final reference = _firestore.collection(path);
    return reference.add(data);
  }

  Future<DocumentSnapshot> getData(String path) async {
    return await _firestore.doc(path).get();
  }

  Future<List<T>> getDataCollection<T>({
    String path,
    T builder({
      Map<String, dynamic> data,
      String documentID,
      DocumentSnapshot snapshot,
    }),
    Query queryBuilder(CollectionReference query),
  }) async {
    Query query = _firestore.collection(path);

    if (queryBuilder != null) {
      query = queryBuilder(query);
    }

    return (await query.get())
        .docs
        .map((snapshot) => builder(
            data: snapshot.data(), documentID: snapshot.id, snapshot: snapshot))
        .toList();
  }

  Future<void> deleteData(String path) async {
    await _firestore.doc(path).delete();
  }

  Stream<List<T>> collectionStream<T>({
    String path,
    T builder(Map<String, dynamic> data, String documentId),
    Query queryBuilder(Query query),
    int sort(T lhs, T rhs),
  }) {
    Query query = _firestore.collection(path);

    if (query != null) {
      query = queryBuilder(query);
    }

    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result =
          snapshot.docs.map((item) => builder(item.data(), item.id)).toList();

      if (sort != null) {
        result.sort(sort);
      }

      return result;
    });
  }

  Stream<T> documentStream<T>(
      {String path, builder(Map<String, dynamic> data, String documentId)}) {
    final reference = _firestore.doc(path).snapshots();
    return reference.map((snap) => builder(snap.data(), snap.id));
  }
}
