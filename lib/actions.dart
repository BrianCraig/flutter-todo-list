import 'package:flutter/material.dart';

import 'model/model.dart';
import 'screens/category_screen.dart';
import 'screens/todo_screen.dart';

void goToCategory(BuildContext context, TodoCategory category) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CategoryScreen(category: category)));
}

void addNewCategory(BuildContext context, AppState appState) {
  TodoCategory category = new TodoCategory("Category");
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => CategoryScreen(category: category)));
}

void addNewTodo(BuildContext context, TodoCategory category) {
  Todo todo = new Todo("New ToDo");
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => TodoScreen(
          todo: todo, onDelete: () {}, onSave: () => category.todos.add(todo)),
    ),
  );
}

void goToTodo(BuildContext context, TodoCategory category, Todo todo) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) =>
          TodoScreen(todo: todo, onDelete: () => category.todos.remove(todo), onSave: () {}, hasDelete: true),
    ),
  );
}

void goBack(BuildContext context) {
  Navigator.pop(context);
}
