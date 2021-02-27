import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SberIcon extends StatelessWidget {
  final String icon;
  final Color color;
  final double size;

  static const Configuration = "ic_configuration.svg";
  static const Dashboard = "ic_dashboard.svg";
  static const Settings = "ic_settings.svg";

  const SberIcon(
      this.icon, {
        Key key,
        this.size = 24.0,
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
