import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sbercloud_flutter/ui/common/icon_widget.dart';

class Dropdown extends StatefulWidget {
  final List<String> values;
  final String value;
  final ValueChanged<String> onChanged;
  final double fontSize;

  const Dropdown(
      {Key key,
        this.values,
        this.value,
        this.onChanged,
        this.fontSize = 14.0
      })
      : super(key: key);

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {

  @override
  Widget build(BuildContext context) {
    var styleVariants = TextStyle(color: Color(0xB3343F48), fontSize: widget.fontSize, fontWeight: FontWeight.w600);
    var styleText = TextStyle(color: Color(0xB3343F48), fontSize: widget.fontSize, fontWeight: FontWeight.w600);

    List<DropdownMenuItem<String>> items = [for (var v in widget.values)
      DropdownMenuItem(value: v, child: Text(v, style: styleVariants,))
    ];
    return DropdownButton(
        style: styleText,
        value: widget.value,
        underline: Container(),
        items: items,
        icon: SberIcon(SberIcon.Dropdown),
        iconSize: 18.0,
        onChanged: widget.onChanged
    );
  }
}



