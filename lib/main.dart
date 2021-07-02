import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_circular_chart_two/flutter_circular_chart_two.dart';
import 'package:onetapstopwatch/StopWatchTimer.dart';
import 'package:wakelock/wakelock.dart';
import './Data.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black87,
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'One Tap Stopwatch',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyTappableView(),
    );
  }
}

class MyTappableView extends StatefulWidget {
  @override
  _MyTappableView createState() => _MyTappableView();
}

class _MyTappableView extends State<MyTappableView> {
  static const platform =
      const MethodChannel('de.cco.OneTapStopWatch/ButtonHook');
  final Dependencies dependencies = new Dependencies();
  dynamic color = Colors.green[400];
  List<CircularStackEntry> data;
  final GlobalKey<AnimatedCircularChartState> _chartKey =
      new GlobalKey<AnimatedCircularChartState>();

  void initState() {
    super.initState();
    platform.setMethodCallHandler(_getButton);
  }

  Future<void> _getButton(MethodCall call) async {
    setState(() {
      if (dependencies.stopwatch.isRunning) {
        dependencies.stopwatch.stop();
      } else {
        dependencies.stopwatch.start();
      }
      _chartKey.currentState
          .updateData(getData2(dependencies.stopwatch.isRunning));
    });
    final int result = await platform.invokeMethod("onKeyDown");
  }

  AnimatedCircularChart getChart() {
    return new AnimatedCircularChart(
        key: _chartKey,
        size: const Size(300.0, 300.0),
        initialChartData: getData(),
        chartType: CircularChartType.Radial);
  }

  @override
  Widget build(BuildContext context) {
    Wakelock.enable();
    return new Scaffold(
      body: GestureDetector(

          /// Start-Stop logic
          onTap: () {
            //final snackBar = SnackBar(content: Text("Tap"));
            print("Tapped");
            //Scaffold.of(context).showSnackBar(snackBar);
            setState(() {
              if (dependencies.stopwatch.isRunning) {
                dependencies.stopwatch.stop();
              } else {
                dependencies.stopwatch.start();
              }
              _chartKey.currentState
                  .updateData(getData2(dependencies.stopwatch.isRunning));
            });
          },

          /// Resets timer
          onDoubleTap: () {
            print("doubleTapped");
            dependencies.stopwatch.stop();
            dependencies.stopwatch.reset();
            _chartKey.currentState
                .updateData(getData2(dependencies.stopwatch.isRunning));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              //new Container(
              Expanded(
                  child: Container(
                color: Colors.black87,
              )),
              getChart(),
              TimerText(
                dependencies: dependencies,
              ),
              Expanded(
                  child: Container(
                color: Colors.black87,
              )),
            ],

            //height: double.infinity,
            // width: double.infinity,
            // color: Colors.amber)

            //SizedBox.expand(child: Container()),
          )),
      backgroundColor: Colors.black87,
    );
  }
}
