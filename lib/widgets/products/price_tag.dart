import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget {
  final String text;

  PriceTag(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: BorderRadius.circular(5.0)),
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ));
  }
}
