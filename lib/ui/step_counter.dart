// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:health_track_app/business_logic/controllers/notification_controller.dart';
import 'package:health_track_app/business_logic/models/chart_data.dart';
import 'package:health_track_app/business_logic/utils/constants/utils_helper.dart';
import 'package:health_track_app/business_logic/utils/styles/text_styles.dart';
import 'package:health_track_app/business_logic/view_models/step_counter_viewmodel.dart';
import 'package:health_track_app/main.dart';
import 'package:health_track_app/services/locator/service_locator.dart';
import 'package:health_track_app/ui/components/common/title_text_widget.dart';
import 'package:health_track_app/ui/components/step_counter/progress_title_widget.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
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
    // Workmanager().initialize(
    //   callbackDispatcher,
    //   isInDebugMode: false,
    // );

    //_chartData = getChartData();
    //NotificationController.startListeningNotificationEvents();
    stepCounterProvider.initDatabase();

    super.initState();

    // util.getStepCountAcess().then((value) {
    //   if (value == "true") {
    //     stepCounterProvider.setStatus = "?";
    //     stepCounterProvider.setSteps = "0";

    //stepCounterProvider.initialDataDB();
    stepCounterProvider.initPlatformState();
    // }

    //   return null;
    // });
    // final prefs = await SharedPreferences.getInstance();
    // String access = prefs.getString("StepCountAcess") ?? "false";

    // if (access == "true") {
    //   stepCounterProvider.setStatus = "?";
    //   stepCounterProvider.setSteps = "0";

    //   stepCounterProvider.initDatabase();
    //   stepCounterProvider.initPlatformState();
    // }

    // stepCounterProvider.showDataDB();
  }

  // void onStepCount(StepCount event) {
  //   print(event);
  //   setState(() {
  //     _steps = event.steps.toString();

  //     Workmanager().registerOneOffTask(
  //       simpleTaskKey,
  //       simpleTaskKey,
  //       inputData: <String, dynamic>{
  //         'int': 1,
  //         'bool': true,
  //         'double': 1.0,
  //         'string': _steps,
  //         'array': [1, 2, 3],
  //       },
  //     );
  //   });
  // }

  // void onPedestrianStatusChanged(PedestrianStatus event) {
  //   print(event);
  //   setState(() {
  //     _status = event.status;
  //   });
  // }

  // void onPedestrianStatusError(error) {
  //   print('onPedestrianStatusError: $error');
  //   setState(() {
  //     _status = 'Pedestrian Status not available';
  //   });
  //   print(_status);
  // }

  // void onStepCountError(error) {
  //   print('onStepCountError: $error');
  //   setState(() {
  //     _steps = 'Step Count not available';
  //   });
  // }

  // Future<void> initPlatformState() async {
  //   if (await Permission.activityRecognition.request().isGranted) {
  //     _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
  //     _pedestrianStatusStream
  //         .listen(onPedestrianStatusChanged)
  //         .onError(onPedestrianStatusError);

  //     _stepCountStream = Pedometer.stepCountStream;
  //     _stepCountStream.listen(onStepCount).onError(onStepCountError);
  //   }
  // }

  String? calculateCalories(int steps) {
    var calories = (steps * .04);

    return calories.toStringAsFixed(2);
  }

  String? calculateHeartRate(int steps, int age) {
    var heartRate = 207 - (age * 0.7);

    return heartRate.toString();
  }

  List<ChartData> getChartData() {
    final List<ChartData> chartData = [
      ChartData(2010, 35),
      ChartData(2011, 28),
      ChartData(2012, 34),
      ChartData(2013, 32),
      ChartData(2014, 40)
    ];

    return chartData;
  }

  @override
  Widget build(BuildContext context) {
    //int nSteps = _steps.isNotEmpty ? int.parse(_steps) : 0;
    //stepCounterProvider.showDataDB();
    return Scaffold(
      appBar: AppBar(title: const Text("Step Counter"), elevation: 0),
      body: ChangeNotifierProvider<StepCounterViewModel>(
        create: (context) => stepCounterProvider,
        child: Container(
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
                      border: Border.all(color: Colors.deepPurple, width: 30),
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
                  Container(
                    margin: const EdgeInsets.all(30.0),
                    padding: const EdgeInsets.all(10.0),
                    child: Consumer<StepCounterViewModel>(
                        builder: (context, modelDataa, child) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(child: Consumer<StepCounterViewModel>(
                              builder: (context, dataDB, child) {
                            return dataDB.getStepcountdb.steps.contains("0")
                                ? const TitleTextWidget(
                                    title: "Steps", value: "0")
                                : TitleTextWidget(
                                    title: "Steps",
                                    value:
                                        dataDB.getStepcountdb.steps.toString());
                          })),
                          //   }
                          // ),
                          Expanded(
                              child: TitleTextWidget(
                                  title: "Bpm",
                                  value: calculateHeartRate(
                                      int.parse(modelDataa.getSteps), 26))),
                          Expanded(
                              child: TitleTextWidget(
                                  title: "State",
                                  value: modelDataa.getStatus.toString())),
                        ],
                      );
                    }),
                  ),

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
                      itemBuilder: (BuildContext context, int index) => Column(
                        children: [
                          Text("Date: " +
                              dataDB.getStepcountdbList[index].date.toString()),
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
        ),
      ),
      endDrawer: const Drawer(),
    );
  }
}
