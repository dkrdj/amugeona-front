class Comment {
  int? commentSeq;
  int? articleSeq;
  int? userSeq;
  String? nickname;
  String? content;
  String? createdAt;
  String? modifiedAt;

  Comment(
      {this.commentSeq,
      this.articleSeq,
      this.userSeq,
      this.nickname,
      this.content,
      this.createdAt,
      this.modifiedAt});

  factory Comment.fromJson(Map<String, dynamic> json) {
    var createdAtList = (json['createdAt'] ?? []) as List;
    var modifiedAtList = (json['modifiedAt'] ?? []) as List;
    String modifiedAt = "";
    if (modifiedAtList.isNotEmpty) {
      modifiedAt =
          "${modifiedAtList.sublist(0, 3).join("-")} ${modifiedAtList.sublist(3, modifiedAtList.length).join(":")}";
    }
    return Comment(
      commentSeq: json['commentSeq'],
      articleSeq: json['articleSeq'],
      userSeq: json['userSeq'],
      nickname: json['nickname'],
      content: json['content'],
      createdAt:
          "${createdAtList.sublist(0, 3).join("-")} ${createdAtList.sublist(3, createdAtList.length).join(":")}",
      modifiedAt: modifiedAt,
    );
  }
}
