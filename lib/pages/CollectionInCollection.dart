
import 'package:flutter/material.dart';
import 'package:flutter_firebase_firestore_tutorial/VideoCategory/dart/Video_screen.dart';
import 'package:flutter_firebase_firestore_tutorial/models/todo.dart';
import 'package:flutter_firebase_firestore_tutorial/pages/Lecture_content.dart';
import 'package:flutter_firebase_firestore_tutorial/services/database_service.dart';

class CollectionIncollection extends StatefulWidget {
  CollectionIncollection({Key? key}) : super(key: key);

  @override
  State<CollectionIncollection> createState() => _CollectionIncollectionState();
}

class _CollectionIncollectionState extends State<CollectionIncollection> {
  final DatabaseService _databaseService = DatabaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  _messagesListView(),
    );

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
        /*  if (todos.isEmpty) {
            return Center(
              child: Center(
                child: Image.asset('assets/images/Aniki Hamster.gif'),
              ),
            );
          }*/
          return ListView.builder(
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
                        Text('${todo.subject}', style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ), textAlign: TextAlign.center,),
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
                            Container(
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

