import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:slideup/base/BasePageStateMixin.dart';
import 'package:slideup/base/R.dart';
import 'package:slideup/components/BookmarkItem.dart';
import 'package:slideup/components/SlideUpLayout.dart';
import 'package:slideup/controller/bloc/HomeBloc.dart';
import 'package:slideup/controller/vact/HomeAction.dart';
import 'package:slideup/entities/PropertyEntity.dart';

import 'HomeTabExplore.dart';
import 'HomeTabHome.dart';
import 'HomeTabNotification.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  State createState() => HomeState();
}

class HomeState extends BasePageStateMixin<Home, HomeBloc>
    with HomeAction, SingleTickerProviderStateMixin {
  final HomeBloc bloc = new HomeBloc();
  final homeKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<SlideUpViewState> slideUpLayoutKey = new GlobalKey<SlideUpViewState>();

  final List<GlobalKey<BasePageStateMixin>> _keyPage = [GlobalKey(), GlobalKey(), GlobalKey()];

  final double sliderThumbHeight = 70;
  final double maxTopMargin = 80;

  ScrollController bookmarkListCnt;
  TabController cntTab;
  bool isMenuOpen = false;

  @override
  HomeBloc thisBloc() => bloc;

  @override
  HomeState actionState() => this;

  @override
  bool keepAlive() => true;

  @override
  void dis() {
    eventDispose();
    bookmarkListCnt.dispose();
    bloc.dispose();
  }

  @override
  void init() {
    bookmarkListCnt = new ScrollController();
    cntTab = new TabController(initialIndex: 0, length: 3, vsync: this);
    cntTab.addListener(this.eventTabListener);
  }

  @override
  void onBuildComplete(BuildContext context) {
    eventFirstLoad();
  }

  @override
  Widget rootView(BuildContext context) {
    return new Scaffold(
      key: homeKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: ColorsBase.whiteGrey,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: new SlideUpLayout(
          slideUpLayoutKey,
          childMain: body(),
          childSlidUp: childSlideUp(),
          slideUpDragTitle: slideUpDragTitle(),
          maxTopMargin: maxTopMargin,
          sliderThumbHeight: sliderThumbHeight,
          speedUp: 200,
          speedDown: 200,
          mode: BG_MODE.BLUR,
          title: 'Around You',
          viewCallback: this,
        ),
      ),
    );
  }

  Widget body() {
    return new TabBarView(
      key: new Key("Tab"),
      controller: cntTab,
      children: <Widget>[
        new HomeTabHome(cntTab, key: _keyPage[0]),
        new HomeTabExplore(cntTab, key: _keyPage[1]),
        new HomeTabNotification(cntTab, key: _keyPage[2]),
      ],
    );
  }

  Widget slideUpDragTitle() {
    return new StreamBuilder<bool>(
        key: new Key("HomeSlideUpTitle"),
        stream: slideUpSc,
        initialData: false,
        builder: (context, slideUp) {
          return new Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.fromLTRB(1, 0, 1, 0),
            decoration: new BoxDecoration(
                color: ColorsBase.white,
                borderRadius:
                    BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
                border: Border.all(color: ColorsBase.black.withOpacity(0.1), width: 1)),
            child: new StreamBuilder<int>(
                stream: activeMenuSc,
                initialData: 0,
                builder: (context, menu) {
                  return new Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                          height: 5,
                          width: 50,
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                          decoration: new BoxDecoration(
                              color: ColorsBase.whiteGrey,
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  color: ColorsBase.second.withOpacity(0.4), width: 0.5)),
                        ),
                        new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new GestureDetector(
                              onTap: () => menuHomeClick(MENU_HOME),
                              child: new Icon(
                                Icons.home,
                                color: menu.data == MENU_HOME
                                    ? ColorsBase.second
                                    : ColorsBase.grayDisable,
                                size: 26,
                              ),
                            ),
                            new GestureDetector(
                              onTap: () => menuHomeClick(MENU_EXPLORE),
                              child: new Icon(
                                Icons.explore,
                                color: menu.data == MENU_EXPLORE
                                    ? ColorsBase.second
                                    : ColorsBase.grayDisable,
                                size: 26,
                              ),
                            ),
                            new GestureDetector(
                              onTap: () => menuHomeClick(MENU_NOTIF),
                              child: new Icon(
                                Icons.notifications_active,
                                color: menu.data == MENU_NOTIF
                                    ? ColorsBase.second
                                    : ColorsBase.grayDisable,
                                size: 26,
                              ),
                            ),
                            new GestureDetector(
                              onTap: () => menuHomeClick(MENU_UP),
                              child: new Icon(
                                Icons.face,
                                color: slideUp.data ? ColorsBase.baseRed : ColorsBase.grayDisable,
                                size: 26,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
          );
        });
  }

  Widget childSlideUp() {
    return new SingleChildScrollView(
        key: new Key("HomeSlideUp"),
        scrollDirection: Axis.vertical,
        physics: ClampingScrollPhysics(),
        child: new Container(
            child: new BackdropFilter(
                filter: new ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                child: new Container(
                  child: new Column(
                    children: <Widget>[
                      new Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            new Icon(
                              Icons.bookmark,
                              color: ColorsBase.base,
                              size: 24,
                            ),
                            new Container(
                              width: 0,
                              height: 0,
                            ),
                            new Text(
                              "Bookmark",
                              style: Style.textBigXBold(letterSpacing: 2, color: ColorsBase.base),
                            ),
                          ],
                        ),
                      ),
                      bookmarkContent(),
                    ],
                  ),
                ))));
  }

  Widget bookmarkContent() {
    return new StreamBuilder<List<PropertyEntity>>(
        stream: bloc?.bookmarkItemSc?.stream,
        builder: (BuildContext context, AsyncSnapshot<List<PropertyEntity>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return new Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: new Container(
                    child: new ListView.builder(
                        controller: bookmarkListCnt,
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          PropertyEntity entity = snapshot.data[index];
                          return new Container(
                            margin: EdgeInsets.fromLTRB(10, 0, 0, 20),
                            child: new Hero(
                              tag: 'PropertyEntity-${index}',
                              child: new BookmarkItem(entity, () {}),
                            ),
                          );
                        }),
                  ));
            } else {
              return new Container();
            }
          } else {
            return new Container();
          }
        });
  }
}
