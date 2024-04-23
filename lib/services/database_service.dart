import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_firestore_tutorial/models/todo.dart';

late  String TODO_COLLECTON_REF='Math';

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final todosRef;

  DatabaseService() {

    todosRef = _firestore.collection(SelectCollection(TODO_COLLECTON_REF)).orderBy('onCreate',descending: true).withConverter<Todo>(
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
}
