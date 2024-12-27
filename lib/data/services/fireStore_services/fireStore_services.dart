import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Add a document to a collection
  Future<void> addUser(String collectionPath, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collectionPath).doc(data['userID']).set(data);
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

  // Add a document to a collection
  Future<void> addRecipe(
      String collectionPath, Map<String, dynamic> data) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(data['recipeID'])
          .set(data);
    } catch (e) {
      print('Error adding document: $e');
    }
  }

  // Retrieve all documents from a collection
  Future<QuerySnapshot<Map<String, dynamic>>> getCollection(
      String collectionPath,
      {List<String>? recipeIDs}) async {
    try {
      Query<Map<String, dynamic>> query = _firestore.collection(collectionPath);

      if (recipeIDs != null && recipeIDs.isNotEmpty) {
        // Apply the `where` filter if recipeIDs are provided
        query = query.where('recipeID', whereIn: recipeIDs);
      }

      return await query.get();
    } catch (e) {
      print('Error retrieving collection: $e');
      rethrow;
    }
  }

  // Search for documents by title
  Future<QuerySnapshot> searchByTitle(
      String collectionPath, String title) async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('recipes')
          .where('title', isGreaterThanOrEqualTo: title)
          .where('title', isLessThanOrEqualTo: '$title\uf8ff') // Unicode trick
          .get();

      return querySnapshot;
    } catch (e) {
      print('Error searching documents by title: $e');
      rethrow;
    }
  }

  // Delete a recipe from a collection
  Future<void> deleteRecipe(String collectionPath, String recipeID) async {
    try {
      await _firestore.collection(collectionPath).doc(recipeID).delete();
    } catch (e) {
      print('Error deleting recipe: $e');
    }
  }

  // Add a user like to a recipe
  Future<void> addUserLikeToRecipe(String recipeId, String userId) async {
    await _firestore.collection('recipes').doc(recipeId).update({
      'likes': FieldValue.arrayUnion([userId])
    });
  }

  // Delete a user like from a recipe
  Future<void> deleteUserLikeFromRecipe(String recipeId, String userId) async {
    await _firestore.collection('recipes').doc(recipeId).update({
      'likes': FieldValue.arrayRemove([userId])
    });
  }

  // Add a recipe to user's favourites and update the recipe's favourites
  Future<void> addRecipeToFavourites(String userId, String recipeId) async {
    print('added to favourites');
    await _firestore.collection('users').doc(userId).update({
      'favourites': FieldValue.arrayUnion([recipeId])
    });
    await _firestore.collection('recipes').doc(recipeId).update({
      'favourites': FieldValue.arrayUnion([userId])
    });
  }

  // Remove a recipe from user's favourites and update the recipe's favourites
  Future<void> removeRecipeFromFavourites(
      String userId, String recipeId) async {
    await _firestore.collection('users').doc(userId).update({
      'favourites': FieldValue.arrayRemove([recipeId])
    });
    await _firestore.collection('recipes').doc(recipeId).update({
      'favourites': FieldValue.arrayRemove([userId])
    });
  }
}
