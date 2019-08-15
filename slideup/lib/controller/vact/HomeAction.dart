import 'package:rxdart/rxdart.dart';
import 'package:slideup/components/SlideUpLayout.dart';
import 'package:slideup/views/Home.dart';

abstract class HomeAction<S extends HomeState> implements SlideUpViewCallback {
  S get state => actionState();

  S actionState();

  final BehaviorSubject<int> _activeMenuSc = BehaviorSubject<int>();
  final BehaviorSubject<bool> _slideUpSc = BehaviorSubject<bool>();

  BehaviorSubject<int> get activeMenuSc => _activeMenuSc;

  BehaviorSubject<bool> get slideUpSc => _slideUpSc;

  final int MENU_HOME = 0;
  final int MENU_EXPLORE = 1;
  final int MENU_NOTIF = 2;
  final int MENU_UP = 3;
  final int MENU_SETTING = 4;
  final int MENU_LOVE = 5;

  void eventFirstLoad() {
    state.bloc.doGetBookmark(state.context);
  }

  @override
  void onClose() {
    state.isMenuOpen = false;
    slideUpSc.sink.add(false);
  }

  @override
  void onOpen() {
    state.isMenuOpen = true;
    slideUpSc.sink.add(true);
    state.bloc.doGetBookmark(state.context);
  }

  void menuHomeClick(int menu) {
    if (state.isMenuOpen) return;
    if (_activeMenuSc.value == menu) return;

    if (menu == MENU_UP) {
      state.slideUpLayoutKey.currentState.openWithAnim();
    } else {
      _activeMenuSc.sink.add(menu);
      if (menu == MENU_HOME) {
        state.cntTab.index = 0;
      }
      if (menu == MENU_EXPLORE) {
        state.cntTab.index = 1;
      }
      if (menu == MENU_NOTIF) {
        state.cntTab.index = 2;
      }
      if (menu == MENU_SETTING) {}
    }
  }

  void eventTabListener() {
    menuHomeClick(state.cntTab.index);
  }

  void eventDispose() {
    _activeMenuSc.close();
    _slideUpSc.close();
  }
}
