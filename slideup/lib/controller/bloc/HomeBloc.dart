import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:slideup/base/BaseBloc.dart';
import 'package:slideup/entities/PropertyEntity.dart';

class HomeBloc extends BaseBloc {
  static final HomeBloc instance = new HomeBloc();

  final BehaviorSubject<List<PropertyEntity>> _bookmarkItemSc =
      BehaviorSubject<List<PropertyEntity>>();

  BehaviorSubject<List<PropertyEntity>> get bookmarkItemSc => _bookmarkItemSc;

  void dispose() {
    _bookmarkItemSc.close();
  }

  Future doGetBookmark(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/data/data_3.json");
    final jsonResult = json.decode(data);

    var items = jsonResult['list'] as List;
    List<PropertyEntity> list = items.map((data) => new PropertyEntity.fromJson(data)).toList();

    _bookmarkItemSc.sink.add(list);
  }
}
