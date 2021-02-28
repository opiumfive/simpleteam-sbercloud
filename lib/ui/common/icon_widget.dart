import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SberIcon extends StatelessWidget {
  final String icon;
  final Color color;
  final double size;

  //Nav
  static const Back = "ic_back.svg";
  static const AlarmsNav = "ic_alarms.svg";
  static const ProfileNav = "ic_profile_menu.svg";
  static const ConfigurationNav = "ic_configuration.svg";
  static const DashboardNav = "ic_dashboard.svg";
  static const SettingsNav = "ic_settings.svg";
  static const Logout = "ic_logout.svg";

  //Dashboard
  static const Alarm = "ic_alarm.svg";
  static const Edit = "ic_edit.svg";
  static const ArrowUp = "ic_arrow_up.svg";
  static const ArrowDown = "ic_arrow_down.svg";
  static const Close12dp = "ic_close_12dp.svg";
  static const Close16dp = "ic_close_16dp.svg";
  static const Plus40dp = "ic_plus_40dp.svg";
  static const Dropdown = "ic_dropdown.svg";

  //Profile
  static const Profile = "ic_profile.svg";
  static const Clipboard = "ic_clipboard.svg";
  static const UserId = "ic_user_id.svg";
  static const AccountId = "ic_account_id.svg";
  static const AccountName = "ic_account_name.svg";
  static const AccountMail = "ic_account_mail.svg";
  static const AccountPhone = "ic_account_phone.svg";

  //Services
  static const EyeCloud = "ic_eye_12dp.svg";
  static const FunctionGraph = "ic_function_graph.svg";

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
    print("iconSize $iconSize");

    return SvgPicture.asset("assets/images/" + icon, width: iconSize, height: iconSize, color: iconColor);
  }
}
