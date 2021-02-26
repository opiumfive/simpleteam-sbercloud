import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'chart_sample_data.dart';

class ChartView extends StatefulWidget {

  List<ChartSampleData> chartData;
  String title;

  ChartView({Key key, this.title, this.chartData}) : super(key: key);

  @override
  _ChartViewState createState() => _ChartViewState();
}

class _ChartViewState extends State<ChartView> {
  _ChartViewState();

  ZoomMode _zoomModeType = ZoomMode.x;
  ZoomPanBehavior _zoomingBehavior;

  GlobalKey<State> chartKey = GlobalKey<State>();
  StateSetter refreshSetState;
  num left = 0,
      top = 0;
  num screenSizeWidth;
  bool isSameSize;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _zoomingBehavior = ZoomPanBehavior(
        enablePinching: true,
        zoomMode: _zoomModeType,
        enablePanning: true,
        enableMouseWheelZooming: false);

    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      title: ChartTitle(text: widget.title),
      primaryXAxis: DateTimeAxis(
          enableAutoIntervalOnZooming: true,
          majorGridLines: MajorGridLines(width: 0)),
      tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: false),
      trackballBehavior: TrackballBehavior(enable: true),
      zoomPanBehavior: _zoomingBehavior,
      primaryYAxis: NumericAxis(
        enableAutoIntervalOnZooming: true,
        labelFormat: '{value}',
        axisLine: AxisLine(width: 0),
        majorGridLines: MajorGridLines(width: 0),
      ),
      series: getTimeSeries(widget.chartData),
    );
  }

  List<ChartSeries<ChartSampleData, DateTime>> getTimeSeries(List<ChartSampleData> chartData) {
    return <ChartSeries<ChartSampleData, DateTime>>[
      SplineAreaSeries<ChartSampleData, DateTime>(
        borderColor: const Color.fromRGBO(0, 156, 144, 1),
        gradient: const LinearGradient(colors: <Color>[
          Colors.white,
          Color.fromRGBO(255, 232, 149, 0.9)
        ], stops: <double>[
          0.2,
          0.9
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
        borderWidth: 2,
        borderDrawMode: BorderDrawMode.top,
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue,
        name: 'name',
      )
    ];
  }
}

