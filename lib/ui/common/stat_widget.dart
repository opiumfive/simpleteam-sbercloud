import 'package:flutter/material.dart';
import 'package:sbercloud_flutter/ui/common/icon_widget.dart';

class StatBlockView extends StatefulWidget {
  final String serviceIcon;
  final String serviceName;
  final String sumTitle;
  final String date;
  final Map<String, int> data;
  final int max;

  StatBlockView(
      {Key key,
      this.serviceIcon,
      this.serviceName,
      this.sumTitle,
      this.date,
      this.data,
      this.max})
      : super(key: key);

  @override
  _StatBlockState createState() => _StatBlockState();
}

class _StatBlockState extends State<StatBlockView> {
  static final _serviceNameStyle = TextStyle(
      color: Color(0x5E343F48), fontSize: 9.0, fontWeight: FontWeight.w600);
  static final _dateStyle = TextStyle(
      color: Color(0x5E343F48), fontSize: 9.0, fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    var sum;
    if (widget.max != null) {
      sum = widget.max;
    } else {
      if (widget.data != null) {
        sum = 0;
        widget.data.forEach((key, value) {
          sum += value;
        });
      }
    }

    var rows;
    if (widget.data != null && widget.data.isNotEmpty) {
      rows = _RowsValue(data: widget.data, sum: sum);
    } else {
      rows = Container();
    }
    return Padding(
      padding: const EdgeInsets.fromLTRB(12.0, 24.0, 12.0, 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 1, child: rows),
              _StatSum(sum, title: widget.sumTitle)
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              widget.serviceIcon != null
                  ? Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 3.0),
                    child: SberIcon(widget.serviceIcon),
                  )
                  : SizedBox(),
              Text(widget.serviceName ?? "", style: _serviceNameStyle),
              Spacer(),
              Text(widget.date ?? "", style: _dateStyle),
            ],
          )
        ],
      ),
    );
  }
}

class _StatSum extends StatelessWidget {
  final int sum;
  final String title;

  const _StatSum(this.sum, {Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(sum != null ? sum.toString() : "",
            style: TextStyle(color: Color(0xED343F48), fontSize: 32.0)),
        Text(title ?? "",
            style: TextStyle(
                color: Color(0xED343F48),
                fontSize: 6.0,
                fontWeight: FontWeight.w600))
      ],
    );
  }
}

class _RowsValue extends StatelessWidget {
  final Map<String, int> data;
  final int sum;

  static final _titleStyle = TextStyle(
      color: Color(0xB8343F48), fontSize: 8.0, fontWeight: FontWeight.w600);
  static final _valueStyle = TextStyle(
      color: Color(0xB8343F48), fontSize: 8.0, fontWeight: FontWeight.w600);

  const _RowsValue({Key key, this.data, this.sum}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var titles = [
      for (var e in data.entries)
        Container(
            alignment: Alignment.center,
            height: 20.0,
            child: Text(e.key, style: _titleStyle))
    ];
    var progresses = [
      for (var e in data.entries)
        Container(
            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
            alignment: Alignment.center,
            height: 20.0,
            child: _StatProgressView(value: e.value, max: sum))
    ];

    var values = [
      for (var e in data.entries)
        Container(
            padding: const EdgeInsets.fromLTRB(12.0, 0.0, 12.0, 0.0),
            alignment: Alignment.center,
            height: 20.0,
            child: Text(e.value.toString(), style: _valueStyle))
    ];
    return Container(
      padding: const EdgeInsets.fromLTRB(5.0, 0.0, 5.0, 0.0),
      child: Row(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: titles),
          Expanded(
              flex: 1,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: progresses)),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start, children: values),
        ],
      ),
    );
  }
}

class _StatProgressView extends StatefulWidget {
  final int value;
  final int max;

  _StatProgressView({Key key, this.value, this.max}) : super(key: key);

  @override
  _StatProgressState createState() => _StatProgressState();
}

class _StatProgressState extends State<_StatProgressView>
    with SingleTickerProviderStateMixin {
  CurvedAnimation animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    animation =
        new CurvedAnimation(parent: controller, curve: Curves.decelerate)
          ..addListener(() {
            setState(() {});
          });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final fullWidth = constraints.maxWidth;
      var percentWidth;
      if (widget.max > 0) {
        percentWidth = (fullWidth * (widget.value.toDouble() / widget.max)) *
            animation.value;
      } else {
        percentWidth = 0;
      }

      return Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.0),
                  color: Color(0x4AD2D2D2)),
              width: fullWidth,
              height: 8.0),
          Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9.0),
                  color: Color(0xFF07E897)),
              width: percentWidth,
              height: 8.0)
        ],
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
