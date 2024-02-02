import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Routes {
  static final key = GlobalKey<NavigatorState>();

  static push({
    required var screen,
    required FutureOr<void> Function(dynamic) action,
  }) {
    key.currentState
        ?.push(
          Platform.isIOS
              ? CupertinoPageRoute(
                  builder: (context) => screen,
                )
              : PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 100),
                  transitionsBuilder: (
                    BuildContext context,
                    Animation<double> animation,
                    Animation<double> secondaryAnimation,
                    Widget child,
                  ) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return screen;
                  },
                ),
        )
        .then(action);
  }

  static back() {
    key.currentState?.pop();
  }

  static pushReplace({required var screen}) {
    key.currentState?.pushReplacement(
      Platform.isIOS
          ? MaterialPageRoute(
              builder: (context) => screen,
            )
          : PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 100),
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return screen;
              },
            ),
    );
  }

  static pushRemoveUntil({required var screen}) {
    key.currentState?.pushAndRemoveUntil(
      Platform.isIOS
          ? MaterialPageRoute(
              builder: (context) => screen,
            )
          : PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 100),
              transitionsBuilder: (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return screen;
              },
            ),
      (route) => false,
    );
  }
}
