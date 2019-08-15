import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:slideup/base/BasePageStateMixin.dart';
import 'package:slideup/base/R.dart';
import 'package:slideup/components/SuggestedItem.dart';
import 'package:slideup/components/ViewPageLoading.dart';
import 'package:slideup/controller/bloc/HomeTabHomeBloc.dart';
import 'package:slideup/controller/vact/HomeTabHomeAction.dart';
import 'package:slideup/entities/PropertyEntity.dart';

class HomeTabHome extends StatefulWidget {
  const HomeTabHome(this.cntTab, {Key key}) : super(key: key);

  final TabController cntTab;

  @override
  State createState() => HomeTabHomeState();
}

class HomeTabHomeState extends BasePageStateMixin<HomeTabHome, HomeTabHomeBloc>
    with HomeTabHomeAction<HomeTabHomeState>, SingleTickerProviderStateMixin {
  final homeTabHomeKey = new GlobalKey<ScaffoldState>();
  final HomeTabHomeBloc bloc = new HomeTabHomeBloc();
  final Key content1ListKey = new GlobalKey();

  final TextEditingController cntKeySearcy = new TextEditingController();
  ScrollController top1ListCnt;
  Animation<double> animSearch;
  Animation<double> animSearchOpacity;
  AnimationController controller;

  @override
  HomeTabHomeBloc thisBloc() => bloc;

  @override
  HomeTabHomeState actionState() => this;

  @override
  void dis() {
    cntKeySearcy.dispose();
    top1ListCnt.dispose();
    animSearchVal.close();
    animOpacityVal.close();
    bloc.dispose();
  }

  @override
  void init() {
    top1ListCnt = new ScrollController();
    cntKeySearcy.addListener(textSearchListener);
  }

  @override
  bool keepAlive() => true;

  @override
  void onBuildComplete(BuildContext context) {
    eventFirstLoad();
  }

  @override
  Widget rootView(BuildContext context) {
    return new Scaffold(
      key: homeTabHomeKey,
      resizeToAvoidBottomPadding: false,
      body: new Container(
        key: new Key("HomeTabRoot"),
        child: new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: BouncingScrollPhysics(),
          child: new Container(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                header(),
                new Container(
                    padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    width: MediaQuery.of(context).size.width,
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          'DEMO',
                          style:
                          Style.textBigXXBold(letterSpacing: 5, color: ColorsBase.second),
                          textAlign: TextAlign.start,
                        ),
                        new Row(
                          children: <Widget>[
                            new Text(
                              'SlideUpPanel',
                              style:
                                  Style.textBigXXBold(letterSpacing: 1, color: ColorsBase.second),
                              textAlign: TextAlign.start,
                            ),
                            new Text(
                              ' LAYOUT',
                              style:
                                  Style.textBigXXBold(letterSpacing: 10, color: ColorsBase.blackX),
                              textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ],
                    )),
                searchArea(),
                new Divider(
                  height: 20,
                  color: Colors.transparent,
                ),
                topContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget header() {
    return new Container(
      key: new Key("HomeTabHeader"),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
      child: new Hero(
          tag: 'icon_logo',
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Image(
                image: new AssetImage(IcNav.ic_logo_150),
                color: Colors.black,
                width: 30,
                height: 30,
              ),
              new Text(
                ' - https://github.com/opannapo -',
                style: Style.textSmallBold(letterSpacing: 4, color: ColorsBase.blackX),
                textAlign: TextAlign.center,
              ),
            ],
          )),
    );
  }

  Widget searchArea() {
    return new Container(
        key: new Key("HomeTabSearch"),
        width: MediaQuery.of(context).size.width,
        height: 40,
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Flexible(
              fit: FlexFit.loose,
              flex: 100,
              child: new Container(
                padding: EdgeInsets.all(0),
                height: 40,
                decoration: new BoxDecoration(
                  borderRadius: new BorderRadius.circular(20.0),
                  color: ColorsBase.black,
                ),
                child: new Stack(
                  children: <Widget>[
                    new Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        left: 0,
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            StreamBuilder<double>(
                                stream: animSearchVal.stream,
                                initialData: (MediaQuery.of(context).size.width - 40),
                                builder: (context, snapshot) {
                                  return new Container(
                                    height: 40,
                                    //width: animSearch?.value ?? (MediaQuery.of(context).size.width - 40),
                                    width: snapshot.data,
                                    decoration: new BoxDecoration(
                                      borderRadius: new BorderRadius.circular(50.0),
                                      color: ColorsBase.second,
                                    ),
                                  );
                                }),
                          ],
                        )),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Flexible(
                          fit: FlexFit.tight,
                          flex: 90,
                          child: new Container(
                              alignment: Alignment.centerLeft,
                              height: 40,
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: new TextField(
                                style: Style.textMediumBold(color: Colors.white),
                                controller: cntKeySearcy,
                                cursorColor: ColorsBase.white,
                                decoration: InputDecoration.collapsed(
                                    hintText: 'Search ...',
                                    hintStyle:
                                        Style.textMediumBold(color: ColorsBase.whiteDisable)),
                              )),
                        ),
                        new Flexible(
                            fit: FlexFit.tight,
                            flex: 10,
                            child: StreamBuilder<double>(
                                stream: animOpacityVal.stream,
                                initialData: 0.2,
                                builder: (context, snapshot) {
                                  return new GestureDetector(
                                    onTap: () {},
                                    child: new Icon(
                                      Icons.search,
                                      size: 20,
                                      //color: Colors.white.withOpacity(animSearchOpacity?.value ?? 0.2),
                                      color: Colors.white.withOpacity(snapshot.data),
                                    ),
                                  );
                                })),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }

  Widget topContent() {
    return new StreamBuilder<List<PropertyEntity>>(
        key: content1ListKey,
        stream: bloc?.topItemSc?.stream,
        builder: (BuildContext context, AsyncSnapshot<List<PropertyEntity>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              return new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        new Text(
                          'Top Items',
                          style: Style.textBigBold(letterSpacing: 2, color: ColorsBase.black),
                          textAlign: TextAlign.start,
                        ),
                        new Text(
                          'Show All',
                          style: Style.textMedium(letterSpacing: 1, color: ColorsBase.black),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                  ),
                  new Container(
                      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: new Container(
                        constraints: BoxConstraints.expand(width: double.infinity, height: 400),
                        child: new ListView.builder(
                            controller: top1ListCnt,
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: snapshot.data.length,
                            itemBuilder: (BuildContext context, int index) {
                              PropertyEntity entity = snapshot.data[index];
                              return new Container(
                                margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                child: new Hero(
                                  tag: 'PropertyEntity-${index}',
                                  child: new SuggestedItem(entity, () {}),
                                ),
                              );
                            }),
                      )),
                ],
              );
            } else {
              return new Container();
            }
          } else {
            return new Container(
              width: MediaQuery.of(context).size.width,
              height: 400,
              child: new ViewPageLoading(''),
            );
          }
        });
  }
}
