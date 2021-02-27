import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sbercloud_flutter/ui/common/icon_widget.dart';

class CardWidget extends Card {
  CardWidget({child})
      : super(
            shadowColor: Color(0xFF000000).withOpacity(0.5),
            elevation: 13,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: child);
}
