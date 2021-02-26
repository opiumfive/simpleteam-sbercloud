import 'package:sbercloud_flutter/api/usecase/auth_usecase.dart';
import 'package:sbercloud_flutter/api/providers.dart';
import 'package:sbercloud_flutter/models/base_model.dart';
import 'package:sbercloud_flutter/models/auth_models.dart';
import 'package:sbercloud_flutter/storage/user_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multi_formatter/flutter_multi_formatter.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sbercloud_flutter/ui/login/widget/button_widget.dart';
import 'package:sbercloud_flutter/ui/login/widget/input_widget.dart';

import '../../const.dart';
import '../toast_utils.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  String _login, _password;
  final formKey = new GlobalKey<FormState>();
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  _switchPlatform(BuildContext context) {
    if (isMaterial(context)) {
      PlatformProvider.of(context).changeToCupertinoPlatform();
    } else {
      PlatformProvider.of(context).changeToMaterialPlatform();
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthApiUsecase auth = Provider.of<AuthApiUsecase>(context);
    var doLogin = () {

      final form = formKey.currentState;

      //Navigator.pushReplacementNamed(context, MAIN_ROUTE);

      if (form.validate()) {
        form.save();
        
        String login = _login == null ? "" : _login;
        String password = _password == null ? "" : _password;

        if (login.length <= 4 || password.length <= 4) {
          ToastUtils.showCustomToast(context, "Ошибка данных");
          return;
        }

        final Future<BaseModel<User>> user = auth.login(login, _password);
        user.then((baseModelUser)  {
          User user = baseModelUser.data;
          if (user == null) {
            final String error = baseModelUser.error.getErrorMessage();
            ToastUtils.showCustomToast(context, "Ошибка входа: $error");
            print(error);

          } else {
            Provider.of<UserProvider>(context, listen: false).setUser(user);
            Navigator.pushReplacementNamed(context, MAIN_ROUTE);
          }
        });
      }
    };

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(child: Text('Account Login', style: TextStyle(color: Color(0xCC000000), fontSize: 23.0, fontWeight: FontWeight.bold)),
                    onTap: () => _switchPlatform(context),
                  ),
                  SizedBox(height: 18.0),
                  SberTextField(onChanged: (value) => _login = value, placeholder: "Логин",),
                  SizedBox(height: 12.0),
                  SberTextField(onChanged: (password) => _password = password, placeholder: "Пароль", isPassword: true),
                  SizedBox(height: 32.0),
                  auth.loggedInStatus == Status.Authenticating ?  PlatformCircularProgressIndicator() :
                  SberButton(text: "Войти", onPressed: doLogin),
                  SizedBox(height: 12.0),
                  SberButton(text: "Регистрация", onPressed: doLogin, style: SberButtonStyle.Bordered),
                ],
              ),
            ),
          )),
    );
  }
}