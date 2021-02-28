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

  String _selectedPeriod = "today";
  String _selectedInterval = "1 hour";
  String _selectedType = "average";

  DateTimeRange dateTimeRange;
  int interval;
  bool needRefresh = false;

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    List<Metric> metrics = ModalRoute.of(context).settings.arguments;
    CloudEyeUsecase cloudEyeUsecase = Provider.of<CloudEyeUsecase>(context);
    MainProvider mainProvider = Provider.of<MainProvider>(context);

    if (dateTimeRange == null) dateTimeRange = mainProvider.range;
    if (interval == null) interval = mainProvider.interval;

    final List<DropdownMenuItem<String>> intervals = <String>[
      '1 hour','2 hour','3 hour', '4 hour'
    ].map((e) => DropdownMenuItem(value: e, child: Text(
      e,
      style: TextStyle(
          color: Color(0xA3000000),
          fontSize: 13,
          fontWeight: FontWeight.bold),
    ),)).toList();

    final List<DropdownMenuItem<String>> types = <String>[
      'average', 'min', 'max', 'sum', 'variance'
    ].map((e) => DropdownMenuItem(value: e, child: Text(
      e,
      style: TextStyle(
          color: Color(0xA3000000),
          fontSize: 13,
          fontWeight: FontWeight.bold),
    ),)).toList();

    final List<DropdownMenuItem<String>> periods = <String>[
      'today', 'last 2 days', 'last 3 days', 'last week', 'last month'
    ].map((e) => DropdownMenuItem(value: e, child: Text(
      e,
      style: TextStyle(
          color: Color(0xA3000000),
          fontSize: 13,
          fontWeight: FontWeight.bold),
    ),)).toList();

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text(metrics[0].getHumanName(),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                    color: Color(0xFF343F48),
                    fontSize: 27.0,
                    fontWeight: FontWeight.bold))
        ),
        body: Container(
          height: double.infinity,
          padding: const EdgeInsets.fromLTRB(0, 32.0, 0, 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.max,
                children: [

                  Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Type',
                          style: TextStyle(
                              color: Color(0xFF343F48).withOpacity(0.37),
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 1,),
                        DropdownButton(value: _selectedType, items: types, onChanged: (String newValue) {
                          setState(() {
                            _selectedType = newValue;
                            needRefresh = true;
                          });
                        }),
                      ]),

                  SizedBox(width: 10,),
                  Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Interval',
                          style: TextStyle(
                              color: Color(0xFF343F48).withOpacity(0.37),
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 1,),
                        DropdownButton(value: _selectedInterval, items: intervals, onChanged: (String newValue) {
                          setState(() {
                            _selectedInterval = newValue;
                            needRefresh = true;
                            switch(_selectedInterval) {
                              case "2 hour":
                                interval = 7200;
                                break;
                              case "3 hour":
                                interval = 10800;
                                break;
                              case "1 hour":
                                interval = 3600;
                                break;
                              case "4 hour":
                                interval = 14400;
                                break;
                            }
                          });
                        }),]),
                  SizedBox(width: 10,),

                  Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Period',
                          style: TextStyle(
                              color: Color(0xFF343F48).withOpacity(0.37),
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 1,),
                        DropdownButton(value: _selectedPeriod, items: periods, onChanged: (String newValue) {
                          setState(() {
                            _selectedPeriod = newValue;
                            needRefresh = true;
                            switch(_selectedPeriod) {
                              case "today":
                                dateTimeRange = DateTimeRange(start: DateTime.now().subtract(Duration(hours: 24)), end: DateTime.now());
                                break;
                              case "last 2 days":
                                dateTimeRange = DateTimeRange(start: DateTime.now().subtract(Duration(days: 2)), end: DateTime.now());
                                break;
                              case "last 3 days":
                                dateTimeRange = DateTimeRange(start: DateTime.now().subtract(Duration(days: 3)), end: DateTime.now());
                                break;
                              case "last week":
                                dateTimeRange = DateTimeRange(start: DateTime.now().subtract(Duration(days: 7)), end: DateTime.now());
                                break;
                              case "last month":
                                dateTimeRange = DateTimeRange(start: DateTime.now().subtract(Duration(days: 30)), end: DateTime.now());
                                break;
                            }
                          });
                        })])

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
                  dateTimeRange: dateTimeRange,
                  interval: interval,
                  type: _selectedType,
                  needRefresh: needRefresh
                ),
              ),
            ],
          ),
        ));
  }
}