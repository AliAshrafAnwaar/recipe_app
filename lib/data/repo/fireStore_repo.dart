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
  Future<QuerySnapshot> getCollection(String collectionPath,
      {List<String>? recipeIDs}) async {
    return await _fireStoreService.getCollection(collectionPath,
        recipeIDs: recipeIDs);
  }

  Future<void> addRecipe(
      String collectionPath, Map<String, dynamic> data) async {
    await _fireStoreService.addRecipe(collectionPath, data);
  }

  Future<QuerySnapshot> searchByTitle(
      String collectionPath, String title) async {
    return await _fireStoreService.searchByTitle(collectionPath, title);
  }

  // Delete a recipe from a collection
  Future<void> deleteRecipe(String collectionPath, String recipeID) async {
    await _fireStoreService.deleteRecipe(collectionPath, recipeID);
  }

  // Add a user like to a recipe and update the user's likes
  Future<void> addUserLikeToRecipe(String recipeId, String userId) async {
    await _fireStoreService.addUserLikeToRecipe(recipeId, userId);
  }

  // Delete a user like from a recipe and update the user's likes
  Future<void> deleteUserLikeFromRecipe(String recipeId, String userId) async {
    await _fireStoreService.deleteUserLikeFromRecipe(recipeId, userId);
  }

  // Add a recipe to user's favourites and update the recipe's favourites
  Future<void> addRecipeToFavourites(String userId, String recipeId) async {
    await _fireStoreService.addRecipeToFavourites(userId, recipeId);
  }

  // Remove a recipe from user's favourites and update the recipe's favourites
  Future<void> removeRecipeFromFavourites(
      String userId, String recipeId) async {
    await _fireStoreService.removeRecipeFromFavourites(userId, recipeId);
  }
}
