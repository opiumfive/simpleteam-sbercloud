import 'dart:async';

import 'file:///C:/Users/opiumfive/StudioProjects/sbercloud_flutter/lib/api/usecase/auth_usecase.dart';
import 'package:sbercloud_flutter/api/providers.dart';
import 'package:sbercloud_flutter/ext.dart';
import 'package:sbercloud_flutter/models/base_model.dart';
import 'package:sbercloud_flutter/models/auth_models.dart';
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
    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

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
        backgroundColor: Colors.white,//Color.fromARGB(255, 21, 50, 67),
        body: PageTransitionSwitcher(
          child: case2(_currentIndex, {
            0: Container(
              key: UniqueKey(),
              padding: EdgeInsets.all(16.0),
              child: _mainWidget(),
            ),
            1: Text('two'),
            2: ProfileScreen()
          }, Text('default')),
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

    return Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Card(
            child: ChartView(chartData: chartData),
            shadowColor: Color(0xFF234395).withOpacity(0.2),
            elevation: 15,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),

          ChartView(chartData: chartData).addNeumorphism(
            topShadowColor: Colors.white,
            bottomShadowColor: Color(0xFF234395).withOpacity(0.2),
          )
        ])
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
