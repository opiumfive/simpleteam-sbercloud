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
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sbercloud_flutter/ui/profile/profile_screen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:animations/animations.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../const.dart';
import 'chart_sample_data.dart';
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
    AuthApiUsecase api = Provider.of<AuthApiUsecase>(context);
    User user = Provider.of<UserProvider>(context, listen: false).user;
    MainProvider mainProvider =
        Provider.of<MainProvider>(context, listen: false);

    var bottomNavigationBarItems = <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: const Icon(Icons.add_comment),
        label: 'One',
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.calendar_today),
        label: 'Two',
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.account_circle),
        label: 'Three',
      ),
    ];

    return Scaffold(
        backgroundColor: Colors.white, //Color.fromARGB(255, 21, 50, 67),
        body: PageTransitionSwitcher(
          child: case2(
              _currentIndex,
              {
                0: Center(child: Container(
                  key: UniqueKey(),
                  //padding: EdgeInsets.all(16.0),
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

              return CarouselSlider.builder(
                options: CarouselOptions(
                    height: 350,
                    initialPage: 0,
                    enableInfiniteScroll: false,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.horizontal),
                itemCount: metrics.length,
                itemBuilder: (ctx, index, realIdx) {
                  return Container(
                    child: FutureBuilder(
                        future: cloudEyeUsecase.metricData(metrics[index],
                            DateTimeRange(
                            start: DateTime.now().subtract(Duration(hours: 24)),
                            end: DateTime.now()),
                            3600,
                            filter: "average"),
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
                              final List<ChartSampleData> chartData = snapshot.data.data
                                  .map<ChartSampleData>((e) => ChartSampleData(
                                  x: DateTime.fromMillisecondsSinceEpoch(
                                      (e as Datapoint).timestamp),
                                  yValue: (e as Datapoint).getData()))
                                  .toList();

                              if (chartData.length == 1) chartData.add(chartData[0]);

                              return Card(
                                  shadowColor: Color(0xFF234395).withOpacity(0.2),
                                  elevation: 15,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(metrics[index].namespace + " " + metrics[index].metric_name + " " + metrics[index].unit),
                                        ChartView(
                                          chartData: chartData,
                                          axisVisible: false,
                                          gesturesControl: false,
                                        ),
                                      ]));
                          }
                        })
                  );
                },
              );
          }
        });



    return FutureBuilder(
        future: datapoints(),
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
              final List<ChartSampleData> chartData = snapshot.data
                  .map<ChartSampleData>((e) => ChartSampleData(
                      x: DateTime.fromMillisecondsSinceEpoch(
                          (e as Datapoint).timestamp),
                      yValue: (e as Datapoint).getData()))
                  .toList();

              return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    Card(
                      child: ChartView(
                        chartData: chartData,
                        axisVisible: false,
                      ),
                      shadowColor: Color(0xFF234395).withOpacity(0.2),
                      elevation: 15,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    )
                  ]));
          }
        });

    final List<ChartSampleData> chartData = <ChartSampleData>[
      ChartSampleData(x: DateTime(2015, 1, 1), yValue: 1.13),
      ChartSampleData(x: DateTime(2015, 2, 1), yValue: 1.12),
      ChartSampleData(x: DateTime(2015, 3, 1), yValue: 1.08),
      ChartSampleData(x: DateTime(2015, 4, 1), yValue: 1.12),
      ChartSampleData(x: DateTime(2015, 5, 1), yValue: 1.1),
      ChartSampleData(x: DateTime(2015, 6, 1), yValue: 1.12),
      ChartSampleData(x: DateTime(2015, 7, 1), yValue: 1.1),
      ChartSampleData(x: DateTime(2015, 8, 1), yValue: 1.12),
      ChartSampleData(x: DateTime(2015, 9, 1), yValue: 1.12),
      ChartSampleData(x: DateTime(2015, 10, 1), yValue: 1.1),
      ChartSampleData(x: DateTime(2015, 11, 1), yValue: 1.06),
      ChartSampleData(x: DateTime(2015, 12, 1), yValue: 1.09),
      ChartSampleData(x: DateTime(2016, 1, 1), yValue: 1.09),
      ChartSampleData(x: DateTime(2016, 2, 1), yValue: 1.09),
      ChartSampleData(x: DateTime(2016, 3, 1), yValue: 1.14),
      ChartSampleData(x: DateTime(2016, 4, 1), yValue: 1.14),
      ChartSampleData(x: DateTime(2016, 5, 1), yValue: 1.12),
      ChartSampleData(x: DateTime(2016, 6, 1), yValue: 1.11),
      ChartSampleData(x: DateTime(2016, 7, 1), yValue: 1.11),
      ChartSampleData(x: DateTime(2016, 8, 1), yValue: 1.11),
      ChartSampleData(x: DateTime(2016, 9, 1), yValue: 1.12),
      ChartSampleData(x: DateTime(2016, 10, 1), yValue: 1.1),
      ChartSampleData(x: DateTime(2016, 11, 1), yValue: 1.08),
      ChartSampleData(x: DateTime(2016, 12, 1), yValue: 1.05),
      ChartSampleData(x: DateTime(2017, 1, 1), yValue: 1.08),
      ChartSampleData(x: DateTime(2017, 2, 1), yValue: 1.06),
      ChartSampleData(x: DateTime(2017, 3, 1), yValue: 1.07),
      ChartSampleData(x: DateTime(2017, 4, 1), yValue: 1.09),
      ChartSampleData(x: DateTime(2017, 5, 1), yValue: 1.12),
      ChartSampleData(x: DateTime(2017, 6, 1), yValue: 1.14),
      ChartSampleData(x: DateTime(2017, 7, 1), yValue: 1.17),
      ChartSampleData(x: DateTime(2017, 8, 1), yValue: 1.18),
      ChartSampleData(x: DateTime(2017, 9, 1), yValue: 1.18),
      ChartSampleData(x: DateTime(2017, 10, 1), yValue: 1.16),
      ChartSampleData(x: DateTime(2017, 11, 1), yValue: 1.18),
      ChartSampleData(x: DateTime(2017, 12, 1), yValue: 1.2),
      ChartSampleData(x: DateTime(2018, 1, 1), yValue: 1.25),
      ChartSampleData(x: DateTime(2018, 2, 1), yValue: 1.22),
      ChartSampleData(x: DateTime(2018, 3, 1), yValue: 1.23),
      ChartSampleData(x: DateTime(2018, 4, 1), yValue: 1.21),
      ChartSampleData(x: DateTime(2018, 5, 1), yValue: 1.17),
      ChartSampleData(x: DateTime(2018, 6, 1), yValue: 1.17),
      ChartSampleData(x: DateTime(2018, 7, 1), yValue: 1.17),
      ChartSampleData(x: DateTime(2018, 8, 1), yValue: 1.17),
      ChartSampleData(x: DateTime(2018, 9, 1), yValue: 1.16),
      ChartSampleData(x: DateTime(2018, 10, 1), yValue: 1.13),
      ChartSampleData(x: DateTime(2018, 11, 1), yValue: 1.14),
      ChartSampleData(x: DateTime(2018, 12, 1), yValue: 1.15)
    ];
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
