import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../actions.dart';
import '../model/model.dart';
import '../ui/style_constants.dart';

class TodoScreen extends StatelessWidget {

  final Todo todo;

  TodoScreen({Key key, this.todo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
      ),
      body: TodoForm(todo: todo),
    );
  }
}

class TodoForm extends StatefulWidget {

  final Todo todo;

  TodoForm({Key key, this.todo}) : super(key: key);

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
              Checkbox(
                value: this.done,
                onChanged: (bool done) {
                  _done = done;
                  setState(() {});
                },
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
        new RaisedButton(
          child: Text('Delete'),
          onPressed:() => goBack(context),
          color: Theme.of(context).accentColor,
        ),
        new RaisedButton(
          child: Text('Save'),
          onPressed: () {
            widget.todo.text = this.text;
            widget.todo.done = this.done;
            goBack(context);
          },
          color: Theme.of(context).accentColor,
        ),
      ],
    );
  }
}
