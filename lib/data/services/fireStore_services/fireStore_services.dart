import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a document to a collection
  Future<void> addUser(String collectionPath, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).doc(data['id']).set(data);
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  // Update a document in a collection
  Future<void> updateUser(
      String collectionPath, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).update(data);
    } catch (e) {
      print('Error updating document: $e');
    }
  }

  // Retrieve a document from a collection
  Future<DocumentSnapshot> getUser(String collectionPath, String docId) async {
    try {
      return await _firestore.collection(collectionPath).doc(docId).get();
    } catch (e) {
      print('Error retrieving document: $e');
      rethrow;
    }
  }

  // Delete a document from a collection
  Future<void> deleteUser(String collectionPath, String docId) async {
    try {
      await _firestore.collection(collectionPath).doc(docId).delete();
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  // Retrieve all documents from a collection
  Future<QuerySnapshot> getCollection(String collectionPath) async {
    try {
      return await _firestore.collection(collectionPath).get();
    } catch (e) {
      print('Error retrieving collection: $e');
      rethrow;
    }
  }
}