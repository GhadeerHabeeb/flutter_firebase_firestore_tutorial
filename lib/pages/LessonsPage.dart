




import 'package:flutter/material.dart';
import 'package:flutter_firebase_firestore_tutorial/lesson_category/LessonCategory.dart';
import 'package:flutter_firebase_firestore_tutorial/pages/SubjectsPage1.dart';
import 'package:flutter_firebase_firestore_tutorial/services/database_service.dart';
import 'package:flutter_firebase_firestore_tutorial/widget/ScrollLoopAuto.dart';
import 'package:scroll_loop_auto_scroll/scroll_loop_auto_scroll.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';
class LessonScreen extends StatelessWidget {
     String? Stage;
     List Lessons=[];
    LessonScreen({required this.Lessons, this.Stage,Key? key}) : super(key: key);
    DatabaseService _databaseService=DatabaseService();
 /* List<LessonCategories>Lessons1=[LessonCategories.Lesson1,LessonCategories.Lesson2,LessonCategories.Lesson3,LessonCategories.others];
     List<Lesson2Categories>Lessons2=[Lesson2Categories.Lesson1,Lesson2Categories.Lesson2,Lesson2Categories.Lesson3,Lesson2Categories.others];*/
     String? name;
     Color?color;


  @override
  Widget build(BuildContext context) {
    String StageName(){
      if( Stage=='Stage2')
      {
        return 'مرحلة الثانية';
      }
      else if(Stage=='Stage1')
      {
        return 'مرحلة الاولى';
      }
      else return 'null';
    }
    void sendWhatsAppMessage({
      required String phone,
      required String message,
    }) async {
      String url() {
        if (Platform.isIOS) {
          return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
        } else {
          return "whatsapp://send?phone=$phone&text=$message";
        }
      }

      await canLaunch(url())
          ? launch(url())
          : ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          backgroundColor: Colors.red,
          content: Text('There is no WhatsApp on your Device!')));
    }
    Future<void> _launchUrl({required String phone,required String message}) async {

      final Uri url;
      if (Platform.isIOS) {
        url = Uri.parse('whatsapp://wa.me/$phone/?text=${Uri.parse(message)}');
      } else {
        url = Uri.parse('whatsapp://send?phone=$phone&text=$message');
      }
      if (!await launchUrl(url)) {
        throw Exception('Could not launch $url');
      }}
    return  Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.amber,

      title: Center(child: Text('${StageName()}')),
     actions: [
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: InkWell(
           onTap: (){
             _launchUrl(phone: '+9647714517466',message: 'مرحبا بكم في منجزون ');
           },
             child: Image.asset('assets/images/whatsapp.png',)),
       ),
     ],
      ),
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

                    itemCount: Lessons.length ,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 4.0,
                        mainAxisSpacing: 4.0
                    ),
                    itemBuilder: (BuildContext context, int index){
                       return  InkWell(
                         onTap: (){

                           print(Lessons[index].name);
                           print(Stage);
                           print(_databaseService.SelectCollectionId(Stage!));

                           _databaseService.SelectCollection(Lessons[index].name);
                           Navigator.push(context,
                               MaterialPageRoute(builder: (context)=>SubjectsPage1(stage:Stage),));
        
                         },
                         child: Card(
                           child: Column(
                             children: [
                               Container(
                                 decoration: BoxDecoration(
                                   color: Lessons[index].color  ,
                                   borderRadius: BorderRadius.circular(20)
                                 ),
                                 child: ListTile(
                                   title: Text( Lessons[index].name,style: TextStyle(fontSize: 20),),
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

                                     Icon(Icons.arrow_circle_right_outlined,size: 40,color: Lessons[index].color,)
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

