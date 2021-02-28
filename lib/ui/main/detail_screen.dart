import 'package:provider/provider.dart';
import 'package:sbercloud_flutter/api/providers.dart';
import 'package:sbercloud_flutter/api/usecase/auth_usecase.dart';
import 'package:sbercloud_flutter/api/usecase/cloud_eye_usecase.dart';
import 'package:sbercloud_flutter/api/usecase/profile_usecase.dart';
import 'package:sbercloud_flutter/models/base_model.dart';
import 'package:sbercloud_flutter/models/auth_models.dart';
import 'package:sbercloud_flutter/models/cloud_eye_models.dart';
import 'package:sbercloud_flutter/storage/user_preferences.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'chart_view.dart';

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

    List<Metric> metrics = ModalRoute.of(context).settings.arguments;
    CloudEyeUsecase cloudEyeUsecase = Provider.of<CloudEyeUsecase>(context);
    MainProvider mainProvider = Provider.of<MainProvider>(context);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        title: Text(metrics[0].getHumanName(),
            style: TextStyle(
                color: Color(0xFF343F48),
                fontSize: 27.0,
                fontWeight: FontWeight.bold))
    ),
    body: Container(
      padding: const EdgeInsets.fromLTRB(0, 32.0, 0.0, 16.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(2.0),
            child: ChartView(
              metrics: metrics,
              mainProvider: mainProvider,
              cloudEyeUsecase: cloudEyeUsecase,
              axisVisible: true,
              gesturesControl: true,
            ),
          ),
        ],
      ),
    ));
  }
}