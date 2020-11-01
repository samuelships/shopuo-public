import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> setData({String path, Map<String, dynamic> data}) async {
    await _firestore.doc(path).set(data, SetOptions(merge: true));
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
