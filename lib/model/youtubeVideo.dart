class YoutubeVideo {
  String newsId;
  String title;
  String status;
  String videoLink;

  YoutubeVideo({this.newsId, this.title, this.status, this.videoLink});

  YoutubeVideo.fromJson(Map<String, dynamic> json) {
    newsId = json['newsID'] ?? "";
    // title = json['title'] ?? "";
    title = json['title'] ?? "";
    status = json['status'] ?? "";
    videoLink = json['share_video_link'] ?? "";
    // classes = json['classes'] ?? "";
    // section = json['section'] ?? "";
    // docFile = json['doc_file'] ?? "";
  }
}
