import 'package:flutter/material.dart';
import 'package:slideup/base/BaseBloc.dart';
import 'package:slideup/base/BasePageStateMixin.dart';
import 'package:slideup/base/R.dart';

class HomeTabExplore extends StatefulWidget {
  const HomeTabExplore(this.cntTab, {Key key}) : super(key: key);

  final TabController cntTab;

  @override
  State createState() => HomeTabExploreState();
}

class HomeTabExploreState extends BasePageStateMixin<HomeTabExplore, BaseBloc> {
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
          ' - EXPLORE -',
          style: Style.textBigXXBold(letterSpacing: 5, color: ColorsBase.blackX),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  BaseBloc thisBloc() => null;
}
