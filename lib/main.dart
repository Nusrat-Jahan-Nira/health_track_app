import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';
import 'package:health_track_app/business_logic/controllers/notification_controller.dart';
import 'package:health_track_app/business_logic/utils/constants/utils_helper.dart';
import 'package:health_track_app/business_logic/utils/styles/color_styles.dart';
import 'package:health_track_app/business_logic/view_models/step_counter_viewmodel.dart';
import 'package:health_track_app/services/isar_database/isar_service.dart';
import 'package:health_track_app/services/locator/service_locator.dart';
import 'package:health_track_app/ui/step_counter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackground = "fetchBackground";
const fetchBackground24 = "fetchBackground24";
const simpleTask = "simpleTask";
StepCounterViewModel stepCounterProvider = StepCounterViewModel();

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    switch (task) {
      case simpleTask:
        final isarService = IsarService();
        stepCounterProvider.initPlatformState(isarService);

        break;
      case fetchBackground:
        print("Yes!!!!!!!!!");

        stepCounterProvider.checkBackgroundSteps();

        // Code to run in background

        break;
      case fetchBackground24:
        final isarService = IsarService();
        stepCounterProvider.initPlatformState(isarService);
        stepCounterProvider.checkBackgroundSteps();
        break;
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  StepCounterViewModel stepCounterProvider = StepCounterViewModel();

  WidgetsFlutterBinding.ensureInitialized();

  stepCounterProvider.setFlagValue();
  //stepCounterProvider.initDatabase();
  //stepCounterProvider.setSteps = "0";

  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);

  await Workmanager().registerPeriodicTask(
    "1",
    fetchBackground,
    frequency: const Duration(minutes: 15),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );

  await Workmanager().registerPeriodicTask(
    "1",
    fetchBackground24,
    frequency: const Duration(hours: 24),
    constraints: Constraints(
      networkType: NetworkType.connected,
    ),
  );

  stepCounterProvider.setFlagValue();

  final dir = await getApplicationSupportDirectory();

  //  final aisarService = IsarService();
  //  aisarService.openIsar();

  runApp(MyApp());

  startForegroundService();
}

void startForegroundService() async {
  ForegroundService().start();
  debugPrint("Started service");
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
      home: StepCounterScreen(),
    );
  }
}
