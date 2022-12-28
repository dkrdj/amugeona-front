class RecipeContent {
  final int contentSeq;
  final int recipeSeq;
  final String content;
  final int contentIdx;

  RecipeContent(
      {required this.contentSeq,
      required this.recipeSeq,
      required this.content,
      required this.contentIdx});

  factory RecipeContent.fromJson(Map<String, dynamic> json) {
    return RecipeContent(
      contentSeq: json['contentSeq'],
      recipeSeq: json['recipeSeq'],
      content: json['content'],
      contentIdx: json['contentIdx'],
    );
  }
}
