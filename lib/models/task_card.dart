import 'dart:convert';

class TaskCard {
  String title;
  String description;
  String day;
  bool isComplete;

  TaskCard(this.title, this.description, this.day, this.isComplete);

  static TaskCard fromJSON(json) {
    return TaskCard(
        json['title'], json['description'], json['day'], json['isComplete']);
  }

  Map<String, dynamic> toJSON() {
    Map<String, dynamic> mapper = {
      "title": title,
      "description": description,
      "day": day,
      "isComplete": isComplete
    };

    return mapper;
  }
}
