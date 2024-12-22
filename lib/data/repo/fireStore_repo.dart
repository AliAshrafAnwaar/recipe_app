import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/data/services/fireStore_services/fireStore_services.dart';

class FirestoreRepo {
  final FireStoreService _fireStoreService = FireStoreService();

  // Add a document to a collection
  Future<void> addUser(String collectionPath, Map<String, dynamic> data) async {
    await _fireStoreService.addUser(collectionPath, data);
  }

  // Update a document in a collection
  Future<void> updateUser(
      String collectionPath, String docId, Map<String, dynamic> data) async {
    await _fireStoreService.updateUser(collectionPath, docId, data);
  }

  // Retrieve a document from a collection
  Future<DocumentSnapshot> getUser(String collectionPath, String docId) async {
    return await _fireStoreService.getUser(collectionPath, docId);
  }

  // Delete a document from a collection
  Future<void> deleteUser(String collectionPath, String docId) async {
    await _fireStoreService.deleteUser(collectionPath, docId);
  }

  // Retrieve all documents from a collection
  Future<QuerySnapshot> getCollection(String collectionPath) async {
    return await _fireStoreService.getCollection(collectionPath);
  }
}
