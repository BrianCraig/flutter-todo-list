import 'package:flutter/material.dart';

import './style_constants.dart';

class BoxStyledComponent extends StatelessWidget {
  final Widget child;
  final Color color;

  BoxStyledComponent({
    Key key,
    this.child,
    this.color,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) =>
    DecoratedBox(
      child: Padding(
        padding: DefaultStyle.padding(),
        child: this.child,
      ),
      decoration: BoxDecoration(
          color: this.color,
          borderRadius: DefaultStyle.border(),
      ),
    );
}

class TitleStyledComponent extends StatelessWidget {
  final Color color;
  final String text;

  const TitleStyledComponent({
    Key key,
    this.color = Colors.white,
    this.text = "",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(this.text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: this.color,
      ),
    );
  }
}
