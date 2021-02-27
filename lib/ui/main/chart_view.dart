import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:sbercloud_flutter/api/providers.dart';
import 'package:sbercloud_flutter/api/usecase/cloud_eye_usecase.dart';
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

  ChartView({Key key, this.metrics, this.mainProvider, this.cloudEyeUsecase, this.axisVisible, this.gesturesControl}) : super(key: key);

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

    Future<List<ChartDataSeries>> loadData() async {

      String key = widget.metrics[0].namespace + "+" + widget.metrics[0].metric_name;
      if (widget.mainProvider.chartDataCache.containsKey(key)) {

        return widget.mainProvider.chartDataCache[key];
      }
      
      List<ChartDataSeries> result = List.empty(growable: true);

      for (int i = 0; i < widget.metrics.length; i++) {
        BaseModel<List<Datapoint>> resp = await widget.cloudEyeUsecase.metricData(widget.metrics[i],
            widget.mainProvider.range,
            widget.mainProvider.interval,
            filter: "average");
        if (resp != null && resp.data != null) {
          List<ChartSampleData> data = resp.data
              .map<ChartSampleData>((e) => ChartSampleData(x: DateTime.fromMillisecondsSinceEpoch(e.timestamp), yValue: e.getData()))
              .toList();

          // add fake point to draw line
          if (data.length == 1) data = [ChartSampleData(x: data[0].x - 100, yValue: data[0].yValue), data[0]];

          result.add(ChartDataSeries(data: data, title: widget.metrics[i].getHumanTitle(), unit: widget.metrics[i].unit));
        }
      }

      widget.mainProvider.chartDataCache[key] = result;

      return result;
    }

    return FutureBuilder(
        future: loadData(),
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

              widget.chartData = snapshot.data;

              return _mainWidget();
          }
        });
  }

  Widget _mainWidget() {
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
        //title: ChartTitle(text: widget.chartData.first.title),
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

  List<ChartSeries<ChartSampleData, DateTime>> getTimeSeries(List<ChartDataSeries> chartData) {

    List<Color> colors = <Color>[
      Color.fromARGB(214, 52,63,72),
      Color.fromARGB(255, 7,232,151)
    ];

    int colorIndex = 0;
    List<ChartSeries<ChartSampleData, DateTime>> result = chartData.map<ChartSeries<ChartSampleData, DateTime>>((e) => SplineSeries<ChartSampleData, DateTime>(
      color: colors[colorIndex++ % colors.length],
      width: 4,
      dataSource: e.data,
      xValueMapper: (ChartSampleData sales, _) => sales.x,
      yValueMapper: (ChartSampleData sales, _) => sales.yValue,
      name: e.title,
    )).toList();
    return result;

    /*return <ChartSeries<ChartSampleData, DateTime>>[
      SplineSeries<ChartSampleData, DateTime>(
        color: const Color.fromRGBO(52, 63, 72, 84),
        width: 5,
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue,
        name: 'name',
      ),
      SplineSeries<ChartSampleData, DateTime>(
        color: const Color.fromRGBO(52, 63, 72, 84),
        width: 5,
        dataSource: chartData,
        xValueMapper: (ChartSampleData sales, _) => sales.x,
        yValueMapper: (ChartSampleData sales, _) => sales.yValue,
        name: 'name',
      )
    ];*/
  }
}

