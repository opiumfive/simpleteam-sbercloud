import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sbercloud_flutter/ui/common/icon_widget.dart';

class SberIconButton extends StatelessWidget {
  final String icon;
  final VoidCallback onPressed;
  final int counter;

  const SberIconButton(
      this.icon, {
        Key key,
        this.onPressed,
        this.counter
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final iconWidget = PlatformIconButton(icon: SberIcon(icon), onPressed: onPressed);
    if (counter == null || counter == 0) {
      return iconWidget;
    } else {
      final counterWidget = Container(
        padding: const EdgeInsets.all(3.0),
        decoration: new BoxDecoration(
          color: Color(0xFF07E897),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 3.0, 0.0, 0.0),
          child: Text(counter.toString(), style: TextStyle(color: Color(0xFF343F48), fontSize: 9.0, fontWeight: FontWeight.w600)),
        ),
      );
      return Container(
        child: Stack(children: [
          Center(child: iconWidget),
          Container(margin: const EdgeInsets.fromLTRB(24.0, 10.0, 0.0, 0.0),child: counterWidget)
        ]),
      );
    }
  }
}
