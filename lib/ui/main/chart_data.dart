import 'package:flutter/material.dart';
import 'package:sbercloud_flutter/models/cloud_eye_models.dart';

class ChartSampleData {

  ChartSampleData({this.x, this.yValue, this.pointColor, this.text});

  final dynamic x;
  final num yValue;
  final Color pointColor;
  final String text;
}

class ChartDataSeries {

  ChartDataSeries({this.data, this.title, this.unit, this.dimensions});

  final List<ChartSampleData> data;
  final String title;
  final String unit;
  final List<Dimension> dimensions;
}

class Special {
  String title;
  String subtitle;

  Special(this.title, this.subtitle);
}