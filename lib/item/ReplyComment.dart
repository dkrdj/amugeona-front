class ReplyComment {
  int replySeq;
  int rootSeq;
  int userSeq;
  String nickname;
  String content;
  DateTime createdAt;
  DateTime modifiedAt;

  ReplyComment(this.replySeq, this.rootSeq, this.userSeq, this.nickname,
      this.content, this.createdAt, this.modifiedAt);
}
