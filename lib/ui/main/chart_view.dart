import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sbercloud_flutter/api/providers.dart';
import 'package:sbercloud_flutter/api/usecase/cloud_eye_usecase.dart';
import 'package:sbercloud_flutter/const.dart';
import 'package:sbercloud_flutter/models/base_model.dart';
import 'package:sbercloud_flutter/models/cloud_eye_models.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'chart_data.dart';

class ChartView extends StatefulWidget {
  List<ChartDataSeries> chartData;

  CloudEyeUsecase cloudEyeUsecase;
  MainProvider mainProvider;
  List<Metric> metrics;

  bool axisVisible = true;
  bool gesturesControl = true;

  ChartView(
      {Key key,
      this.metrics,
      this.mainProvider,
      this.cloudEyeUsecase,
      this.axisVisible,
      this.gesturesControl})
      : super(key: key);

  @override
  _ChartViewState createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  _ChartViewState();

  ZoomMode _zoomModeType = ZoomMode.x;
  ZoomPanBehavior _zoomingBehavior;

  GlobalKey<State> chartKey = GlobalKey<State>();
  StateSetter refreshSetState;
  num left = 0, top = 0;
  num screenSizeWidth;
  bool isSameSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _zoomingBehavior = ZoomPanBehavior(
        enablePinching: widget.gesturesControl,
        zoomMode: _zoomModeType,
        enablePanning: widget.gesturesControl,
        enableMouseWheelZooming: false);

    String key =
        widget.metrics[0].namespace + "+" + widget.metrics[0].metric_name;

    Future<List<ChartDataSeries>> loadData() async {
      List<ChartDataSeries> result = List.empty(growable: true);

      for (int i = 0; i < widget.metrics.length; i++) {
        BaseModel<List<Datapoint>> resp = await widget.cloudEyeUsecase
            .metricData(widget.metrics[i], widget.mainProvider.range,
                widget.mainProvider.interval,
                filter: "average");
        if (resp != null && resp.data != null && resp.data.isNotEmpty) {
          List<ChartSampleData> data = resp.data
              .map<ChartSampleData>((e) => ChartSampleData(
                  x: DateTime.fromMillisecondsSinceEpoch(e.timestamp),
                  yValue: e.getData()))
              .toList();

          // add fake point to draw line
          if (data.length == 1)
            data = [
              ChartSampleData(x: data[0].x - 100, yValue: data[0].yValue),
              data[0]
            ];

          result.add(ChartDataSeries(
              dimensions: widget.metrics[i].dimensions,
              data: data,
              title: widget.metrics[i].getHumanTitle(),
              unit: widget.metrics[i].unit));
        }
      }

      widget.mainProvider.chartDataCache[key] = result;

      return result;
    }

    if (widget.mainProvider.chartDataCache.containsKey(key)) {
      widget.chartData = widget.mainProvider.chartDataCache[key];
      return _mainWidget();
    }

    return FutureBuilder(
        future: loadData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return SizedBox(
                height: 140,
                child: Center(
                  child: PlatformCircularProgressIndicator(),
                ),
              );
            default:
              if (snapshot.hasError || snapshot.data == null)
                return Text('fail');

              widget.chartData = snapshot.data;

              return _mainWidget();
          }
        });
  }

  void goDetail() {
    if (widget.gesturesControl == false && widget.chartData.length > 0) {
      Navigator.pushNamed(context, DETAIL_ROUTE, arguments: widget.metrics);
    }
  }

  Widget _mainWidget() {
    return widget.gesturesControl ? _chartWidget() : InkWell(enableFeedback: !widget.gesturesControl,
        canRequestFocus: !widget.gesturesControl,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      onTap: () {
        goDetail();
      }
      , child: IgnorePointer(ignoring: !widget.gesturesControl,child: _chartWidget()));
  }

  Widget _chartWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(padding: EdgeInsets.fromLTRB(12, 12, 12, 4), child:
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Visibility(child: Row(crossAxisAlignment: CrossAxisAlignment.center,children: [
              SvgPicture.asset('assets/images/ic_arrow_up.svg'),
              SizedBox(width: 3,),
              Text(widget.chartData.length > 1 ? "${widget.chartData[1].data.last.yValue} ${widget.chartData[1].unit}" : "",
                style: TextStyle(
                    color: Color(0xFF343F48),
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ],), visible: widget.metrics.length > 1,),

            Visibility(child: Row(crossAxisAlignment: CrossAxisAlignment.center,children: [
              SvgPicture.asset('assets/images/ic_arrow_down.svg'),
              SizedBox(width: 3,),
              Text(widget.chartData.length > 0 ?
              "${widget.chartData[0].data.last.yValue} ${widget.chartData[0].unit}" : "" ,
                style: TextStyle(
                    color: Color(0xFF343F48),
                    fontSize: 11,
                    fontWeight: FontWeight.bold),
              ),
            ],), visible: widget.chartData.length > 0,)

          ],
        ),),
        Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: <Color>[
                Color.fromARGB(15, 7, 232, 151),
                Color.fromARGB(0, 7, 232, 151)
              ], stops: <double>[
                0.0,
                1.0
              ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
            ),
            height: widget.axisVisible? null : 90,
            child: widget.chartData.length > 0 ? SfCartesianChart(
              plotAreaBorderWidth: 0,
              //title: ChartTitle(text: widget.chartData.first.title),
              primaryXAxis: DateTimeAxis(
                  isVisible: widget.axisVisible,
                  enableAutoIntervalOnZooming: true,
                  majorGridLines: MajorGridLines(width: 0)),
              tooltipBehavior:
              TooltipBehavior(enable: widget.gesturesControl, canShowMarker: false),
              trackballBehavior:
              TrackballBehavior(enable: widget.gesturesControl),
              zoomPanBehavior: _zoomingBehavior,
              backgroundColor: Colors.transparent,
              plotAreaBackgroundColor: Colors.transparent,
              legend: Legend(height: "100%", toggleSeriesVisibility: true, isVisible: widget.axisVisible, position: LegendPosition.bottom),
              primaryYAxis: NumericAxis(
                isVisible: widget.axisVisible,
                enableAutoIntervalOnZooming: true,
                labelFormat: '{value}',
                axisLine: AxisLine(width: 0),
                majorGridLines: MajorGridLines(width: 0),
              ),
              series: getTimeSeries(widget.chartData),
            ) : Center(child: Text("No data"),)
        ),
        Container(padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4), child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,

          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              SvgPicture.asset('assets/images/ic_eye_12dp.svg'),
              SizedBox(width: 6,),
              Text(
                widget.metrics[0].getHumanNamespace(),
                style: TextStyle(
                    color: Color(0xFF343F48).withOpacity(0.37),
                    fontSize: 9,
                    fontWeight: FontWeight.bold),
              ),
            ],),


            Text(
              'Updated   ${DateFormat("hh:mm:ss", "ru").format(DateTime.now())}',
              style: TextStyle(
                  color: Color(0xFF343F48).withOpacity(0.37),
                  fontSize: 9,
                  fontWeight: FontWeight.bold),
            ),

          ],
        ),)

      ],
    );
  }

  List<ChartSeries<ChartSampleData, DateTime>> getTimeSeries(
      List<ChartDataSeries> chartData) {
    List<Color> colors = <Color>[
      Color.fromARGB(214, 52, 63, 72),
      Color.fromARGB(255, 7, 232, 151)
    ];

    int colorIndex = 0;
    List<ChartSeries<ChartSampleData, DateTime>> result = chartData
        .map<ChartSeries<ChartSampleData, DateTime>>(
            (e) => SplineSeries<ChartSampleData, DateTime>(
                  color: colors[colorIndex++ % colors.length],
                  width: 3,
                  dataSource: e.data,
                  xValueMapper: (ChartSampleData sales, _) => sales.x,
                  yValueMapper: (ChartSampleData sales, _) => sales.yValue + (widget.axisVisible ? 0 : 1000000),
                  name: e.dimensions.first.value.length > 15 ? e.dimensions.first.value.substring(0, 14) + ".." : e.dimensions.first.value,
                ))
        .toList();
    return result;
  }
}
