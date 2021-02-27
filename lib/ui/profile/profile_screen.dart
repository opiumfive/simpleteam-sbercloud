import 'package:sbercloud_flutter/api/providers.dart';
import 'package:sbercloud_flutter/api/usecase/auth_usecase.dart';
import 'package:sbercloud_flutter/api/usecase/profile_usecase.dart';
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
import 'package:sbercloud_flutter/ui/toast_utils.dart';

import '../../const.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  UserDetail userDetail;
  @override
  void initState() {
    super.initState();
    userDetail = Provider
        .of<UserProvider>(context, listen: false)
        .detail;
  }

  @override
  Widget build(BuildContext context) {
    ProfileUsecase profile = Provider.of<ProfileUsecase>(context);
    if (userDetail == null) {
      final Future<BaseModel<UserDetail>> futureUser = profile.user();
      futureUser.then((baseModelUser) {
        UserDetail userDetail = baseModelUser.data;
        if (userDetail == null) {
          final String error = baseModelUser.error.getErrorMessage();
          ToastUtils.showCustomToast(context, "Ошибка входа: $error");
          print(error);
        } else {
          Provider.of<UserProvider>(context, listen: false).setDetails(
              userDetail);
          setState(() {
            this.userDetail = userDetail;
          });
        }
      });
    }

    if (userDetail == null) {
      return Center(child: PlatformCircularProgressIndicator());
    }
    print(userDetail);
    User user = Provider.of<UserProvider>(context, listen: false).user;
    var avatar;
    if (userDetail.img_path != null) {
      avatar = CircleAvatar(
          radius: 46.0,
          backgroundColor: Color(0x4AD2D2D2),
          backgroundImage: NetworkImage(userDetail.img_path.replaceFirst("\$size", "b"))
      );
    } else {
      avatar = Container(height: 92.0, width: 92.0,child: Center(child: SberIcon(SberIcon.Profile, size: 56.0, color: Colors.white,)));
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 32.0, 0.0, 16.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Color(0xCC343F48),
                shape: BoxShape.circle
            ),
            padding: const EdgeInsets.all(2.0),
            child: avatar,
          ),
          SizedBox(height: 20.0),
          Text(user.name, style: TextStyle(color: Color(0xCC343F48), fontSize: 24.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 24.0),
          InfoRow("User ID:", icon: SberIcon.UserId, data: userDetail.id, onCopy: onCopy),
          InfoRow("Account ID:", icon: SberIcon.AccountId, data: userDetail.domain_id, onCopy: onCopy),
          InfoRow("Account Name:", icon: SberIcon.AccountName, data: userDetail.name,),
          InfoRow("Email Address:", icon: SberIcon.AccountMail, data: userDetail.email,),
          InfoRow("Mobile Number:", icon: SberIcon.AccountPhone, data: userDetail.phone,)
        ],
      ),
    );
  }

  void onCopy(String value) {
    print("copy:" + value);
  }
}
