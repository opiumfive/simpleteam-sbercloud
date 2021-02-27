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

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    String item = ModalRoute.of(context).settings.arguments;

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
            child: Text(''),
          ),
        ],
      ),
    );
  }
}