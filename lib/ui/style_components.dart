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
  Widget build(BuildContext context) {
    return DecoratedBox(
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
    return Text(
      this.text,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: this.color,
      ),
    );
  }
}

class RefreshOnMessage extends StatelessWidget {
  final Widget child;
  final Stream<dynamic> stream;

  const RefreshOnMessage({
    Key key,
    @required this.stream,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      builder: (BuildContext _b, AsyncSnapshot<dynamic> _a) {
        print(_a);
        return child;
      },
      stream: this.stream,
    );
  }
}
