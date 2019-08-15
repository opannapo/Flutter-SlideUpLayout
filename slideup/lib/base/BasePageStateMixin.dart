import 'package:flutter/material.dart';

import 'BaseBloc.dart';

abstract class BasePageStateMixin<T extends StatefulWidget, B extends BaseBloc> extends State<T>
    with AutomaticKeepAliveClientMixin {
  B thisBloc();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) => onBuildComplete(context));
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return rootView(context);
  }

  @override
  void dispose() {
    dis();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => keepAlive();

  bool keepAlive();

  void init();

  void onBuildComplete(BuildContext context);

  void dis();

  Widget rootView(BuildContext context);
}
