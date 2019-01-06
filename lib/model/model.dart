import "package:observable/observable.dart";

class Todo {
  bool done = false;
  String text;

  Todo(String name){
     this.text = name;
  }

  void toggle(){
    this.done = !this.done;
  }
}

class TodoCategory {
  ObservableList<Todo> todos = new List();
  String title;
  TodoCategory(this.title);
}

class AppState {
  ObservableList<TodoCategory> categories = new List();
}