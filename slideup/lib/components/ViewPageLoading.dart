import 'package:flutter/material.dart';
import 'package:slideup/base/R.dart';

class ViewPageLoading extends StatelessWidget {
  final String label;
  final double opacity;

  ViewPageLoading(this.label, {this.opacity: 0.5});

  @override
  Widget build(BuildContext ctx) {
    return new Center(
        child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Text(
          '$label',
          style: Style.textSmallBold(),
        ),
        new Center(
            child: new Container(
          width: 20,
          height: 20,
          child: new CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(ColorsBase.base),
          ),
        )),
      ],
    ));
  }
}
