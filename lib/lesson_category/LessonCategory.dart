import 'package:flutter/material.dart';

enum LessonCategories{
  Lesson1('Math', Colors.pink),
  Lesson2('English', Colors.orange),
  Lesson3('Arabic', Colors.green),
  others('Science',Colors.blue);


  static LessonCategories stringToTaskCategory(String name) {
    try {
      return LessonCategories.values.firstWhere(
            (category) => category.name == name,
      );
    } catch (e) {
      return LessonCategories.others;
    }
  }

  final String name;
  final Color color;
  const LessonCategories(this.name, this.color);
}
enum Lesson2Categories{
  Lesson1('Math2', Colors.greenAccent),
  Lesson2('English2', Colors.amber),
  Lesson3('Arabic2', Colors.brown),
  others('Science2',Colors.redAccent);


  static Lesson2Categories stringToTaskCategory(String name) {
    try {
      return Lesson2Categories.values.firstWhere(
            (category) => category.name == name,
      );
    } catch (e) {
      return Lesson2Categories.others;
    }
  }

  final String name;
  final Color color;
  const Lesson2Categories(this.name, this.color);
}

enum Stages{
  Stages1('Stage1', Colors.lightBlueAccent),
  Stages2('Stage2', Colors.amberAccent),
  others('Stage3',Colors.blue);


  static Stages stringToTaskCategory(String name) {
    try {
      return Stages.values.firstWhere(
            (category) => category.name == name,
      );
    } catch (e) {
      return Stages.others;
    }
  }

  final String name;
  final Color color;
  const Stages(this.name, this.color);
}

List<String>LoopImages1=[
  'assets/L_images/6.png',
  'assets/L_images/10.png',
  'assets/L_images/15.png',
  'assets/L_images/9.png',

];
List<String>LoopImages2=[
  'assets/L_images/33.png',
  'assets/L_images/34.png',
  'assets/L_images/35.png',
  'assets/L_images/36.png',

];


