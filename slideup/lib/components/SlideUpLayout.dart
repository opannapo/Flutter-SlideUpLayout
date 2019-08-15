import 'dart:ui';

import 'package:flutter/material.dart';

enum BG_MODE { DEFAULT, BLUR }

class SlideUpLayout extends StatefulWidget {
  Widget childMain;
  Widget childSlidUp;
  Widget slideUpDragTitle;
  String title;

  double sliderThumbHeight;
  double dyDefault;
  bool isAnimRun = false;
  int speedUp;
  int speedDown;
  bool isDragUp;
  int dragMode = 0;
  double directStart = 0.0;
  double directEnd = 0.0;
  double maxTopMargin;
  BG_MODE mode;
  SlideUpViewCallback viewCallback;
  Key key;

  SlideUpLayout(
    this.key, {
    this.childMain,
    this.childSlidUp,
    this.slideUpDragTitle,
    this.title: '',
    this.sliderThumbHeight: 80,
    this.speedUp: 200,
    this.speedDown: 100,
    this.maxTopMargin: 100,
    this.mode: BG_MODE.BLUR,
    this.viewCallback,
  });

  @override
  State<StatefulWidget> createState() => new SlideUpViewState();
}

class SlideUpViewState extends State<SlideUpLayout> with TickerProviderStateMixin {
  double y = 0;
  AnimationController controller;
  Animation<double> position;

  @override
  void initState() {
    super.initState();
    y = widget.sliderThumbHeight;
    widget.isAnimRun = false;
    widget.isDragUp = false;
  }

  @override
  Widget build(BuildContext context) {
    return new Stack(
      children: <Widget>[
        new Container(
          child: widget.childMain,
        ),
        new Positioned(
            top: y == widget.sliderThumbHeight ? MediaQuery.of(context).size.height - y : y,
            left: 0,
            right: 0,
            child: new Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: new Column(
                children: <Widget>[
                  new GestureDetector(
                    onTap: () {},
                    onVerticalDragStart: (dStart) {
                      onVerticalDragStart(dStart);
                    },
                    onVerticalDragUpdate: (dUpdate) {
                      onVerticalDragUpdate(dUpdate);
                    },
                    onVerticalDragEnd: (dEnd) {
                      onVerticalDragEnd(dEnd);
                    },
                    child: new Container(
                      width: MediaQuery.of(context).size.width,
                      height: widget.sliderThumbHeight,
                      color: Colors.transparent,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: widget.slideUpDragTitle == null
                          ? new Container(
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                              ),
                              child: new Center(
                                child: new Column(
                                  children: <Widget>[
                                    IconButton(
                                      icon: new Icon(
                                        Icons.drag_handle,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {},
                                      iconSize: 15,
                                    ),
                                    widget.title.length > 0
                                        ? new Text(
                                            widget.title,
                                            style: TextStyle(fontSize: 16, color: Colors.black),
                                          )
                                        : new Container(),
                                  ],
                                ),
                              ),
                            )
                          : widget.slideUpDragTitle,
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    color: Colors.grey.shade200.withOpacity(0.8),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height -
                        widget.maxTopMargin -
                        widget.sliderThumbHeight,
                    child: widget.childSlidUp,
                  ),
                ],
              ),
            )),
      ],
    );
  }

  void onVerticalDragStart(DragStartDetails d) {
    widget.directStart = d.globalPosition.direction;
  }

  void onVerticalDragEnd(DragEndDetails d) {
    double yCur = y;
    if (!widget.isAnimRun) {
      releaseAnim(widget.speedUp);
      if (widget.directStart > widget.directEnd) {
        //up
        position = new Tween(begin: yCur, end: widget.maxTopMargin).animate(controller)
          ..addStatusListener((state) {
            print('$this StatusListener ScrollUP $state');
            if (state == AnimationStatus.completed) {
              disposeAnim();
              widget.viewCallback?.onOpen();
            }
          });
      } else {
        //down
        position = new Tween(begin: yCur, end: (widget.dyDefault - widget.sliderThumbHeight))
            .animate(controller)
              ..addStatusListener((state) {
                print('$this StatusListener ScrollDown $state');
                if (state == AnimationStatus.completed) {
                  disposeAnim();
                  widget.viewCallback?.onClose();
                }
              });
      }
      controller.forward();
    }
  }

  void onVerticalDragUpdate(DragUpdateDetails d) {
    print(
        '$this onVerticalDragUpdate ${d.globalPosition.dy}  widget.dyDefault:${widget.dyDefault}');
    double dy = d.globalPosition.dy;
    widget.dyDefault = MediaQuery.of(context).size.height;
    double dyPlusThumb = dy + widget.sliderThumbHeight;
    widget.directEnd = d.globalPosition.direction;

    //widget.viewCallback?.onDrag(dy);

    if (dyPlusThumb < widget.dyDefault) {
      setState(() {
        y = dy;
      });
    }
  }

  void releaseAnim(int speedVal) {
    widget.isAnimRun = true;
    controller = AnimationController(duration: Duration(milliseconds: speedVal), vsync: this);
    controller.addListener(() {
      setState(() {
        y = position.value;
      });
    });
  }

  void disposeAnim() {
    controller.dispose();
    widget.isAnimRun = false;
  }

  void open({double top}) {
    onVerticalDragUpdate(new DragUpdateDetails(
      globalPosition: Offset(0, top ?? widget.maxTopMargin),
    ));
  }

  void openWithAnim() {
    setState(() {
      widget.directStart = 1;
      widget.directEnd = 0;
    });
    onVerticalDragEnd(new DragEndDetails());
  }
}

abstract class SlideUpViewCallback {
  void onOpen();

  void onClose();
}
