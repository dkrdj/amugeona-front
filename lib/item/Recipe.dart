class Recipe {
final int recipeSeq;
  final String title;
  final String thumbnail;
  final double starRating;
  final int starCnt;
  final List recipeIngredients;
  final List recipeContents;
  final List recipeImages;

  Recipe.json({
    required this.recipeSeq,
    required this.title,
    required this.thumbnail,
    required this.starRating,
    required this.starCnt,
    required this.recipeIngredients,
    required this.recipeContents,
    required this.recipeImages,
  });

  Recipe(
      this.recipeSeq,
      this.title,
      this.thumbnail,
      this.starRating,
      this.starCnt,
      this.recipeIngredients,
      this.recipeContents,
      this.recipeImages);

  factory Recipe.fromJson(Map<String, dynamic>? json) {
    return Recipe.json(
      recipeSeq: json?['recipeSeq'],
      title: json?['title'],
      thumbnail: json?['thumbnail'],
      starRating: json?['starRating'],
      starCnt: json?['starCnt'],
      recipeIngredients: json?['recipeIngredients'],
      recipeContents: json?['recipeContents'],
      recipeImages: json?['recipeImages'],
    );
  }
}