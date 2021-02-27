import 'package:sbercloud_flutter/api/providers.dart';
import 'package:sbercloud_flutter/api/usecase/auth_usecase.dart';
import 'package:sbercloud_flutter/models/base_model.dart';
import 'package:sbercloud_flutter/models/auth_models.dart';
import 'package:sbercloud_flutter/storage/user_preferences.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:sbercloud_flutter/ui/common/icon_widget.dart';
import 'package:sbercloud_flutter/ui/profile/widget/info_row_widget.dart';

import '../../const.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {

    User user = Provider.of<UserProvider>(context, listen: false).user;
    AuthApiUsecase api = Provider.of<AuthApiUsecase>(context);
    
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text('Anfisa Filitova', style: TextStyle(color: Color(0xCC343F48), fontSize: 24.0, fontWeight: FontWeight.bold)),
            InfoRow("User ID:", icon: SberIcon.UserId, data: user.id, onCopy: onCopy),
            InfoRow("Account ID:", icon: SberIcon.AccountId, data: user.name, onCopy: onCopy),
            InfoRow("Account Name:", icon: SberIcon.AccountName, data: user.name,),
            InfoRow("Email Address:", icon: SberIcon.AccountMail, data: user.name,),
            InfoRow("Mobile Number:", icon: SberIcon.AccountPhone, data: user.name,)
          ],
        ),
      ),
    );
  }

  void onCopy(String value) {
    print("copy:" + value);
  }

  showLogoutDialog(BuildContext context, AuthApiUsecase api) {
    // set up the buttons
    PlatformDialogAction cancelButton = PlatformDialogAction(
      child: Text("Отмена"),
      onPressed:  () {
        Navigator.of(context).pop();
      },
    );
    PlatformDialogAction continueButton = PlatformDialogAction(
      child: Text("Да"),
      onPressed:  () {
        UserPreferences().removeUser();
        Provider.of<UserProvider>(context, listen: false).setUser(new User());
        Navigator.pushNamedAndRemoveUntil(context, LOGIN_ROUTE,ModalRoute.withName('/auth'),);
      },
    );
    // set up the AlertDialog
    PlatformAlertDialog alert = PlatformAlertDialog(
      title: Text("Выход из аккаунта"),
      content: Text("Вы действительно хотите выйти?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
