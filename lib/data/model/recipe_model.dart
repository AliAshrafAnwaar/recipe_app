class RecipeModel {
  final String recipeID;
  final String title;
  final String description;
  final String userID;
  final String imageLink;
  final DateTime date;
  final List<double> ratings;
  final Set<String> likes;
  final List<Map<String, String>>
      comments; // List of comments with userID and comment text
  final Set<String>
      favourites; // Set of userIDs who marked the recipe as favourite

  RecipeModel({
    required this.recipeID,
    required this.title,
    required this.description,
    required this.userID,
    required this.imageLink,
    required this.date,
    required this.ratings,
    required this.likes,
    required this.comments,
    required this.favourites,
  });

  // Convert a Recipe object to a map
  Map<String, dynamic> toMap() {
    return {
      'recipeID': recipeID,
      'title': title,
      'description': description,
      'userID': userID,
      'imageLink': imageLink,
      'date': date.toIso8601String(),
      'ratings': ratings,
      'likes': likes.toList(), // Convert Set to List for storage
      'comments': comments, // Store comments as is
      'favourites': favourites.toList(), // Convert Set to List for storage
    };
  }

  // Create a Recipe object from a map
  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      recipeID: map['recipeID'],
      title: map['title'],
      description: map['description'],
      userID: map['userID'],
      imageLink: map['imageLink'],
      date: DateTime.parse(map['date']),
      ratings: List<double>.from(map['ratings']),
      likes: Set<String>.from(map['likes']), // Convert List to Set
      comments: List<Map<String, String>>.from(
          map['comments']), // Convert to List of Maps
      favourites: Set<String>.from(map['favourites']), // Convert List to Set
    );
  }

  // Create a copy of the RecipeModel with some fields replaced by new values
  RecipeModel copyWith({
    String? recipeID,
    String? title,
    String? description,
    String? userID,
    String? imageLink,
    DateTime? date,
    List<double>? ratings,
    Set<String>? likes,
    List<Map<String, String>>? comments,
    Set<String>? favourites,
  }) {
    return RecipeModel(
      recipeID: recipeID ?? this.recipeID,
      title: title ?? this.title,
      description: description ?? this.description,
      userID: userID ?? this.userID,
      imageLink: imageLink ?? this.imageLink,
      date: date ?? this.date,
      ratings: ratings ?? this.ratings,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      favourites: favourites ?? this.favourites,
    );
  }
}
