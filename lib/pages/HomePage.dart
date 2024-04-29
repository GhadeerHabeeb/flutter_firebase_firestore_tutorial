




import 'package:flutter/material.dart';
import 'package:flutter_firebase_firestore_tutorial/lesson_category/LessonCategory.dart';
import 'package:flutter_firebase_firestore_tutorial/pages/LessonsPage.dart';
import 'package:flutter_firebase_firestore_tutorial/services/database_service.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DatabaseService _databaseService=DatabaseService();

  List<Stages>stageContent=[Stages.Stages1,Stages.Stages2,Stages.others];
  List<LessonCategories>Lessons=[LessonCategories.Lesson1,LessonCategories.Lesson2,LessonCategories.Lesson3,LessonCategories.others];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              height: 80,
              color: Colors.amberAccent,
            ),
            SizedBox(
              height: 40,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 350,
                  child: Image.asset('assets/images/logo.png'),
                ),
                Container(
                  height: 300,
                  width: 400,
        
                  child: ListView.builder(
                    itemCount: 2,
                      itemBuilder: (BuildContext context,index){
                        return InkWell(
                          onTap: (){
                            print(stageContent[index].name);
                              if(stageContent[index].name=='Stage1')
                                {  _databaseService.SelectCollectionId('Stage1');
                                  _databaseService.SelectStageCollection(stageContent[index].name);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context)=>LessonScreen(Stage:stageContent[index].name,Lessons:Lessons),));
                                }
                              else if(stageContent[index].name=='Stage2'){
                                _databaseService.SelectCollectionId('Stage2');
                                _databaseService.SelectStageCollection(stageContent[index].name);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context)=>LessonScreen(Stage:stageContent[index].name,Lessons:Lessons),));
                              }
        
                          },
                          child: Card(
                            color: stageContent[index].color,
                            child: Container(
                              height: 80,
                              width:MediaQuery.sizeOf(context).width ,
                              child: ListTile(
                                title: Center(
                                  child: Text(
                                    stageContent[index].name,
                                    style: TextStyle(fontSize: 30),),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 3),
              width: MediaQuery.sizeOf(context).width,
              height: 80,
              decoration: BoxDecoration(color: Colors.amberAccent,
                borderRadius: BorderRadius.only(topRight:Radius.circular(20),topLeft:Radius.circular(20) )
              ),
              child:Column(
                children: [
                  Center(
                    child:  Text('  2021منجزون للموارد التعليمية',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        child: Text('سياسة الاستخدام',style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),),
                      ),
                      InkWell(
                        child: Text('الخصوصية',style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.bold),),
                      )
                    ],
                  )
                ],
              ),

            ),
          ],
        ),
      ),
    );
  }



}

