class RecipeImage {
  final int imgSeq;
  final int recipeSeq;
  final String url;
  final int contentIdx;

  RecipeImage(
      {required this.imgSeq,
      required this.recipeSeq,
      required this.url,
      required this.contentIdx});

  factory RecipeImage.fromJson(Map<String, dynamic> json) {
    return RecipeImage(
      imgSeq: json['imgSeq'],
      recipeSeq: json['recipeSeq'],
      url: json['url'],
      contentIdx: json['contentIdx'],
    );
  }
}
