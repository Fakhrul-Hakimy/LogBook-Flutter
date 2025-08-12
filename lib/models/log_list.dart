class LogList {
  String title;
  String comment;
  String date;

  LogList({required this.title, required this.comment , required this.date});

  Map<String, dynamic> toJson() => {
        'title': title,
        'comment': comment,
        'date': date,
      };

  factory LogList.fromJson(Map<String, dynamic> json) {
    return LogList(
      title: json['title'],
      comment: json['comment'],
      date: json['date'],
    );
  }
}
