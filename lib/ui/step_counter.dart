// import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health_track_app/business_logic/controllers/notification_controller.dart';
import 'package:health_track_app/business_logic/models/chart_data.dart';
import 'package:health_track_app/business_logic/utils/constants/utils_helper.dart';
import 'package:health_track_app/business_logic/utils/styles/text_styles.dart';
import 'package:health_track_app/business_logic/view_models/step_counter_viewmodel.dart';
import 'package:health_track_app/main.dart';
import 'package:health_track_app/services/locator/service_locator.dart';
import 'package:health_track_app/ui/components/common/title_text_widget.dart';
import 'package:health_track_app/ui/components/step_counter/dashboard_card.dart';
import 'package:health_track_app/ui/components/step_counter/progress_title_widget.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sensors_plus/sensors_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

class StepCounterScreen extends StatefulWidget {
  const StepCounterScreen({super.key});

  @override
  State<StepCounterScreen> createState() => _StepCounterScreenState();
}

class _StepCounterScreenState extends State<StepCounterScreen> {
  // late Stream<StepCount> _stepCountStream;
  // late Stream<PedestrianStatus> _pedestrianStatusStream;
  // String _status = "?", _steps = "0";
  // //final List<PricePoint> points;

  List<ChartData> _chartData = [];
  StepCounterViewModel stepCounterProvider = StepCounterViewModel();

  @override
  void initState() {
    stepsSensor = 0;
    stepCounterProvider.initDatabase();
    super.initState();
    stepCounterProvider.initPlatformState();
  }

  // String? calculateHeartRate(int steps, int age) {
  //   var heartRate = 207 - (age * 0.7);

  //   return heartRate.toString();
  // }

  // List<ChartData> getChartData() {
  //   final List<ChartData> chartData = [
  //     ChartData(2010, 35),
  //     ChartData(2011, 28),
  //     ChartData(2012, 34),
  //     ChartData(2013, 32),
  //     ChartData(2014, 40)
  //   ];

  //   return chartData;
  // }

  double x = 0.0;
  double y = 0.0;
  double z = 0.0;
  double miles = 0.0;
  double duration = 0.0;
  double calories = 0.0;
  double addValue = 0.025;
  int stepsSensor = 0;
  double previousDistacne = 0.0;
  double distance = 0.0;

  int stepsActual = 0;

  double getValue(double x, double y, double z) {
    double magnitude = sqrt(x * x + y * y + z * z);
    getPreviousValue();
    double modDistance = magnitude - previousDistacne;
    setPreviousValue(magnitude);
    return modDistance;
  }

  void getPreviousValue() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    setState(() {
      previousDistacne = _pref.getDouble("preValue") ?? 0.0;
    });
  }

  void setPreviousValue(double distance) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setDouble("preValue", distance);
  }

  // void calculate data
  double calculateMiles(int steps) {
    double milesValue = (2.2 * steps) / 5280;
    return milesValue;
  }

  double calculateDuration(int steps) {
    double durationValue = (steps * 1 / 1000);
    return durationValue;
  }

  double calculateCalories(int steps) {
    double caloriesValue = (steps * 0.0566);
    return caloriesValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Step Counter"), elevation: 0),
      body: ChangeNotifierProvider<StepCounterViewModel>(
          create: (context) => stepCounterProvider,
          child: StreamBuilder<AccelerometerEvent>(
              stream: SensorsPlatform.instance.accelerometerEvents,
              builder: (context, snapShort) {
                if (snapShort.hasData) {
                  x = snapShort.data!.x;
                  y = snapShort.data!.y;
                  z = snapShort.data!.z;
                  distance = getValue(x, y, z);
                  if (distance > 6) {
                    if (stepsSensor > 0) {
                      stepsSensor++;
                    }
                  }
                  calories = calculateCalories(stepsSensor);
                  duration = calculateDuration(stepsSensor);
                  miles = calculateMiles(stepsSensor);
                }
                return Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  height: double.infinity,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Wrap(
                      children: [
                        Column(children: [
                          const ProgressTitleWidget(),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            width: 200.0,
                            height: 200.0,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(
                                  color: Colors.deepPurple, width: 30),
                              shape: BoxShape.circle,
                            ),
                            child: Consumer<StepCounterViewModel>(
                                builder: (context, modelDataa, child) {
                              return Center(
                                child: modelDataa.getSteps.isNotEmpty
                                    ? Text(
                                        calculateCalories(
                                                int.parse(modelDataa.getSteps))
                                            .toString(),
                                        style: stepcounterTextStyle,
                                      )
                                    : const Text("0"),
                                // Text(
                                //   _steps,
                                //   style: stepcounterTextStyle,
                                // ),
                              );
                            }),
                          ),
                          dashboardCard(stepsSensor, miles, calories, duration),
                          // Container(
                          //   margin: const EdgeInsets.all(30.0),
                          //   padding: const EdgeInsets.all(10.0),
                          //   child: Consumer<StepCounterViewModel>(
                          //       builder: (context, modelDataa, child) {
                          //     return Row(
                          //       crossAxisAlignment: CrossAxisAlignment.center,
                          //       mainAxisAlignment: MainAxisAlignment.center,
                          //       children: [
                          //         Expanded(child:
                          //             Consumer<StepCounterViewModel>(
                          //                 builder: (context, data, child) {
                          //           // return dataDB.getStepcountdb.steps.contains("0")
                          //           //     ? const TitleTextWidget(
                          //           //         title: "Steps", value: "0")
                          //           //     : TitleTextWidget(
                          //           //         title: "Steps",
                          //           //         value:
                          //           //             dataDB.getStepcountdb.steps.toString());

                          //           return int.parse(data.getSteps) >
                          //                   stepsSensor
                          //               ? TitleTextWidget(
                          //                   title: "Steps",
                          //                   value: (int.parse(data.getSteps) -
                          //                           stepsSensor)
                          //                       .toString())
                          //               : TitleTextWidget(
                          //                   title: "Steps",
                          //                   value: stepsSensor.toString());
                          //         })),
                          //         //   }
                          //         // ),
                          //         Expanded(
                          //             child: TitleTextWidget(
                          //                 title: "Bpm",
                          //                 value: calculateHeartRate(
                          //                     int.parse(modelDataa.getSteps),
                          //                     26))),
                          //         Expanded(
                          //             child: TitleTextWidget(
                          //                 title: "State",
                          //                 value:
                          //                     modelDataa.getStatus.toString())),
                          //       ],
                          //     );
                          //   }),
                          // ),

                          Container(
                            margin: const EdgeInsets.all(30.0),
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                                onTap: () {
                                  stepCounterProvider.showDataDB();
                                },
                                child: const Text("Last 7 days")),
                          ),

                          Consumer<StepCounterViewModel>(
                              builder: (context, dataDB, child) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemCount: dataDB.getStepcountdbList.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  Column(
                                children: [
                                  Text("Date: " +
                                      dataDB.getStepcountdbList[index].date
                                          .toString()),
                                  Text("Steps: " +
                                      dataDB.getStepcountdbList[index].steps
                                          .toString()),
                                ],
                              ),
                            );
                          }),

                          // AspectRatio(
                          //   aspectRatio: 2,
                          //   child: LineChart(
                          //     LineChartData(
                          //       lineBarsData: [
                          //         LineChartBarData(
                          //           spots: _chartData
                          //               .map((point) => FlSpot(point.year, point.sales))
                          //               .toList(),
                          //           isCurved: false,
                          //           // dotData: FlDotData(
                          //           //   show: false,
                          //           // ),
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // )

                          // LineChart(
                          //   LineChartData(
                          //       // write your logic
                          //       ),
                          //   swapAnimationDuration: const Duration(milliseconds: 150),
                          //   // OptionalswapAnimationCurve: Curves.linear,
                          //   // Optional
                          // )
                        ]),
                      ],
                    ),
                  ),
                );
              })),
      endDrawer: const Drawer(),
    );
  }
}
