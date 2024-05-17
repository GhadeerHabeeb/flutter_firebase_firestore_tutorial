import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_firestore_tutorial/VideoCategory/dart/Video_screen.dart';
import 'package:flutter_firebase_firestore_tutorial/lesson_category/LessonCategory.dart';
import 'package:flutter_firebase_firestore_tutorial/pages/Lecture_content.dart';
import 'package:flutter_firebase_firestore_tutorial/pages/SubjectsPage1.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';
import '../services/database_service.dart';

class SubjectsPage1 extends StatefulWidget {
  String?stage;
    SubjectsPage1({required this.stage,super.key});

  @override
  State<SubjectsPage1> createState() => _SubjectsPage1State();
}

class _SubjectsPage1State extends State<SubjectsPage1> {
  final TextEditingController _textEditingController = TextEditingController();
  final controller=ScrollController();
   double isTapPosition=0.0;
  final DatabaseService _databaseService = DatabaseService();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(ScrollPosition);
  }
  void ScrollPosition(){
    final  isTap=controller.position.pixels;
    setState(() {
      isTapPosition=isTap;
    });
  }
  @override
  Widget build(BuildContext context) {

    void ScrollDown(){
     final double goDown=controller.position.maxScrollExtent;
     controller.animateTo(goDown, duration: Duration(seconds: 2), curve: Curves.easeInCirc);
    }
    void ScrollUp(){
      final double goUp=0;
      controller.animateTo(goUp, duration: Duration(seconds: 2), curve: Curves.easeInCirc);
    }


    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: _appBar(),
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed:isTapPosition==0.0?ScrollDown:ScrollUp,
        child:isTapPosition==0.0?Icon(Icons.arrow_downward,size: 40,color: Colors.black,):Icon(Icons.arrow_upward,size: 40,color: Colors.blue,),
      ),

    );

  }

  PreferredSizeWidget _appBar() {
    return AppBar(
      backgroundColor: Colors.amber,
      title: Center(child: Text('${StageName()}')),

    );
  }
  String StageName(){
    if(widget.stage=='Stage2')
    {
      return 'مرحلة الثانية';
    }
    else if(widget.stage=='Stage1')
    {
      return 'مرحلة الاولى';
    }
    else return 'null';
  }
  Widget _buildUI() {
    return SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              _messagesListView(),
            ],
          ),
        ));

  }

  Widget _messagesListView() {
    return SizedBox(
      height: MediaQuery
          .sizeOf(context)
          .height * 0.90,
      width: MediaQuery
          .sizeOf(context)
          .width,
      child: StreamBuilder(
        stream: _databaseService.getTodos(),
        builder: (context, snapshot) {
          List todos = snapshot.data?.docs ?? [];
          if (todos.isEmpty) {
            return Center(
              child: Center(
                child: Image.asset('assets/images/Aniki Hamster.gif'),
              ),
            );
          }
          return ListView.builder(
            controller: controller,
            itemCount: todos.length,
            itemBuilder: (context, index) {
              Todo todo = todos[index].data();
              print('todo --------$todo');
              String todoId = todos[index].id;
              print('todosId________$todoId');

              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 10,
                ),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(todo.title, style: TextStyle(
                            fontSize: 20
                        ),),
                        SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 110,
                          child: Text('${todo.subject}', style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ), textAlign: TextAlign.center,),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            todo.Lecture == '' ? SizedBox(
                              width: 0,
                            ) : Container(
                                height: 50,
                                width: 160,
                                color: Colors.amber,
                                child: ElevatedButton(
                                  onPressed: () {
                                    print(todo.Lecture);
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) =>
                                            LectureResult(
                                              title: '${todo.title}',
                                              lectureResult: '${todo
                                                  .Lecture}',)));
                                  }, child: Text('Go to Lecture',
                                  style: TextStyle(fontSize: 15,),
                                ),)),
                            SizedBox(
                              width: 20,
                            ),
                            todo.video == '' ? SizedBox(
                              width: 0,
                            ) :Container(
                                height: 50,
                                width: 150,
                                color: Colors.lightGreenAccent,
                                child: ElevatedButton(onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) =>
                                          VideoScreen(index: index,
                                            id: '${todo.video}',
                                            title: '${todo.subject}',)));
                                }, child: Text('Go to video'))),
                          ],
                        ),

                      ],
                    ),
                  ),

                ),

                /* onLongPress: () {
                    _databaseService.deleteTodo(todoId);
                  },*/
              );
            },
          );
        },
      ),
    );
  }
}

