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

      if (form.validate()) {
        form.save();
        
        String login = _login == null ? "" : _login;
        String password = _password == null ? "" : _password;

        if (login.length <= 4 || password.length <= 4) {
          ToastUtils.showCustomToast(context, "Ошибка данных");
          return;
        }

        final Future<BaseModel<Token>> user = auth.login(login, _password);
        user.then((baseModelUser)  {
          Token loginData = baseModelUser.data;
          if (loginData == null) {
            final String error = baseModelUser.error.getErrorMessage();
            ToastUtils.showCustomToast(context, "Ошибка входа: $error");
            print(error);

          } else {
            Provider.of<UserProvider>(context, listen: false).setUser(loginData.user);
            Navigator.pushReplacementNamed(context, MAIN_ROUTE);
          }
        });
      }
    };

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromARGB(255, 21, 50, 67),
      body: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      onPressed: () => _switchPlatform(context),
                      child:
                          Icon(Icons.phone)),
                  PlatformTextField(
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    obscureText: false,
                    onChanged: (value) => _login = value,
                    style: TextStyle(color: Colors.white),
                    cupertino: (_, __) => CupertinoTextFieldData(
                        style: TextStyle(color: Colors.black),
                        placeholder: 'Логин'),
                    material: (_, __) => MaterialTextFieldData(
                      decoration: InputDecoration(
                        labelText: 'Логин',
                        labelStyle: TextStyle(color: Colors.white),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8.0),
                  ),
                  PlatformTextField(
                    keyboardType: TextInputType.text,
                    autocorrect: false,
                    obscureText: !this._showPassword,
                    style: TextStyle(color: Colors.white),
                    onChanged: (value) => _password = value,
                    cupertino: (_, __) => CupertinoTextFieldData(
                      style: TextStyle(color: Colors.black),
                      placeholder: 'Пароль',
                    ),
                    material: (_, __) => MaterialTextFieldData(
                        decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            labelStyle: TextStyle(color: Colors.white),
                            labelText: 'Пароль',
                            suffixIcon: IconButton(
                              icon: Icon(
                                  this._showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white),
                              onPressed: () {
                                setState(() {
                                  this._showPassword = !this._showPassword;
                                });
                              },
                            ))),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 32.0),
                  ),
                  auth.loggedInStatus == Status.Authenticating ?  PlatformCircularProgressIndicator() :
                  PlatformButton(
                    child: PlatformText('Войти'),
                    onPressed: doLogin,
                    material: (_, __) => MaterialRaisedButtonData(
                        child: Container(
                          width: double.infinity,
                          height: 40.0,
                          child: Center(child: PlatformText('Войти')),
                        ),
                        textColor: Color.fromARGB(255, 21, 50, 67),
                        color: Color.fromARGB(255, 187, 215, 0)),
                    cupertino: (_, __) => CupertinoButtonData(
                        child: PlatformText(
                      'Войти',
                      style: TextStyle(color: Colors.white),
                    )),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}