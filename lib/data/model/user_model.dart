import 'package:recipe_app/data/model/recipe_model.dart';

class UserModel {
  final String userID;
  final String username;
  final String image;
  final String phoneNumber;
  final String email;
  final String bio; // Added bio field
  final Set<RecipeModel> recipes;
  final Set<String> favourites; // Changed favourites field to Set<String>

  UserModel({
    required this.userID,
    required this.username,
    required this.image,
    required this.phoneNumber,
    required this.email,
    required this.bio, // Added bio field
    required this.recipes,
    required this.favourites, // Changed favourites field to Set<String>
  });

  // Convert a User object to a map
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'username': username,
      'phoneNumber': phoneNumber,
      'image': image,
      'email': email,
      'bio': bio, // Added bio field
      'recipes': recipes.map((recipe) => recipe.toMap()).toList(),
      'favourites':
          favourites.toList(), // Changed favourites field to Set<String>
    };
  }

  // Create a User object from a map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userID: map['userID'],
      username: map['username'],
      image: map['image'],
      phoneNumber: map['phoneNumber'],
      email: map['email'],
      bio: map['bio'], // Added bio field
      recipes: (map['recipes'] as List)
          .map((recipe) => RecipeModel.fromMap(recipe))
          .toSet(),
      favourites: Set<String>.from(
          map['favourites']), // Changed favourites field to Set<String>
    );
  }

  // Create a copy of the UserModel with some fields replaced by new values
  UserModel copyWith({
    String? userID,
    String? username,
    String? image,
    String? phoneNumber,
    String? email,
    String? bio,
    Set<RecipeModel>? recipes,
    Set<String>? favourites, // Changed favourites field to Set<String>
  }) {
    return UserModel(
      userID: userID ?? this.userID,
      username: username ?? this.username,
      image: image ?? this.image,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      email: email ?? this.email,
      bio: bio ?? this.bio,
      recipes: recipes ?? this.recipes,
      favourites: favourites ??
          this.favourites, // Changed favourites field to Set<String>
    );
  }
}
