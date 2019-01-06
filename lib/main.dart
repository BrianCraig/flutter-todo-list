import 'package:flutter/material.dart';
import 'package:todo_list/model/todo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(title: 'Todo List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Todo> _todos = List();

  void refreshPls() {
    setState(() {});
  }

  void clearPls() {
    setState(() {
      _todos = List();
    });
  }

  void _addTodo() {
    setState(() {
      _todos.add(Todo("Todo name"));
    });
  }

  List<Widget> _todosWidgets() =>
      _todos.map((Todo todo) => Text(todo.text)).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Text(widget.title),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: refreshPls,
          ),
          IconButton(
            icon: Icon(Icons.delete_forever),
            onPressed: clearPls,
          ),
        ],),
      ),
      body: TodoContainer([
        TodoCard(_todos),
        TodoCard(_todos),
      ]),
      floatingActionButton: NewTodoButton(_addTodo),
    );
  }
}

class NewTodoButton extends StatelessWidget {
  final Function _onClick;

  NewTodoButton(this._onClick);

  @override
  Widget build(BuildContext context) => FloatingActionButton(
    onPressed: _onClick,
    tooltip: 'Increment',
    child: Icon(Icons.add),
  );
}

class TodoContainer extends StatelessWidget {
  final List<Widget> _children;
  TodoContainer(this._children);

  @override
  Widget build(BuildContext context) =>
    Container(
      child: ListView(
        children: _children,
        padding: EdgeInsets.all(16),
      ),
      color: Colors.black12,
    );
}

class TodoCard extends StatelessWidget {
  final List<Todo> _todos;

  TodoCard(this._todos);

  @override
  Widget build(BuildContext context) =>
    Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 0),
            child: TodoCardBody(_todos),
          ),
          Positioned(
            child: TodoCardLabel(),
            top: 0,
            left: 16,
          )
        ],
      ),
    );
}

class TodoCardLabel extends StatelessWidget {
  const TodoCardLabel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text("TO DO",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.teal.shade900,
        borderRadius: BorderRadius.all(
          Radius.circular(4)
        )
      ),
    );
  }
}

class TodoCardBody extends StatelessWidget {
  final List<Todo> _todos;
  TodoCardBody(this._todos);
  @override

  Widget build(BuildContext context) {
    return DecoratedBox(
      child: Padding(
        padding: EdgeInsets.fromLTRB(4, 32, 4, 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _todos.map((Todo todo) => TodoCardBodyItem(todo)).toList(),
        ),
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(4)
        ),
      ),
    );
  }
}

class TodoCardBodyItem extends StatelessWidget {
  final Todo _todo;
  TodoCardBodyItem(this._todo);

  void ToggleDoneTodo() {
    this._todo.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Icon(Icons.keyboard_arrow_right),
          Expanded(
            child:Text(_todo.text,
              style: TextStyle(
                decoration: (_todo.done ? TextDecoration.combine([TextDecoration.lineThrough]) : null)
              ),
            ),
          ),
          GestureDetector(
            onTap: ToggleDoneTodo,
            child: Icon(Icons.done)
          ),
        ],
      ),
    );
  }
}
