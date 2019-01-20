import 'package:flutter/material.dart';
import "package:observable/observable.dart";
import 'package:scoped_model/scoped_model.dart';
import 'package:todo_list/model/model.dart';

import '../actions.dart';
import "../ui/style_components.dart";
import '../ui/style_constants.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _addTodo() {
    setState(() {
      //TODO add new category
    });
  }

  List<Widget> _todosWidgets(AppState appState) => appState.categories
      .map((TodoCategory category) => TodoCard(category: category))
      .toList();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppState>(
      builder: (context, child, appState) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: TodoContainer(_todosWidgets(appState)),
          floatingActionButton: NewTodoButton(_addTodo),
        );
      },
    );
  }
}

class NewTodoButton extends StatelessWidget {
  final Function _onClick;

  NewTodoButton(this._onClick);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: _onClick,
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}

class TodoContainer extends StatelessWidget {
  final List<Widget> _children;

  TodoContainer(this._children);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: _children,
        padding: EdgeInsets.all(16),
      ),
      color: Colors.black12,
    );
  }
}

class TodoCard extends StatelessWidget {
  final TodoCategory category;

  TodoCard({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 16, 0, 0),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, DefaultStyle.sizeUnit() * 2, 0, 0),
            child: TodoCardBody(category: category),
          ),
          Positioned(
            child: TodoCardLabel(category: category),
            top: 0,
            left: 16,
          ),
          Positioned(
            right: DefaultStyle.sizeUnit(),
            top: DefaultStyle.sizeUnit(),
            child: TodoCardAddButton(
              onClick: () {
                addNewTodo(context, category);
              },
            ),
          )
        ],
      ),
    );
  }
}

class TodoCardLabel extends StatelessWidget {
  final TodoCategory category;

  const TodoCardLabel({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: BoxStyledComponent(
        child: TitleStyledComponent(
          text: this.category.title,
        ),
        color: Colors.teal.shade900,
      ),
      onDoubleTap: () {
        goToCategory(context, category);
      },
    );
  }
}

class TodoCardBody extends StatelessWidget {
  final TodoCategory category;

  TodoCardBody({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: category.todos.changes,
      builder: (BuildContext _b, AsyncSnapshot<dynamic> _s) =>
          BoxStyledComponent(
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(0, DefaultStyle.sizeUnit() * 6, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: category.todos
                    .map((Todo todo) => TodoCardBodyItem(
                          todo: todo,
                          category: category,
                        ))
                    .toList(),
              ),
            ),
            color: Colors.white,
          ),
    );
  }
}

class TodoCardBodyItem extends StatelessWidget {
  final Todo todo;
  final TodoCategory category;

  TodoCardBodyItem({
    Key key,
    @required this.todo,
    @required this.category,
  }) : super(key: key);

  void ToggleDoneTodo() {
    this.todo.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ChangeRecord>>(
      stream: todo.changes,
      builder:
          (BuildContext context, AsyncSnapshot<List<ChangeRecord>> snapshot) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TodoCardBodyItemName(
            todo: todo,
            onToggle: ToggleDoneTodo,
            onEdit: () => goToTodo(context, category, todo),
          ),
        );
      },
    );
  }
}

class TodoCardBodyItemName extends StatelessWidget {
  final Function onToggle, onEdit;

  final Todo todo;

  TodoCardBodyItemName({Key key, this.todo, this.onToggle, this.onEdit})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onToggle,
      onLongPress: onEdit,
      child: Text(
        todo.text,
        style: TextStyle(
          decoration: todo.done
              ? TextDecoration.combine([TextDecoration.lineThrough])
              : null,
        ),
      ),
    );
  }
}

class TodoCardAddButton extends StatelessWidget {
  final Function onClick;

  const TodoCardAddButton({
    Key key,
    @required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.add_circle_outline),
      onPressed: this.onClick,
    );
  }
}
