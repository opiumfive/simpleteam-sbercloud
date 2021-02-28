import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
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
import 'package:flutter/widgets.dart';
import 'package:sbercloud_flutter/ui/common/card_widget.dart';
import 'package:sbercloud_flutter/ui/common/icon_widget.dart';
import 'package:sbercloud_flutter/ui/common/shimmers.dart';
import 'package:sbercloud_flutter/ui/common/stat_widget.dart';

class AlarmsScreen extends StatefulWidget {
  AlarmsScreen({Key key}) : super(key: key);

  @override
  _AlarmsScreenState createState() => _AlarmsScreenState();
}

class _AlarmsScreenState extends State<AlarmsScreen> {
  @override
  Widget build(BuildContext context) {
    return alarms();
  }

  Widget alarms() {
    CloudEyeUsecase cloudEyeUsecase =
        Provider.of<CloudEyeUsecase>(context, listen: false);
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);

    Future<bool> getData() async {
      BaseModel<List<MetricAlarm>> alarms = await cloudEyeUsecase.alarmRules();

      if (alarms != null && alarms.data != null) {
        mainProvider.setAlarms(alarms.data);
      }
      BaseModel<List<Resource>> resources = await cloudEyeUsecase.quotas();
      if (resources != null && resources.data != null) {
        mainProvider.resources = resources.data;
      }
      return true;
    }

    return FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return ShimmerList();
            default:
              if (snapshot.hasError || snapshot.data == null)
                return Text('fail');
              final List<MetricAlarm> alarms = mainProvider.alarms;
              final List<Resource> resources = mainProvider.resources;
              final resourceAlarm =
                  resources.firstWhere((res) => res.type == "alarm");

              var critical = 0;
              var major = 0;
              var minor = 0;
              var informational = 0;
              alarms.forEach((element) {
                switch (element.alarm_level) {
                  case 1:
                    critical++;
                    break;
                  case 2:
                    major++;
                    break;
                  case 3:
                    minor++;
                    break;
                  case 4:
                    informational++;
                    break;
                }
              });

              return ListView.separated(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: 1 + alarms.length,
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 24.0);
                  },
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return CardWidget(
                          child: StatBlockView(
                              serviceIcon: SberIcon.EyeCloud,
                              serviceName: "Eye Cloud",
                              sumTitle: "All alarm",
                              data: {
                            "Critical": critical,
                            "Major": major,
                            "Minor": minor,
                            "Info": informational
                          }));
                    }
                    final alarm = alarms[index - 1];
                    //return Text(alarm.toJson().toString() + " " + alarm.condition.toJson().toString());
                    return CardWidget(
                      child: ListTile(
                        title: Text(alarm.alarm_name),
                        subtitle: Text(alarm.metric.getHumanTitle()),
                        trailing: Text(alarm.getLevelName()),
                      ),
                    );
                  });
          }
        });
  }
}
