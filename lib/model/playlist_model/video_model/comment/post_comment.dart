class PostComment {
  String? text;
  String? videoId;

  PostComment({this.text, this.videoId});

  PostComment.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    videoId = json['videoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['text'] = text;
    data['videoId'] = videoId;
    return data;
  }
}