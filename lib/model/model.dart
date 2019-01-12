import "package:observable/observable.dart";

class Todo extends PropertyChangeNotifier {
  bool _done = false;

  get done => _done;

  set done(bool newValue) {
    bool oldValue = _done;
    _done = newValue;
    notifyPropertyChange(#value, oldValue, newValue);
  }

  String text;

  Todo(String name) {
    this.text = name;
  }

  void toggle() {
    this.done = !this.done;
  }
}

class TodoCategory {
  ObservableList<Todo> todos = new ObservableList();
  String title;

  TodoCategory(this.title);
}

class AppState {
  ObservableList<TodoCategory> categories = new ObservableList();
}
