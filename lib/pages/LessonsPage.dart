


import 'package:flutter/material.dart';
import 'package:flutter_firebase_firestore_tutorial/lesson_category/LessonCategory.dart';
import 'package:flutter_firebase_firestore_tutorial/pages/SubjectsPage1.dart';
import 'package:flutter_firebase_firestore_tutorial/services/database_service.dart';
import 'package:flutter_firebase_firestore_tutorial/widget/ScrollLoopAuto.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class LessonScreen extends StatelessWidget {
     String? Stage;
    LessonScreen({ this.Stage,Key? key}) : super(key: key);
    DatabaseService _databaseService=DatabaseService();
  List<LessonCategories>Lessons1=[LessonCategories.Lesson1,LessonCategories.Lesson2,LessonCategories.Lesson3,LessonCategories.others];
     List<Lesson2Categories>Lessons2=[Lesson2Categories.Lesson1,Lesson2Categories.Lesson2,Lesson2Categories.Lesson3,Lesson2Categories.others];
     String? name;
     Color?color;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.amber,),
      body:  SingleChildScrollView(
        child: Column(
          children:[
            Stage=='Stage1'? ScrollLoopAuto(images:LoopImages1,):ScrollLoopAuto(images:LoopImages2,),
            SizedBox(
              height:20,
            ),
            Positioned(
              child: Container(
                height: 400,
                width: MediaQuery.sizeOf(context).width,
                padding: EdgeInsets.all(12.0),
                child: Center(
                  child: GridView.builder(
                    itemCount:Stage=='Stage1'? Lessons1.length:Lessons2.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0
                    ),
                    itemBuilder: (BuildContext context, int index){
                       return  InkWell(
                         onTap: (){

                           _databaseService.SelectCollection(Stage=='Stage1'?Lessons1[index].name:Lessons2[index].name);
                           Navigator.push(context,
                               MaterialPageRoute(builder: (context)=>SubjectsPage1(),));
        
                         },
                         child: Card(
                           child: Column(
                             children: [
                               Container(
                                 decoration: BoxDecoration(
                                   color:Stage=='Stage1'? Lessons1[index].color.withOpacity(0.4):Lessons2[index].color.withOpacity(0.4),
                                   borderRadius: BorderRadius.circular(20)
                                 ),
                                 child: ListTile(
                                   title: Text(Stage=='Stage1'?Lessons1[index].name:Lessons2[index].name,style: TextStyle(fontSize: 20),),
                                 ),
                               ),
                               SizedBox(
                                 height: 20,
                               ),
                               Padding(
                                 padding: EdgeInsets.symmetric(vertical: 8.0,),
                                 child: Row(
        
                                   children: [
        
                                     Center(
                                       child: Text('Let\'s Start',style: TextStyle(fontSize: 25),),
                                     ),

                                     Icon(Icons.arrow_circle_right_outlined,size: 40,color: Stage=='Stage1'?Lessons1[index].color:Lessons2[index].color,)
                                   ],
                                 ),
                               )
                             ],
                           ),
                         ),
                       );
                    },
                  ),
                )),
            ),
        
          ]
        ),
      ),

    );

  }

}

