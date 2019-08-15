import 'package:rxdart/rxdart.dart';

abstract class BaseBloc {
  final BehaviorSubject<bool> _unAuth = BehaviorSubject<bool>();

  BehaviorSubject<bool> get unAuth => _unAuth;

  void dispose() {
    _unAuth.close();
  }
}
