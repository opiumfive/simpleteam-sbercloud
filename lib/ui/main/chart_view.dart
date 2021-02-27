import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import 'chart_sample_data.dart';

class ChartView extends StatefulWidget {

  List<ChartSampleData> chartData;
  String title;
  bool axisVisible = true;
  bool gesturesControl = true;

  ChartView({Key key, this.title, this.chartData, this.axisVisible, this.gesturesControl}) : super(key: key);

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
        enablePinching: widget.gesturesControl,
        zoomMode: _zoomModeType,
        enablePanning: widget.gesturesControl,
        enableMouseWheelZooming: false);

    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: <Color>[
          Color.fromARGB(15, 7,232,151),
          Color.fromARGB(0, 7,232,151)
        ], stops: <double>[
          0.0,
          1.0
        ], begin: Alignment.bottomCenter, end: Alignment.topCenter),
      ),
      child: SfCartesianChart(
        plotAreaBorderWidth: 0,
        title: ChartTitle(text: widget.title),
        primaryXAxis: DateTimeAxis(
          isVisible: widget.axisVisible,
            enableAutoIntervalOnZooming: true,
            majorGridLines: MajorGridLines(width: 0)),
        tooltipBehavior: TooltipBehavior(enable: true, canShowMarker: false),
        trackballBehavior: TrackballBehavior(enable: widget.gesturesControl),
        zoomPanBehavior: _zoomingBehavior,
        backgroundColor: Colors.transparent,
        primaryYAxis: NumericAxis(
          isVisible: widget.axisVisible,
          enableAutoIntervalOnZooming: true,
          labelFormat: '{value}',
          axisLine: AxisLine(width: 0),
          majorGridLines: MajorGridLines(width: 0),
        ),
        series: getTimeSeries(widget.chartData),
      ),
    );
  }

  List<ChartSeries<ChartSampleData, DateTime>> getTimeSeries(List<ChartSampleData> chartData) {
    return <ChartSeries<ChartSampleData, DateTime>>[
      SplineSeries<ChartSampleData, DateTime>(
        color: const Color.fromRGBO(52, 63, 72, 84),
        width: 5,
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue,
        name: 'name',
      )
    ];
  }
}

