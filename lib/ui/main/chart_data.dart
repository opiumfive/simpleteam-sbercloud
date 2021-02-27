import 'package:flutter/material.dart';

class ChartSampleData {

  ChartSampleData({this.x, this.yValue, this.pointColor, this.text});

  final dynamic x;
  final num yValue;
  final Color pointColor;
  final String text;
}

class ChartDataSeries {

  ChartDataSeries({this.data, this.title, this.unit});

  final List<ChartSampleData> data;
  final String title;
  final String unit;
}

class Special {
  String title;
  String subtitle;

  Special(this.title, this.subtitle);
}