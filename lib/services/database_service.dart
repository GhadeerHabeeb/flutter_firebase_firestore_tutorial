import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_firestore_tutorial/models/todo.dart';

late  String TODO_COLLECTON_REF='Math';
late  String Stage_COLLECTON_REF='Stage1';
   String? doc_id_REF;

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final todosRef;

  DatabaseService() {

    todosRef = _firestore.collection(SelectStageCollection(Stage_COLLECTON_REF)).doc(SelectCollectionId(Stage_COLLECTON_REF)).collection(SelectCollection(TODO_COLLECTON_REF)).orderBy('onCreate',descending: true).withConverter<Todo>(
        fromFirestore: (snapshots, _) => Todo.fromJson(
          snapshots.data()!,
        ),
        toFirestore: (todo, _) => todo.toJson());
  }

  Stream<QuerySnapshot> getTodos() {
    return todosRef.snapshots();
  }

  void addTodo(Todo todo) async {
    todosRef.add(todo);
  }

  void updateTodo(String todoId, Todo todo) {
    todosRef.doc(todoId).update(todo.toJson());
  }

  void deleteTodo(String todoId) {
    todosRef.doc(todoId).delete();
  }
  String SelectCollection(String x){
    return TODO_COLLECTON_REF=x;
  }
  String SelectStageCollection(String x){
    return Stage_COLLECTON_REF=x;
  }
  String SelectCollectionId(String x)
  {
    if(x=='Stage1')
      {
        doc_id_REF='ZmTHlaWolfiC6p9TeWjg';
        return doc_id_REF!;
      }
    else if(x=='Stage2')
      {
        doc_id_REF='a3WYBwEiMCo9dYtT6YNy';
        return doc_id_REF!;
      }
    else
      {
        return 'no stage';
      }

  }
}

// class DatabaseService {
//   final _firestore = FirebaseFirestore.instance;
//
//   late final todosRef;
//
//   DatabaseService() {
//
//     todosRef = _firestore.collection(SelectCollection(TODO_COLLECTON_REF)).orderBy('onCreate',descending: true).withConverter<Todo>(
//         fromFirestore: (snapshots, _) => Todo.fromJson(
//               snapshots.data()!,
//             ),
//         toFirestore: (todo, _) => todo.toJson());
//   }
//
//   Stream<QuerySnapshot> getTodos() {
//     return todosRef.snapshots();
//   }
//
//   void addTodo(Todo todo) async {
//     todosRef.add(todo);
//   }
//
//   void updateTodo(String todoId, Todo todo) {
//     todosRef.doc(todoId).update(todo.toJson());
//   }
//
//   void deleteTodo(String todoId) {
//     todosRef.doc(todoId).delete();
//   }
//   String SelectCollection(String x){
//     return TODO_COLLECTON_REF=x;
//   }
// }
