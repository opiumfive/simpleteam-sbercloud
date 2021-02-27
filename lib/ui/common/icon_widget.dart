import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SberIcon extends StatelessWidget {
  final String icon;
  final Color color;
  final double size;

  static const Configuration = "ic_configuration.svg";
  static const Dashboard = "ic_dashboard.svg";
  static const Settings = "ic_settings.svg";
  static const Alarm = "ic_alarm.svg";
  static const Edit = "ic_edit.svg";
  static const Profile = "ic_profile.svg";
  static const ArrowUp = "ic_arrow_up.svg";
  static const ArrowDown = "ic_arrow_down.svg";

  static const Eye12dp = "ic_eye_12dp.svg";
  static const Close12dp = "ic_close_12dp.svg";
  static const Close16dp = "ic_close_16dp.svg";
  static const Plus40dp = "ic_plus_40dp.svg";

  const SberIcon(
      this.icon, {
        Key key,
        this.size,
        this.color,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final IconThemeData iconTheme = IconTheme.of(context);
    final double iconOpacity = iconTheme.opacity;
    Color iconColor = color ?? iconTheme.color;
    if (iconOpacity != 1.0)
      iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);

    final double iconSize = size ?? iconTheme.size;

    return SvgPicture.asset("assets/images/" + icon, width: iconSize, height: iconSize, color: iconColor);
  }
}
