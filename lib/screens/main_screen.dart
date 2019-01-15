import 'dart:async';

import 'package:flutter/material.dart';
import "package:observable/observable.dart";
import 'package:todo_list/model/model.dart';
import 'package:scoped_model/scoped_model.dart';

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

  List<Widget> _todosWidgets(AppState appState) => appState
      .categories
      .map((TodoCategory category) => TodoCard(category: category))
      .toList();

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AppState>(
      builder:(context, child, appState) {
        return Scaffold (
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
            child: TodoCardBody(category.todos),
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
                category.todos.add(Todo("New ToDo"));
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
  final ObservableList<Todo> _todos;

  TodoCardBody(this._todos);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: _todos.changes,
      builder: (BuildContext _b, AsyncSnapshot<dynamic> _s) =>
          BoxStyledComponent(
            child: Padding(
              padding:
                  EdgeInsets.fromLTRB(0, DefaultStyle.sizeUnit() * 6, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: []
                  ..addAll(_todos.map((Todo todo) => TodoCardBodyItem(
                        todo: todo,
                        onRemove: () => _todos.remove(todo),
                      )))
                  ..add(NewTodoForm()),
              ),
            ),
            color: Colors.white,
          ),
    );
  }
}

class TodoCardBodyItem extends StatelessWidget {
  final Todo todo;
  final Function onRemove;

  TodoCardBodyItem({
    Key key,
    @required this.todo,
    @required this.onRemove,
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
          child: Row(
            children: [
              Expanded(child: TodoCardBodyItemName(todo: todo)),
              GestureDetector(onTap: onRemove, child: Icon(Icons.delete)),
              GestureDetector(onTap: ToggleDoneTodo, child: Icon(Icons.done)),
            ],
          ),
        );
      },
    );
  }
}

class TodoCardBodyItemName extends StatefulWidget {
  final Todo todo;

  const TodoCardBodyItemName({Key key, this.todo}) : super(key: key);

  @override
  _TodoCardBodyItemNameState createState() => _TodoCardBodyItemNameState();
}

class _TodoCardBodyItemNameState extends State<TodoCardBodyItemName> {
  bool isEditing = false;

  final myController = TextEditingController();
  final focusNode = FocusNode();

  void onChange() {
    widget.todo.text = myController.text;
  }

  @override
  void initState() {
    super.initState();
    myController.text = widget.todo.text;
    myController.addListener(onChange);
    focusNode.addListener(() {
      if (!focusNode.hasFocus && isEditing) {
        toggleEditing();
      }
    });
  }

  @override
  void dispose() {
    myController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  void toggleEditing() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  Future<void> requestContext(BuildContext context) async {
    FocusScope.of(context).requestFocus(focusNode);
  }

  @override
  Widget build(BuildContext context) {
    requestContext(context);
    if (isEditing) {
      return TextField(
        onEditingComplete: toggleEditing,
        controller: myController,
        focusNode: focusNode,
        style: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      );
    }
    return GestureDetector(
      onTap: toggleEditing,
      child: Text(
        widget.todo.text,
        style: TextStyle(
          decoration: widget.todo.done
              ? TextDecoration.combine([TextDecoration.lineThrough])
              : null,
        ),
      ),
    );
  }
}

class NewTodoForm extends StatefulWidget {
  @override
  _NewTodoFormState createState() => _NewTodoFormState();
}

class _NewTodoFormState extends State<NewTodoForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
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
