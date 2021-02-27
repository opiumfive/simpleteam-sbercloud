import 'dart:async';

import 'package:sbercloud_flutter/ui/toast_animation.dart';
import 'package:flutter/material.dart';

class ToastUtils {
  static Timer toastTimer;
  static OverlayEntry _overlayEntryRed;
  static OverlayEntry _overlayEntryGreen;

  static void showToastError(BuildContext context,
      String message) {

    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntryRed = createOverlayEntry(context, message, Color(0xffe53e3f));
      Overlay.of(context).insert(_overlayEntryRed);
      toastTimer = Timer(Duration(seconds: 2), () {
        if (_overlayEntryRed != null) {
          _overlayEntryRed.remove();
        }
      });
    }

  }

  static void showToastInfo(BuildContext context,
      String message) {

    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntryGreen = createOverlayEntry(context, message, Color(0xFF07E897));
      Overlay.of(context).insert(_overlayEntryGreen);
      toastTimer = Timer(Duration(seconds: 2), () {
        if (_overlayEntryRed != null) {
          _overlayEntryGreen.remove();
        }
      });
    }

  }

  static OverlayEntry createOverlayEntry(BuildContext context,
      String message, Color color) {

    return OverlayEntry(
        builder: (context) => Positioned(
          top: 50.0,
          width: MediaQuery.of(context).size.width - 20,
          left: 10,
          child: ToastMessageAnimation(Material(
            elevation: 10.0,
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding:
              EdgeInsets.only(left: 10, right: 10,
                  top: 13, bottom: 10),
              decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10)),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
              ),
            ),
          )),
        ));
  }
}