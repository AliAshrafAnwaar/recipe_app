import 'package:recipe_app/data/model/recipe_model.dart';

class UserModel {
  final String userID;
  final String username;
  final String image;
  final String phoneNumber;
  final String email;
  final Set<RecipeModel> recipes;

  UserModel({
    required this.userID,
    required this.username,
    required this.image,
    required this.phoneNumber,
    required this.email,
    required this.recipes,
  });

  // Convert a User object to a map
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'username': username,
      'phoneNumber': phoneNumber,
      'image': image,
      'email': email,
      'recipes': recipes.map((recipe) => recipe.toMap()).toList(),
    };
  }

  // Create a User object from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'],
      username: map['username'],
      phoneNumber: map['phoneNumber'],
      image: map['image'],
      email: map['email'],
      recipes: (map['recipes'] as List)
          .map((recipe) => RecipeModel.fromMap(recipe))
          .toSet(),
    );
  }

  // Add copyWith method
  UserModel copyWith({
    String? userID,
    String? username,
    String? phoneNumber,
    String? image,
    String? email,
    Set<RecipeModel>? recipes,
  }) {
    return UserModel(
      userID: userID ?? this.userID,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      image: image ?? this.image,
      email: email ?? this.email,
      recipes: recipes ?? this.recipes,
    );
  }
}
