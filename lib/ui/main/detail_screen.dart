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
import 'package:sbercloud_flutter/ui/common/dropdown_widget.dart';

import 'chart_view.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  String _selectedPeriod = "1 day";
  String _selectedInterval = "1 hour";
  String _selectedType = "average";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<Metric> metrics = ModalRoute.of(context).settings.arguments;
    CloudEyeUsecase cloudEyeUsecase = Provider.of<CloudEyeUsecase>(context);
    MainProvider mainProvider = Provider.of<MainProvider>(context);

    const labelsPadding = const EdgeInsets.fromLTRB(0.0, 3.0,0.0 ,0.0);

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        title: Container(
          height: 27.0,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: Text(metrics[0].getHumanName(),
                style: TextStyle(
                    color: Color(0xFF343F48),
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold)),
          ),
        )
    ),
    body: Container(
      padding: const EdgeInsets.fromLTRB(0, 32.0, 0.0, 16.0),
      child: Column(
        children: [
          Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: Row(
            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              Padding(
                padding: labelsPadding,
                child: Text(
                  'Type',
                  style: TextStyle(
                      color: Color(0xFF343F48).withOpacity(0.37),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 5,),
              Dropdown(values: ['average', 'min', 'max', 'sum', 'variance'], value: _selectedType, fontSize: 13.0, onChanged: (String newValue) {
                setState(() {
                  _selectedType = newValue;
                });
              }),
              SizedBox(width: 10,),
              Padding(
                padding: labelsPadding,
                child: Text(
                  'Interval',
                  style: TextStyle(
                      color: Color(0xFF343F48).withOpacity(0.37),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 5,),
              Dropdown(values: ['1 hour', '2 hours', '3 hours'], value: _selectedInterval, fontSize: 13.0, onChanged: (String newValue) {
                setState(() {
                  _selectedInterval = newValue;
                });
              }),
              SizedBox(width: 10,),
              Padding(
                padding: labelsPadding,
                child: Text(
                  'Period',
                  style: TextStyle(
                      color: Color(0xFF343F48).withOpacity(0.37),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(width: 5,),
              Dropdown(values: ['1 day', '2 days', '3 days'], value: _selectedPeriod, fontSize: 13.0, onChanged: (String newValue) {
                setState(() {
                  _selectedPeriod = newValue;
                });
              })

            ],
          ),),
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