import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:sbercloud_flutter/api/providers.dart';
import 'package:sbercloud_flutter/api/usecase/auth_usecase.dart';
import 'package:sbercloud_flutter/api/usecase/cloud_eye_usecase.dart';
import 'package:sbercloud_flutter/ext.dart';
import 'package:sbercloud_flutter/models/base_model.dart';
import 'package:sbercloud_flutter/models/auth_models.dart';
import 'package:sbercloud_flutter/models/cloud_eye_models.dart';
import 'package:sbercloud_flutter/storage/user_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sbercloud_flutter/ui/common/icon_widget.dart';
import 'package:sbercloud_flutter/ui/profile/profile_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animations/animations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import "package:collection/collection.dart";
import '../../const.dart';
import 'chart_data.dart';
import 'chart_view.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
    } else if (state == AppLifecycleState.paused) {
    } else if (state == AppLifecycleState.inactive) {}
  }

  @override
  Widget build(BuildContext context) {

    var bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const SberIcon(SberIcon.Dashboard),
        label: 'Dashboard',
      ),
      BottomNavigationBarItem(
        icon: const SberIcon(SberIcon.Configuration),
        label: 'Configuration',
      ),
      BottomNavigationBarItem(
        icon: const SberIcon(SberIcon.Settings),
        label: 'Settings',
      ),
    ];

    return Scaffold(
        backgroundColor: Colors.white,
        body: PageTransitionSwitcher(
          child: case2(
              _currentIndex,
              {
                0: Center(child: Container(
                  key: UniqueKey(),
                  padding: EdgeInsets.all(16.0),
                  child: _mainWidget(),
                )),
                1: Text('two'),
                2: ProfileScreen()
              },
              Text('default')),
          transitionBuilder: (child, animation, secondaryAnimation) {
            return FadeThroughTransition(
              child: child,
              animation: animation,
              secondaryAnimation: secondaryAnimation,
            );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Color(0xBF343F48),
          unselectedItemColor: Color(0xFFD2D2D2),
          showUnselectedLabels: true,
          items: bottomNavigationBarItems,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          //selectedFontSize: textTheme.caption.fontSize,
          //unselectedFontSize: textTheme.caption.fontSize,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          //selectedItemColor: colorScheme.onPrimary,
          //unselectedItemColor: colorScheme.onPrimary.withOpacity(0.38),
          //backgroundColor: colorScheme.primary,
        ));
  }

  Widget _mainWidget() {
    // test widget
    CloudEyeUsecase cloudEyeUsecase = Provider.of<CloudEyeUsecase>(context, listen: false);
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);
    Future<List<Datapoint>> datapoints() async {
      BaseModel<List<Metric>> metrics = await cloudEyeUsecase.metrics();
      if (metrics != null && metrics.data != null) {
        mainProvider.setMetrics(metrics.data);

        Metric metric = metrics.data[2];
        BaseModel<List<Datapoint>> data = await cloudEyeUsecase.metricData(
            metric,
            DateTimeRange(
                start: DateTime.now().subtract(Duration(hours: 24)),
                end: DateTime.now()),
            3600,
            filter: "average");
        return data.data;
      }
    }

    return FutureBuilder(
        future: cloudEyeUsecase.metrics(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: PlatformCircularProgressIndicator(),
                ),
              );
            default:
              if (snapshot.hasError || snapshot.data == null)
                return Text('fail');
              final List<Metric> metrics = snapshot.data.data;

              final groups = groupBy(metrics, (Metric e) {
                return '${e.namespace}+${e.metric_name}';
              });

              return ListView.builder(
                itemCount: groups.keys.length,
                
                itemBuilder: (ctx, index) {
                  return Container(
                    child: Card(
                        shadowColor: Color(0xFF234395).withOpacity(0.2),
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(groups[groups.keys.toList()[index]].first.getHumanName()),
                              ChartView(
                                metrics: groups[groups.keys.toList()[index]],
                                mainProvider: mainProvider,
                                cloudEyeUsecase: cloudEyeUsecase,
                                axisVisible: false,
                                gesturesControl: false,
                              ),
                            ]))
                  );
                },
              );
          }
        });
  }
}

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return ListView.builder(
      itemCount: 6,
      itemBuilder: (BuildContext context, int index) {
        offset += 5;
        time = 800 + offset;

        print(time);

        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Shimmer.fromColors(
              highlightColor: Colors.white,
              baseColor: Colors.grey[200],
              child: ShimmerLayout(),
              period: Duration(milliseconds: time),
            ));
      },
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 200;
    double containerHeight = 15;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 100,
            width: 100,
            color: Colors.grey[200],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey[200],
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth,
                color: Colors.grey[200],
              ),
              SizedBox(height: 5),
              Container(
                height: containerHeight,
                width: containerWidth * 0.75,
                color: Colors.grey[200],
              )
            ],
          )
        ],
      ),
    );
  }
}
