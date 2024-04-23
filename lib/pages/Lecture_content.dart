
import 'package:flutter/material.dart';
import 'package:flutter_firebase_firestore_tutorial/services/database_service.dart';

class LectureResult extends StatefulWidget {
  final String lectureResult;
  final String title;

  DatabaseService _databaseService=DatabaseService();
    LectureResult({required this.title,required this.lectureResult,Key? key}) : super(key: key);
  final String result='';
  @override
  State<LectureResult> createState() => _LectureResultState();
}

class _LectureResultState extends State<LectureResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.amber,
       title:Center(child: Text('${widget.title}')),
     ),
      body:
      Stack(
        children: [
          Center(child: CircularProgressIndicator(
            color: Colors.amber,
          )),
          Center(
            child:Container(
              height: 500,
              child: InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(20.0),
                minScale: 0.1,
                maxScale: 1.9,
                child:
                Image.network(widget.lectureResult),

              ),
            ),
          ),
        ],
      ),

    );
  }
}
