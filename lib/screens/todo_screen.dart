import 'package:flutter/material.dart';

import '../actions.dart';
import '../model/model.dart';
import '../ui/style_constants.dart';

class TodoScreen extends StatelessWidget {
  final Todo todo;
  final Function onDelete, onSave;
  final bool hasDelete;

  TodoScreen({Key key, this.todo, this.onDelete, this.onSave, this.hasDelete = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: TodoForm(todo: todo, onDelete: onDelete, onSave: onSave, hasDelete: hasDelete),
    );
  }
}

class TodoForm extends StatefulWidget {
  final Todo todo;
  final Function onDelete, onSave;
  final bool hasDelete;

  TodoForm({Key key, this.todo, this.onDelete, this.onSave, this.hasDelete}) : super(key: key);

  @override
  _TodoFormState createState() => _TodoFormState();
}

class _TodoFormState extends State<TodoForm> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  String _text;
  bool _done;

  get done => _done ?? widget.todo.done;

  get text => _text ?? widget.todo.text;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              buildText(),
              Padding(
                padding: DefaultStyle.padding(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Already done"),
                    Switch(
                      value: this.done,
                      onChanged: (bool done) {
                        _done = done;
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        buildButtons(context),
      ],
    );
  }

  Widget buildText() {
    return Padding(
      padding: DefaultStyle.padding(),
      child: TextFormField(
        decoration: InputDecoration(labelText: "Description"),
        maxLength: widget.todo.maxTextLength,
        initialValue: this.text,
        onFieldSubmitted: (String value) {
          _text = value;
        },
      ),
    );
  }

  Widget buildButtons(BuildContext context) {
    return ButtonBar(
      children: <Widget>[
        widget.hasDelete ? buildDeleteButton(context) : Container(),
        new RaisedButton(
          child: Text('Save'),
          onPressed: () {
            widget.todo.text = this.text;
            widget.todo.done = this.done;
            widget.onSave();
            goBack(context);
          },
          color: Theme.of(context).accentColor,
        ),
      ],
    );
  }

  RaisedButton buildDeleteButton(BuildContext context) {
    return new RaisedButton(
        child: Text('Delete'),
        onPressed: () {
          widget.onDelete();
          goBack(context);

          },
          color: Theme.of(context).accentColor,
      );
  }
}
