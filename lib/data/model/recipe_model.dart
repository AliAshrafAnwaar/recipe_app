class RecipeModel {
  final String recipeID;
  final String title;
  final String description;

  RecipeModel({
    required this.recipeID,
    required this.title,
    required this.description,
  });

  // Convert a Recipe object to a map
  Map<String, dynamic> toMap() {
    return {
      'recipeID': recipeID,
      'title': title,
      'description': description,
    };
  }

  // Create a Recipe object from a map
  factory RecipeModel.fromMap(Map<String, dynamic> map) {
    return RecipeModel(
      recipeID: map['recipeID'],
      title: map['title'],
      description: map['description'],
    );
  }
}
