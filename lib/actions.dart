import 'package:flutter/material.dart';

import 'screens/category_screen.dart';
import 'model/model.dart';

void goToCategory (BuildContext context, TodoCategory category) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CategoryScreen(category: category))
  );
}

void goBack (BuildContext context) {
  Navigator.pop(context);
}