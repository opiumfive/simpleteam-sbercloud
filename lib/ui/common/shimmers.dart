import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return ListView.builder(
      itemCount: 7,
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
