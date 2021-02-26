import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class SberButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final SberButtonStyle style;

  const SberButton({Key key, this.text, this.onPressed, this.style = SberButtonStyle.Filled}) : super(key: key);

  @override
  _SberButton createState() => _SberButton();
}

enum SberButtonStyle {
  Bordered, Filled
}

class _SberButton extends State<SberButton> {

  final buttonColor = const Color(0xFF343F48);

  @override
  Widget build(BuildContext context) {

    var textStyle;
    switch (widget.style) {
      case SberButtonStyle.Bordered:
        textStyle = TextStyle(color: buttonColor, fontSize: 12.0);
        break;
      case SberButtonStyle.Filled:
        textStyle = TextStyle(color: Color(0xE6FFFFFF), fontSize: 12.0);
        break;
    }

    var filledColor;
    switch (widget.style) {
      case SberButtonStyle.Bordered:
        filledColor = Colors.white;
        break;
      case SberButtonStyle.Filled:
        filledColor = buttonColor;
        break;
    }

    var shape;
    switch (widget.style) {
      case SberButtonStyle.Bordered:
        shape = new RoundedRectangleBorder(
          side: BorderSide(color: buttonColor, width: 1.0),
          borderRadius: new BorderRadius.circular(6.0),
        );
        break;
      case SberButtonStyle.Filled:
        shape = new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(6.0),
        );
        break;
    }

    return PlatformButton(
      onPressed: widget.onPressed,
      material: (_, __) => MaterialRaisedButtonData(
        shape: shape,
        child: Container(
          width: double.infinity,
          height: 40.0,
          child: Center(child: Text(widget.text, style: textStyle)),
        ),
        color: filledColor,
        elevation: 0.0
      ),
      cupertino: (_, __) => CupertinoButtonData(
          color: filledColor,
          child: Container(
            width: double.infinity,
            child: Center(
                child: PlatformText(widget.text, style: textStyle)),
          )),
    );
  }
}
