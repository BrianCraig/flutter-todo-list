import 'package:flutter/material.dart';

import '../actions.dart';
import '../model/model.dart';
import '../ui/style_constants.dart';

class CategoryScreen extends StatelessWidget {
  final TodoCategory category;

  CategoryScreen({Key key, this.category}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Category"),
      ),
      body: FormKey(
        category: category,
      ),
    );
  }
}

class FormKey extends StatefulWidget {
  final TodoCategory category;

  FormKey({Key key, this.category}) : super(key: key);

  @override
  _FormKeyState createState() => _FormKeyState();
}

class _FormKeyState extends State<FormKey> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CategoryForm(
      formKey: _formKey,
      category: widget.category,
    );
  }
}

class CategoryForm extends StatefulWidget {

  final GlobalKey<FormState> formKey;
  final TodoCategory category;

  CategoryForm({Key key, this.formKey, this.category}) : super(key: key);

  @override
  _CategoryFormState createState() => _CategoryFormState();
}

class _CategoryFormState extends State<CategoryForm> {

  String _title;

  get title => _title ?? widget.category.title;

  void submit(BuildContext context) {
    widget.category.title = this.title;
    goBack(context);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Container(
        color: Theme.of(context).backgroundColor.withOpacity(0.2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: DefaultStyle.padding(),
              child: TextFormField(
                decoration: InputDecoration(labelText: "Category name"),
                maxLength: widget.category.maxTitleLength,
                initialValue: widget.category.title,
                onFieldSubmitted: (String value) {
                  _title = value;
                },
              ),
            ),
            ButtonBar(
              children: [
                new RaisedButton(
                  child: Text('Delete'),
                  onPressed: () {},
                  color: Theme.of(context).accentColor,
                ),
                new RaisedButton(
                  child: Text('Save'),
                  onPressed: () => submit(context),
                ),
              ],
            ),
          ],
        ),
      ),
      key: widget.formKey,
    );
  }
}