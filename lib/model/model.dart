import "package:observable/observable.dart";
import 'package:scoped_model/scoped_model.dart';


class Todo extends PropertyChangeNotifier {
  bool _done = false;

  get done => _done;

  set done(bool newValue) {
    bool oldValue = _done;
    _done = newValue;
    notifyPropertyChange(#value, oldValue, newValue);
  }

  get maxTextLength => 50;

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

  get maxTitleLength => 50;

  TodoCategory(this.title);
}

class AppState extends Model {
  ObservableList<TodoCategory> categories = new ObservableList();
}
