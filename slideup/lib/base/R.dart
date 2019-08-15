import 'package:flutter/material.dart';

class ColorsBase {
  static final Color base = const Color(0xFF4fa4c1);
  static final Color second = const Color(0xFF64b179);
  static final Color black = const Color(0xFF222222);
  static final Color blackX = const Color(0xFF000000);
  static final Color white = const Color(0xFFffffff);
  static final Color grayDisable = const Color(0xFF666666);
  static final Color whiteDisable = const Color(0xAAffffff);
  static final Color whiteGrey = const Color(0xFFefefef);
  static final Color baseRed = const Color(0xFFd71052);
  static final Color greenDark = const Color(0xFF4a8a5b);
}

class IcRoot {
  static final String logo_300 = "assets/logo_300.png";
}

class IcNav {
  static final String ic_logo_150 = "assets/ic_nav/ic_logo_150.png";
  static final String ic_logo_100 = "assets/ic_nav/ic_logo_100.png";
  static final String ic_logo_50 = "assets/ic_nav/ic_logo_50.png";
}

class Style {
  /*Normal 12*/
  static TextStyle textSmall({Color color, double letterSpacing: 1}) {
    return new TextStyle(
      color: color ?? ColorsBase.black,
      letterSpacing: letterSpacing,
      fontSize: 12,
      fontFamily: 'avenir',
    );
  }

  /*Normal 14*/
  static TextStyle textMedium({Color color, double letterSpacing: 1}) {
    return new TextStyle(
      color: color ?? ColorsBase.black,
      letterSpacing: letterSpacing,
      fontSize: 14,
      fontFamily: 'avenir',
    );
  }

  static TextStyle textBig({Color color, double letterSpacing: 1}) {
    return new TextStyle(
      color: color ?? ColorsBase.black,
      letterSpacing: letterSpacing,
      fontSize: 16,
      fontFamily: 'avenir',
    );
  }

  static TextStyle textSmallBold({Color color, double letterSpacing: 1}) {
    return new TextStyle(
      color: color ?? ColorsBase.black,
      letterSpacing: letterSpacing,
      fontSize: 12,
      fontFamily: 'avenir',
      fontWeight: FontWeight.bold,
    );
  }

  /*Normal 14*/
  static TextStyle textMediumBold({Color color, double letterSpacing: 1}) {
    return new TextStyle(
      color: color ?? ColorsBase.black,
      letterSpacing: letterSpacing,
      fontSize: 14,
      fontFamily: 'avenir',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textBigBold({Color color, double letterSpacing: 1}) {
    return new TextStyle(
      color: color ?? ColorsBase.black,
      letterSpacing: letterSpacing,
      fontSize: 16,
      fontFamily: 'avenir',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textBigXBold({Color color, double letterSpacing: 1}) {
    return new TextStyle(
      color: color ?? ColorsBase.black,
      letterSpacing: letterSpacing,
      fontSize: 20,
      fontFamily: 'avenir',
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle textBigXXBold({Color color, double letterSpacing: 1}) {
    return new TextStyle(
      color: color ?? ColorsBase.black,
      letterSpacing: letterSpacing,
      fontSize: 24,
      fontFamily: 'avenir',
      fontWeight: FontWeight.bold,
    );
  }
}

class Button {
  static Widget base(String text, double width, double height) {
    return new Container(
      margin: EdgeInsets.all(0),
      width: width,
      height: height,
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(50.0),
        color: Colors.white,
      ),
      child: new FlatButton(
        padding: const EdgeInsets.all(0.0),
        color: Colors.transparent,
        onPressed: () {},
        splashColor: ColorsBase.second,
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(50.0)),
        child: new Text(
          '$text',
          style: Style.textSmallBold(color: ColorsBase.blackX),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  static Widget baseBorderGreen(String text, double width, double height) {
    return new Container(
      margin: EdgeInsets.all(0),
      width: width,
      height: height,
      decoration: new BoxDecoration(
        borderRadius: new BorderRadius.circular(50.0),
        color: ColorsBase.white,
        border: Border.all(color: ColorsBase.second, width: 0.5),
      ),
      child: new FlatButton(
        padding: const EdgeInsets.all(0.0),
        color: Colors.transparent,
        onPressed: () {},
        splashColor: ColorsBase.second,
        shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(50.0)),
        child: new Text(
          '$text',
          style: Style.textSmallBold(color: ColorsBase.blackX),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
