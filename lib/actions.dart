import 'package:flutter/material.dart';

import 'screens/category_screen.dart';

void goToCategory (BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CategoryScreen())
  );
}