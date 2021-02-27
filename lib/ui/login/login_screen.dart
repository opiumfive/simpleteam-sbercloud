import 'package:sbercloud_flutter/api/usecase/auth_usecase.dart';
import 'package:sbercloud_flutter/api/providers.dart';
import 'package:sbercloud_flutter/models/base_model.dart';
import 'package:sbercloud_flutter/models/auth_models.dart';
import 'package:flutter/material.dart';
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
  String _login = "hackathon113";
  String _password = "simpleteam123";

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
      backgroundColor: Colors.white,
      body: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 52.0),
                  SvgPicture.asset("assets/images/logo_login.svg", width: 178.0, height: 26.0),
                  Spacer(),
                  GestureDetector(child: Text('Account Login', style: TextStyle(color: Color(0xCC000000), fontSize: 23.0, fontWeight: FontWeight.bold)),
                    onTap: () => _switchPlatform(context),
                  ),
                  SizedBox(height: 18.0),
                  SberTextField(onChanged: (value) => _login = value, placeholder: "Логин", text: _login),
                  SizedBox(height: 12.0),
                  SberTextField(onChanged: (password) => _password = password, placeholder: "Пароль", text: _password, isPassword: true),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 0.0),
                      child: InkWell(
                        onTap: () => {},
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0.0, 4.0, 0.0, 4.0),
                          child: Text("Forgot Password", style: TextStyle(color: Color(0xFF343F48), fontSize: 11.0)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 32.0),
                  auth.loggedInStatus == Status.Authenticating ?  PlatformCircularProgressIndicator() :
                  SberButton(text: "Войти", onPressed: doLogin),
                  SizedBox(height: 12.0),
                  SberButton(text: "Регистрация", onPressed: doLogin, style: SberButtonStyle.Bordered),
                  Spacer(),
                ],
              ),
            ),
          )),
    );
  }
}