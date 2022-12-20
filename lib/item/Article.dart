class Article {
  int articleSeq;
  int userSeq;
  String nickname;
  int boardSeq;
  String title;
  String content;
  int like;
  int viewCnt;
  String url;
  DateTime createdAt;
  DateTime modifiedAt;

  Article(
      this.articleSeq,
      this.userSeq,
      this.nickname,
      this.boardSeq,
      this.title,
      this.content,
      this.like,
      this.viewCnt,
      this.url,
      this.createdAt,
      this.modifiedAt);
}
