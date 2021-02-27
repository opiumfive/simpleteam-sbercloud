import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sbercloud_flutter/ui/common/icon_button_widget.dart';
import 'package:sbercloud_flutter/ui/common/icon_widget.dart';
import 'package:sbercloud_flutter/ui/login/widget/button_widget.dart';

class InfoRow extends StatelessWidget {
  final String icon;
  final String title;
  final String data;
  final Function(String data) onCopy;

  static const _titleStyle = TextStyle(
      color: Color(0xCC343F48), fontSize: 14.0, fontWeight: FontWeight.bold);
  static const _dataStyle = TextStyle(
      color: Color(0xB3343F48), fontSize: 8.0, fontWeight: FontWeight.w600);

  const InfoRow(this.title, {Key key, this.icon, this.data, this.onCopy})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var r = Random();
    return Container(
      // color: Color.fromARGB(255, r.nextInt(255), r.nextInt(255), r.nextInt(255)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 0.0 ,16.0),
        child: Container(
          height: 32.0,
          child: Row(
              children: [
                icon != null ? Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 0.0, 9.0, 0.0),
                  child: SberIcon(icon),
                ) : SizedBox(),
                Text(title ?? "", style: _titleStyle),
                Padding(
                  padding: const EdgeInsets.fromLTRB(14.0, 0.0, 0.0, 0.0),
                  child: Text(data ?? "", style: _dataStyle),
                ),
                (data != null && data.length > 0&& onCopy != null) ? Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0.0, 0.0, 0.0),
                  child: SberIconButton(SberIcon.Clipboard, onPressed: () => {
                    onCopy.call(data)
                  },),
                ) : SizedBox(),
              ]),
        ),
      ),
    );
  }
}
