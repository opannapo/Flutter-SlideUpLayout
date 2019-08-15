import 'package:flutter/material.dart';
import 'package:slideup/base/BaseBloc.dart';
import 'package:slideup/base/BasePageStateMixin.dart';
import 'package:slideup/base/R.dart';

class HomeTabNotification extends StatefulWidget {
  const HomeTabNotification(this.cntTab, {Key key}) : super(key: key);

  final TabController cntTab;

  @override
  State createState() => HomeTabNotificationState();
}

class HomeTabNotificationState extends BasePageStateMixin<HomeTabNotification, BaseBloc> {
  @override
  void dis() {}

  @override
  void init() {}

  @override
  bool keepAlive() => false;

  @override
  void onBuildComplete(BuildContext context) {}

  @override
  Widget rootView(BuildContext context) {
    return new Container(
      color: ColorsBase.white,
      child: Center(
        child: new Text(
          ' - NOTIFICATION\'s -',
          style: Style.textBigXXBold(letterSpacing: 5, color: ColorsBase.blackX),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  BaseBloc thisBloc() => null;
}
