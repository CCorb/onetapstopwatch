import 'package:flutter/material.dart';
import 'package:flutter_circular_chart_two/flutter_circular_chart_two.dart';

List<CircularStackEntry> data;
dynamic color = Colors.green[200];

List<CircularStackEntry> setData(int sec) {
  data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(sec / 60, Colors.amber[400]),
        new CircularSegmentEntry(((60 - sec) / 60) * 100, Colors.green[200]),
      ],
    ),
  ];
  return data;
}

void setColor(bool isRunning) {
  if (isRunning) {
    color = Colors.red[500];
  } else {
    color = Colors.green[200];
  }
}

List<CircularStackEntry> getData() {
  data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(100.0, color),
      ],
    ),
  ];
  return data;
}

List<CircularStackEntry> getData2(bool isRunning) {
  setColor(isRunning);
  data = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(100.0, color),
      ],
    ),
  ];
  return data;
}
