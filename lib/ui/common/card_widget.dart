import 'package:flutter/material.dart';

class CardWidget extends Card {
  final ShadowStyle shadowStyle;

  CardWidget({child, this.shadowStyle})
      : super(
            shadowColor: Color(0xFF000000).withOpacity(shadowStyle == null ? 0.3 : shadowStyle == ShadowStyle.Default ? 0.3 : 0.2),
            elevation: shadowStyle == null ? 13 : shadowStyle == ShadowStyle.Default ? 13 : 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: child);
}

enum ShadowStyle {
  Default,
  Light
}
