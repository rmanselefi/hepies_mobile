class Consult {
  int userId;
  String topic;
  String image;
  String date;

  Consult({this.topic, this.image, this.date});

  factory Consult.fromJson(Map<String, dynamic> responseData) {
    return Consult(
      topic: responseData['topic'],
      image: responseData['image'] != null ? responseData['image'] : '',
      date: responseData['createdAt'],
    );
  }
}
