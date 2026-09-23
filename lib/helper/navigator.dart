import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import 'package:samseer/samseer.dart';

import '../config/di/di.dart';
import '../shared/widget/dialog/loading_dialog.dart';

final samseer = Samseer();
final navigator = getIt<AppNavigator>();

@lazySingleton
class AppNavigator {
  GlobalKey<NavigatorState> get navigatorKey => samseer.navigatorKey;
  BuildContext get context => navigatorKey.currentContext!;

  Future<dynamic> push(Widget destination) => navigatorKey.currentState!.push(
    MaterialPageRoute(builder: (context) => destination),
  );

  Future<dynamic> pushReplacement(Widget destination) => navigatorKey
      .currentState!
      .pushReplacement(MaterialPageRoute(builder: (context) => destination));

  Future<dynamic> pushAndRemoveUntil(Widget destination) =>
      navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => destination),
        (route) => false,
      );

  void popAndPush(Widget destination) {
    pop();
    push(destination);
  }

  void pop<T>({int popCount = 1, T? result}) {
    if (popCount == 1) {
      if (result != null) {
        navigatorKey.currentState!.pop(result);
      } else {
        navigatorKey.currentState!.pop();
      }
    } else {
      var count = 0;
      navigatorKey.currentState!.popUntil((route) {
        return count++ == popCount;
      });
    }
  }

  void popUntilFirst() =>
      navigatorKey.currentState!.popUntil((route) => route.isFirst);

  void showLoadingDialog() => showDialog(content: const LoadingDialog());

  void showDialog({required Widget content}) {
    showGeneralDialog(
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (val, result) async => false,
          child: const SizedBox(),
        );
      },
      transitionBuilder: (context, a1, a2, widget) {
        return PopScope(
          canPop: false,
          onPopInvokedWithResult: (val, result) async => false,
          child: Transform.scale(
            scale: a1.value,
            child: Opacity(opacity: a1.value, child: content),
          ),
        );
      },
      barrierDismissible: true,
      barrierLabel: "",
    );
  }

  // void showDefaultModalBottom({
  //   String? illustration,
  //   String? title,
  //   String? message,
  //   String? buttonTitle,
  //   Function()? onPressed,
  //   bool isDismissible = true,
  //   bool showCloseButton = false,
  //   Function()? onComplete,
  //   Function()? onBackButton,
  //   Function()? onCloseButton,
  // }) {
  //   showModalBottom(
  //     isDismissible: isDismissible,
  //     content: PopScope(
  //       onPopInvoked: onBackButton?.call(),
  //       child: DefaultModal(
  //         illustration: illustration,
  //         title: title,
  //         message: message,
  //         buttonTitle: buttonTitle,
  //         onPressed: onPressed,
  //         showCloseButton: showCloseButton,
  //         onCloseButton: onCloseButton,
  //       ),
  //     ),
  //   );
  // }

  Future<T?> showModalBottom<T>({
    bool isDismissible = true,
    bool keyboardPush = false,
    required Widget content,
    Function()? onComplete,
  }) async {
    final result = await showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible,
      enableDrag: isDismissible,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      builder: (context) => keyboardPush
          ? Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: content,
            )
          : content,
    );
    await Future.delayed(const Duration(milliseconds: 400));
    onComplete?.call();
    return result;
  }
}
