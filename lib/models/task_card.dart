class TaskCard {
  String? id;
  String title;
  String description;
  String day;
  bool isComplete;

  TaskCard(this.title, this.description, this.day, this.isComplete, {this.id});

  static TaskCard fromJSON(json) {
    return TaskCard(
        json['title'], json['description'], json['day'], json['isComplete'],
        id: json['id']);
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> mapper = {
      "title": title,
      "description": description,
      "day": day,
      "isComplete": isComplete
    };

    if (id != null) {
      mapper.addAll({"id": id});
    }

    return mapper;
  }
}
