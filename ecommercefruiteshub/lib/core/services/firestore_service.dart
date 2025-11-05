// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fruits_hub/features/auth/data/models/user_model.dart';
// import 'package:fruits_hub/features/auth/domain/entites/user_entity.dart';

// import 'data_service.dart';

// class FireStoreService implements DatabaseService {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   @override
//   Future<void> addData(
//       {required String path,
//       required Map<String, dynamic> data,
//       String? documentId}) async {
//     if (documentId != null) {
//       firestore.collection(path).doc(documentId).set(data);
//     } else {
//       await firestore.collection(path).add(data);
//     }
//   }

//   @override
//   Future<dynamic> getData(
//       {required String path,
//       String? docuementId,
//       Map<String, dynamic>? query}) async {
//     if (docuementId != null) {
//       var data = await firestore.collection(path).doc(docuementId).get();
//       return data.data();
//     } else {
//       Query<Map<String, dynamic>> data = firestore.collection(path);
//       if (query != null) {
//         if (query['orderBy'] != null) {
//           var orderByField = query['orderBy'];
//           var descending = query['descending'];
//           data = data.orderBy(orderByField, descending: descending);
//         }
//         if (query['limit'] != null) {
//           var limit = query['limit'];
//           data = data.limit(limit);
//         }
//       }
//       var result = await data.get();
//       return result.docs.map((e) => e.data()).toList();
//     }
//   }

//   @override
//   Future<bool> checkIfDataExists(
//       {required String path, required String docuementId}) async {
//     var data = await firestore.collection(path).doc(docuementId).get();
//     return data.exists;
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

abstract class DataBaseService {
  Future<void> setData({
    required String path,
    required Map<String, dynamic> data,
  });
  Future<void> deleteData({required String path});
  Stream<List<T>> collectionStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  });
  Stream<T> documentStream<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  });
  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  });
  Future<List<T>> getCollection<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  });
}

class FirestoreServices implements DataBaseService {
  // Singleton
  // FirestoreServices._();
  // static final instance = FirestoreServices._();

  // FirebaseFirestore get firestore => FirebaseFirestore.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // add & update data
  @override
  Future<void> setData({
    required String path, // Collection/$documentId
    required Map<String, dynamic> data,
  }) async {
    final reference = firestore.doc(path);
    debugPrint('$path: $data');
    await reference.set(data);
  }

  @override
  Future<void> deleteData({required String path}) async {
    final reference = firestore.doc(path);
    debugPrint('delete: $path');
    await reference.delete();
  }

  @override
  Stream<List<T>> collectionStream<T>({
    required String path, // products/
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) {
    Query query = firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = query.snapshots();
    return snapshots.map((snapshot) {
      final result = snapshot.docs
          .map(
            (snapshot) =>
                builder(snapshot.data() as Map<String, dynamic>, snapshot.id),
          )
          .where((value) => value != null)
          .toList();
      if (sort != null) {
        result.sort(sort);
      }
      return result;
    });
  }

  @override
  Stream<T> documentStream<T>({
    required String path, // products/1
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) {
    final reference = firestore.doc(path);
    final snapshots = reference.snapshots();
    return snapshots.map(
      (snapshot) =>
          builder(snapshot.data() as Map<String, dynamic>, snapshot.id),
    );
  }

  // One Time Request for the document
  @override
  Future<T> getDocument<T>({
    required String path,
    required T Function(Map<String, dynamic> data, String documentID) builder,
  }) async {
    final reference = firestore.doc(path);
    final snapshot = await reference.get();
    return builder(snapshot.data() as Map<String, dynamic>, snapshot.id);
  }

  // One Time Request for a list of documents
  @override
  Future<List<T>> getCollection<T>({
    required String path, // users/$userId/products
    required T Function(Map<String, dynamic> data, String documentId) builder,
    Query Function(Query query)? queryBuilder,
    int Function(T lhs, T rhs)? sort,
  }) async {
    Query query = firestore.collection(path);
    if (queryBuilder != null) {
      query = queryBuilder(query);
    }
    final snapshots = await query.get();
    final result = snapshots.docs
        .map((snapshot) {
          return builder(snapshot.data() as Map<String, dynamic>, snapshot.id);
        })
        .where((value) => value != null)
        .toList();
    if (sort != null) {
      result.sort(sort);
    }
    return result;
  }
}
