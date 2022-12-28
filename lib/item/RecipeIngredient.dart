class RecipeIngredient {
  final int recipeSeq;
  final int ingredientSeq;
  final String name;

  RecipeIngredient(
      {required this.recipeSeq,
      required this.ingredientSeq,
      required this.name});

  factory RecipeIngredient.fromJson(Map<String, dynamic> json) {
    return RecipeIngredient(
      recipeSeq: json['recipeSeq'],
      ingredientSeq: json['ingredientSeq'],
      name: json['name'],
    );
  }
}
