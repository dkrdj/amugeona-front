class Article {
  int? articleSeq;
  int? userSeq;
  String? nickname;
  int? boardSeq;
  String? title;
  String? content;
  int? like;
  int? viewCnt;
  String? url;
  DateTime? createdAt;
  DateTime? modifiedAt;

  Article(
      {this.articleSeq,
      this.userSeq,
      this.nickname,
      this.boardSeq,
      this.title,
      this.content,
      this.like,
      this.viewCnt,
      this.url,
      this.createdAt,
      this.modifiedAt});

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      articleSeq: json['articleSeq'],
      userSeq: json['userSeq'],
      nickname: json['nickname'],
      boardSeq: json['boardSeq'],
      title: json['title'],
      content: json['content'],
      like: json['like'] ?? 0,
      viewCnt: json['viewCnt'] ?? 0,
      url: json['url'],
      createdAt: json['createdAt'],
      modifiedAt: json['modifiedAt'],
    );
  }
}
