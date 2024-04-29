import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_firestore_tutorial/firebase_options.dart';
import 'package:flutter_firebase_firestore_tutorial/pages/LessonsPage.dart';

import 'package:flutter_firebase_firestore_tutorial/pages/SubjectsPage1.dart';
import 'package:flutter_firebase_firestore_tutorial/registration/phone.dart';
import 'package:flutter_firebase_firestore_tutorial/registration/verify.dart';

import 'pages/CollectionInCollection.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    name: 'ChatApp',

    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(
            210,
            224,
            251,
            1,
          ),
        ),
        useMaterial3: true,
      ),
      home:MyPhone()/*CollectionIncollection()*/,
    );
  }
}
