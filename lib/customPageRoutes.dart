import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';

// 바운스 있게 페이지 전환 애니메이션 (테스트용. 실제로 쓸지는 모르겠네)
class BouncyPageRoute extends PageRouteBuilder{
  final Widget widget;

  BouncyPageRoute({this.widget})
    : super(
      transitionDuration: Duration(seconds: 1),
      transitionsBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secAnimation, Widget child){

        animation = CurvedAnimation(parent: animation, curve: Curves.elasticInOut);
        return ScaleTransition(alignment: Alignment.center, scale: animation, child: child,);
      },
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secAnimation){
        return widget;
      }
  );
}

// 페이드인 아웃 페이지 전환 애니메이션
class FadeInOutPageRoute<T> extends PageRoute<T>{
  final Widget child;

  FadeInOutPageRoute(this.child);

  @override
  Color get barrierColor =>  Colors.black;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
    return FadeTransition(opacity: animation, child: child);
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 300);
}

