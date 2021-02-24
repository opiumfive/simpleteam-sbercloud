import 'package:sbercloud_flutter/api/api_usecase.dart';
import 'package:sbercloud_flutter/api/providers.dart';
import 'package:sbercloud_flutter/models/base_model.dart';
import 'package:sbercloud_flutter/models/models.dart';
import 'package:sbercloud_flutter/storage/user_preferences.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

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
    ApiUsecase api = Provider.of<ApiUsecase>(context);

    return Text('');
  }

  showLogoutDialog(BuildContext context, ApiUsecase api) {
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
