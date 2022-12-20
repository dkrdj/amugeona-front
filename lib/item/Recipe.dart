class Recipe {
  int recipeSeq;
  String title;
  String thumbnail;
  double starRating;
  int starCnt;
  List recipeIngredients;
  List recipeContents;
  List recipeImages;

  Recipe(
      this.recipeSeq,
      this.title,
      this.thumbnail,
      this.starRating,
      this.starCnt,
      this.recipeIngredients,
      this.recipeContents,
      this.recipeImages);
}
