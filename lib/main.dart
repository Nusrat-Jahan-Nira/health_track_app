import 'dart:io';

import 'package:flutter/material.dart';
import 'package:health_track_app/business_logic/controllers/notification_controller.dart';
import 'package:health_track_app/business_logic/utils/constants/utils_helper.dart';
import 'package:health_track_app/business_logic/utils/styles/color_styles.dart';
import 'package:health_track_app/business_logic/view_models/step_counter_viewmodel.dart';
import 'package:health_track_app/services/locator/service_locator.dart';
import 'package:health_track_app/ui/step_counter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackground = "fetchBackground";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case fetchBackground:
        print("Yes!!!!!!!!!");
        StepCounterViewModel stepCounterProvider = StepCounterViewModel();
        // stepCounterProvider.setSteps = "0";

        //stepCounterProvider.showDataDB();

        // Code to run in background

        break;
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  StepCounterViewModel stepCounterProvider = StepCounterViewModel();

  WidgetsFlutterBinding.ensureInitialized();

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  await Workmanager().registerPeriodicTask(
    "1",
    fetchBackground,
    frequency: const Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health track app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Palette.kToDark,
      ),
      home: const StepCounterScreen(),
    );
  }
}
