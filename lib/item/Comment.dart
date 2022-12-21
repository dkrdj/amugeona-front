class Comment {
  int commentSeq;
  int articleSeq;
  int userSeq;
  String nickname;
  String content;
  DateTime createdAt;
  DateTime modifiedAt;

  Comment(this.commentSeq, this.articleSeq, this.userSeq, this.nickname,
      this.content, this.createdAt, this.modifiedAt);
}
