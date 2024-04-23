import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String title;
  String subject;
  String Lecture;
  String video;
  bool isDone;
  Timestamp onCreate;


  Todo({
    required this.title,
    required this.subject,
    required this.isDone,
    required this.video,
    required this.Lecture,
    required this.onCreate,
  });

  Todo.fromJson(Map<String, Object?> json)
      : this(
          title: json['title']! as String,
          subject: json['subject']! as String,
          isDone: json['isDone']! as bool,
          video: json['video']! as String,
          Lecture: json['Lecture']! as String,
          onCreate:json['onCreate']! as Timestamp,
        );

  Todo copyWith({
    String? title,
    String? subject,
    bool? isDone,
    String? video,
    String? Lecture,
    Timestamp?onCreate,
  }) {
    return Todo(
        title: title ?? this.title,
        subject: subject ?? this.subject,
        isDone: isDone ?? this.isDone,
        Lecture: Lecture ?? this.Lecture,
        video: video ?? this.video,
      onCreate: onCreate ?? this.onCreate,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'title': title,
      'subject': subject,
      'isDone': isDone,
      'Lecture': Lecture,
      'video': video,
      'onCreate':onCreate,
    };
  }
}
