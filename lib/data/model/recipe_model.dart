class RecipeModel {
  final String recipeID;
  final String title;
  final String description;
  final String userID;
  final String imageLink;
  final DateTime date;
  final List<double> ratings;

  RecipeModel({
    required this.recipeID,
    required this.title,
    required this.description,
    required this.userID,
    required this.imageLink,
    required this.date,
    required this.ratings,
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
    );
  }

  // CopyWith method
  RecipeModel copyWith({
    String? recipeID,
    String? title,
    String? description,
    String? userID,
    String? imageLink,
    DateTime? date,
    List<double>? ratings,
  }) {
    return RecipeModel(
      recipeID: recipeID ?? this.recipeID,
      title: title ?? this.title,
      description: description ?? this.description,
      userID: userID ?? this.userID,
      imageLink: imageLink ?? this.imageLink,
      date: date ?? this.date,
      ratings: ratings ?? this.ratings,
    );
  }
}
