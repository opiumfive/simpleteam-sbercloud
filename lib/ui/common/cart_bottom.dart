import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:sbercloud_flutter/ui/common/icon_widget.dart';

class CardButton extends StatelessWidget {
  final String serviceName;
  final String date;

  static var formatter = DateFormat('HH:mm:ss', 'ru');

  static final _serviceNameStyle = TextStyle(
      color: Color(0x5E343F48), fontSize: 14.0, fontWeight: FontWeight.w600);
  static final _dateStyle = TextStyle(
      color: Color(0x5E343F48), fontSize: 14.0, fontWeight: FontWeight.w600);

  const CardButton(
      {Key key,
        this.serviceName,
        this.date
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var icon;
    switch (serviceName) {
      case "FunctionGraph":
        icon = SberIcon.FunctionGraph;
        break;
      default:
        icon = SberIcon.EyeCloud;
        break;
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 6.0, 12.0, 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 3.0, 3.0),
            child: SberIcon(icon, size: 20.0),
          ),
          Text(serviceName ?? "", style: _serviceNameStyle),
          Spacer(),
          Text(date ?? 'Updated   ${formatter.format(DateTime.now())}', style: _dateStyle),
        ],
      ),
    );
  }
}
