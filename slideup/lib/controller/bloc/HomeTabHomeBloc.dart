import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:slideup/base/BaseBloc.dart';
import 'package:slideup/entities/PropertyEntity.dart';

class HomeTabHomeBloc extends BaseBloc {
  static final HomeTabHomeBloc instance = new HomeTabHomeBloc();
  final BehaviorSubject<List<PropertyEntity>> _topItemSc = BehaviorSubject<List<PropertyEntity>>();

  BehaviorSubject<List<PropertyEntity>> get topItemSc => _topItemSc;

  void dispose() {
    _topItemSc.close();
  }

  Future doGetTopItems(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/data/data_3.json");
    final jsonResult = json.decode(data);

    var items = jsonResult['list'] as List;
    List<PropertyEntity> list = items.map((data) => new PropertyEntity.fromJson(data)).toList();

    topItemSc.sink.add(list);
  }
}
