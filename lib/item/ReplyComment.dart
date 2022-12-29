class ReplyComment {
  int? replySeq;
  int? rootSeq;
  int? userSeq;
  String? nickname;
  String? content;
  String? createdAt;
  String? modifiedAt;

  ReplyComment(
      {this.replySeq,
      this.rootSeq,
      this.userSeq,
      this.nickname,
      this.content,
      this.createdAt,
      this.modifiedAt});

  factory ReplyComment.fromJson(Map<String, dynamic> json) {
    var createdAtList = (json['createdAt'] ?? []) as List;
    var modifiedAtList = (json['modifiedAt'] ?? []) as List;
    String modifiedAt = "";
    if (modifiedAtList.isNotEmpty) {
      modifiedAt =
          "${modifiedAtList.sublist(0, 3).join("-")} ${modifiedAtList.sublist(3, modifiedAtList.length).join(":")}";
    }
    return ReplyComment(
      replySeq: json['replySeq'],
      rootSeq: json['rootSeq'],
      userSeq: json['userSeq'],
      nickname: json['nickname'],
      content: json['content'],
      createdAt:
          "${createdAtList.sublist(0, 3).join("-")} ${createdAtList.sublist(3, createdAtList.length).join(":")}",
      modifiedAt: modifiedAt,
    );
  }
}
