import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:slideup/views/HomeTabHome.dart';

abstract class HomeTabHomeAction<S extends HomeTabHomeState> {
  S get state => actionState();

  S actionState();

  final BehaviorSubject<double> animSearchVal = BehaviorSubject<double>();
  final BehaviorSubject<double> animOpacityVal = BehaviorSubject<double>();

  Future eventFirstLoad() async {
    return new Future.delayed(Duration(milliseconds: 500)).then((val) async {
      state.bloc.doGetTopItems(state.context);
    });
  }

  void textSearchListener() {
    print('$this textSearchListener ${state.cntKeySearcy.text}');
    if (state.cntKeySearcy.text.isNotEmpty) {
      runSearchAnim(true);
    } else {
      runSearchAnim(false);
    }
  }

  void runSearchAnim(bool open) {
    double maxWidth = MediaQuery.of(state.context).size.width - 40;
    double minWidth = 40.0;

    if (state.controller == null) {
      state.controller =
          AnimationController(duration: const Duration(milliseconds: 500), vsync: state);
      state.animSearch = Tween<double>(begin: maxWidth, end: minWidth).animate(
        new CurvedAnimation(
          parent: state.controller,
          curve: new Interval(
            0.0,
            0.2,
          ),
        ),
      );
      state.animSearchOpacity = Tween<double>(begin: 0.2, end: 1).animate(
        new CurvedAnimation(
          parent: state.controller,
          curve: new Interval(
            0.4,
            1.0,
          ),
        ),
      );
      state.controller.addListener(() {
        animSearchVal.sink.add(state.animSearch.value);
        animOpacityVal.sink.add(state.animSearchOpacity.value);
      });
    }

    if (open) {
      if (state.animSearch.value < 50) return;
      print(
          "runSearchAnim forward ${state.animSearch.value} , STATUS : ${state.animSearch.status}");
      state.controller.forward();
    } else {
      print(
          "runSearchAnim reverse ${state.animSearch.value} , STATUS : ${state.animSearch.status}");
      if (state.animSearch.value != null) state.controller.reverse();
    }
  }
}
