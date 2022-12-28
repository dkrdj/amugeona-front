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
  String? createdAt;
  String? modifiedAt;
  String? info;

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
      this.info,
      this.createdAt,
      this.modifiedAt});

  factory Article.fromJson(Map<String, dynamic> json) {
    var createdAtList = (json['createdAt'] ?? []) as List;
    var modifiedAtList = (json['modifiedAt'] ?? []) as List;

    String modifiedAt = "";
    if (modifiedAtList.isNotEmpty) {
      modifiedAt =
          "${modifiedAtList.sublist(0, 3).join("-")} ${modifiedAtList.sublist(3, modifiedAtList.length).join(":")}";
    }
    return Article(
      articleSeq: json['articleSeq'],
      userSeq: json['userSeq'],
      nickname: json['nickname'],
      boardSeq: json['boardSeq'],
      title: json['title'],
      content: json['content'],
      like: json['articleLike'] ?? 0,
      viewCnt: json['viewCnt'] ?? 0,
      url: json['url'],
      info: json['info'],
      createdAt:
          "${createdAtList.sublist(0, 3).join("-")} ${createdAtList.sublist(3, createdAtList.length).join(":")}",
      modifiedAt: modifiedAt,
    );
  }
}
