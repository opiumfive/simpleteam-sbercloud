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
import 'package:sbercloud_flutter/ui/alarm/alarms_screen.dart';
import 'package:sbercloud_flutter/ui/common/card_widget.dart';
import 'package:sbercloud_flutter/ui/common/icon_button_widget.dart';
import 'package:sbercloud_flutter/ui/common/icon_widget.dart';
import 'package:sbercloud_flutter/ui/profile/profile_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animations/animations.dart';

import "package:collection/collection.dart";
import 'package:syncfusion_flutter_gauges/gauges.dart';
import '../../const.dart';
import '../toast_utils.dart';
import 'chart_data.dart';
import 'chart_view.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  int _currentIndex = 0;
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

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

  void onEdit() {
    print("onEdit");
  }

  void onAlert() {
    print("onAlert");
  }

  void showLogoutDialog(BuildContext context, AuthApiUsecase api) {
    // set up the buttons
    PlatformDialogAction cancelButton = PlatformDialogAction(
      child: Text("Отмена"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    PlatformDialogAction continueButton = PlatformDialogAction(
      child: Text("Да"),
      onPressed: () {
        UserPreferences().removeUser();
        Provider.of<UserProvider>(context, listen: false).setUser(new User());
        Navigator.pushNamedAndRemoveUntil(
          context,
          LOGIN_ROUTE,
          ModalRoute.withName('/auth'),
        );
      },
    );
    // set up the AlertDialog
    PlatformAlertDialog alert = PlatformAlertDialog(
      title: Text("Выход из аккаунта"),
      content: Text("Вы действительно хотите выйти?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const SberIcon(SberIcon.DashboardNav),
        label: 'Dashboard',
      ),
      BottomNavigationBarItem(
        icon: const SberIcon(SberIcon.AlarmsNav),
        label: 'Alarms',
      ),
      BottomNavigationBarItem(
        icon: const SberIcon(SberIcon.ProfileNav),
        label: 'Profile',
      ),
    ];

    final label = bottomNavigationBarItems[_currentIndex].label;
    final title = Text(label,
        style: TextStyle(
            color: Color(0xFF343F48),
            fontSize: 27.0,
            fontWeight: FontWeight.bold));

    AuthApiUsecase api = Provider.of<AuthApiUsecase>(context);

    var actions = <Widget>[];
    switch (_currentIndex) {
      case 0:
        actions.add(SberIconButton(SberIcon.Edit, onPressed: onEdit));
        actions.add(
            SberIconButton(SberIcon.Alarm, onPressed: onAlert, counter: 8));
        break;
      case 1:
        break;
      case 2:
        actions.add(SberIconButton(SberIcon.Logout,
            onPressed: () => {showLogoutDialog(context, api)}));
        break;
    }

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: title,
          actions: actions,
        ),
        body: PageTransitionSwitcher(
          child: case2(
              _currentIndex,
              {
                0: Center(
                    child: Container(
                  key: UniqueKey(),
                  //padding: EdgeInsets.all(16.0),
                  child: _mainWidget(),
                )),
                1: AlarmsScreen(),
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
    CloudEyeUsecase cloudEyeUsecase =
        Provider.of<CloudEyeUsecase>(context, listen: false);
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);

    Future<bool> getData() async {
      BaseModel<List<Metric>> metrics = await cloudEyeUsecase.metrics();
      if (metrics != null && metrics.data != null) {
        mainProvider.setMetrics(metrics.data);

        List<Metric> special = metrics.data.where((element) => element.metric_name.contains("reject") ||
            element.metric_name.contains("inbound") || element.metric_name.contains("traffic") ||
            element.metric_name.contains("cpu") || element.metric_name.contains("disk")).toList();
        special = special.toSet().toList();
        if (special.length > 5) {
          special = special.sublist(0, 5);
        }
        List<Special> specials = List.empty(growable: true);
        for (int i = 0; i < special.length; i++) {
          BaseModel<List<Datapoint>> resp = await cloudEyeUsecase
              .metricData(special[i], mainProvider.range,
              mainProvider.interval,
              filter: "average");
          if (resp != null && resp.data != null && resp.data.isNotEmpty) {
            String value = "${resp.data.last.getData()} ${special[i].unit}";
            specials.add(Special(value, special[i].getHumanTitle()));
          }
        }
        mainProvider.specials = specials;
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
              return SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: Center(
                  child: PlatformCircularProgressIndicator(),
                ),
              );
            default:
              if (snapshot.hasError || snapshot.data == null)
                return Text('fail');
              final List<Metric> metrics = mainProvider.metrics;
              final List<Resource> resources = mainProvider.resources;
              final List<Special> specials = mainProvider.specials;

              final groups = groupBy(metrics, (Metric e) {
                return '${e.namespace}+${e.metric_name}';
              });

              return ListView.builder(
                itemCount: groups.keys.length + 1,
                itemBuilder: (ctx, index) {
                  return index == 0
                      ? SizedBox(
                          height: 150,
                          child: ListView.builder(
                              itemCount: resources.length + specials.length,
                              padding: EdgeInsets.fromLTRB(30, 30, 0, 30),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (ctx, indexHor) {
                                return Container(
                                  width: 100,
                                  height: 100,
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Card(
                                    shadowColor:
                                        Color(0xFF000000).withOpacity(0.5),
                                    elevation: 13,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.0),
                                    ),
                                    child: indexHor < resources.length ? Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            width: 55,
                                            height: 55,
                                            child: SfRadialGauge(axes: <
                                                RadialAxis>[
                                              RadialAxis(
                                                  minimum: 0,
                                                  maximum: 100,
                                                  showLabels: false,
                                                  showTicks: false,
                                                  radiusFactor: 0.8,
                                                  startAngle: 270,
                                                  endAngle: 270,
                                                  axisLineStyle: AxisLineStyle(
                                                    thickness: 0.17,
                                                    cornerStyle:
                                                        CornerStyle.bothFlat,
                                                    color:
                                                        const Color(0xFFE5E5E5),
                                                    thicknessUnit:
                                                        GaugeSizeUnit.factor,
                                                  ),
                                                  pointers: <GaugePointer>[
                                                    RangePointer(
                                                        value: resources[indexHor].used.toDouble() / resources[indexHor].quota > 0.1
                                                            ? resources[indexHor].used.toDouble()
                                                            : resources[indexHor].quota * 0.11,
                                                        cornerStyle: CornerStyle.bothCurve,
                                                        width: 0.22,
                                                        sizeUnit: GaugeSizeUnit.factor,
                                                        enableAnimation: true,
                                                        animationDuration: 20,
                                                        color: const Color(0xFF07E897),
                                                        animationType: AnimationType.linear)
                                                  ],
                                                  annotations: <
                                                      GaugeAnnotation>[
                                                    GaugeAnnotation(
                                                        positionFactor: 0.1,
                                                        angle: 90,
                                                        widget: Text(
                                                          resources[indexHor].used.toStringAsFixed(0) + '/' + resources[indexHor].quota.toStringAsFixed(0),
                                                          style: const TextStyle(fontSize: 10, color: Color(0xA3000000), fontWeight: FontWeight.bold),
                                                        ))
                                                  ])
                                            ])),
                                        Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            alignment: Alignment.bottomCenter,
                                            child: Text(
                                                resources[indexHor]
                                                    .type
                                                    .capitalize(),
                                                style: TextStyle(fontSize: 6)))
                                      ],
                                    ) : Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.center, children: [
                                      Text(specials[indexHor - resources.length].title, textAlign: TextAlign.center, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Color(0xFF343F48))),
                                      SizedBox(height: 2,),
                                      Text(specials[indexHor - resources.length].subtitle, textAlign: TextAlign.center, style: TextStyle(fontSize: 6))
                                    ],),
                                  ),
                                );
                              }),
                        )
                      : Container(
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              SizedBox(
                                height: index == 1 ? 0 : 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Flexible(
                                    child: Text(
                                      groups[groups.keys.toList()[index - 1]]
                                          .first
                                          .getHumanName(),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      softWrap: false,
                                      style: TextStyle(
                                          color: Color(0xFF343F48),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Visibility(
                                      visible: false,
                                      child: InkWell(
                                        onTap: () {
                                          mainProvider.excludedMetrics.add(
                                              groups.keys.toList()[index - 1]);
                                        },
                                        child: Icon(Icons.close,
                                            color: Color(0xFF343F48)
                                                .withOpacity(0.2)),
                                      ))
                                ],
                              ),
                              SizedBox(
                                height: 12,
                              ),
                              CardWidget(
                                  child: _dashboardItem(
                                      groups[groups.keys.toList()[index - 1]],
                                      mainProvider,
                                      cloudEyeUsecase))
                            ],
                          ));
                },
              );
          }
        });
  }

  Widget _dashboardItem(List<Metric> metrics, MainProvider mainProvider,
      CloudEyeUsecase cloudEyeUsecase) {
    return ChartView(
      metrics: metrics,
      mainProvider: mainProvider,
      cloudEyeUsecase: cloudEyeUsecase,
      axisVisible: false,
      gesturesControl: false,
    );
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
