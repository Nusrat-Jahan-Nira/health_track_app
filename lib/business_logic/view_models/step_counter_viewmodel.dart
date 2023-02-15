import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:health_track_app/business_logic/models/chart_data.dart';
import 'package:health_track_app/business_logic/models/stepcountdb.dart';
import 'package:health_track_app/business_logic/utils/constants/utils_helper.dart';
import 'package:health_track_app/main.dart';
import 'package:health_track_app/services/locator/service_locator.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:workmanager/workmanager.dart';

class StepCounterViewModel extends ChangeNotifier {
  //variable declare
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  String _status = "?", _steps = "0";
  Isar? isar;
  StepCountDB _stepcountdb = StepCountDB();
  List<StepCountDB> _stepcountdbList = [];

  //getter
  String get getStatus => _status;
  String get getSteps => _steps;
  StepCountDB get getStepcountdb => _stepcountdb;
  List<StepCountDB> get getStepcountdbList => _stepcountdbList;

  //setter
  set setSteps(String val) => _steps = val;
  set setStatus(String val) => _status = val;

  void initDatabase() async {
    isar ??= await Isar.open([StepCountDBSchema]);

    initialDataDB();
  }

  void addStep(StepCountDB step) async {
    if (isar != null) {
      isar!.writeTxn(() async {
        int id = await isar!.stepCountDBs.put(step);
        return id;
      });

      _stepcountdb = step;
      notifyListeners();
    }
  }

  Future<void> showDataDB() async {
    // _stepcountdbList = await isar!.stepCountDBs
    //     .where()
    //     .distinctByDate()
    //     .distinctBySteps()
    //     .distinctByStatus()
    //     .findAll();

    DateTime mdateToday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    if (isar != null) {
      _stepcountdbList = await isar!.stepCountDBs
          .where()
          .filter()
          .dateEqualTo(mdateToday)
          .distinctByDate()
          .findAll();
      notifyListeners();
    }
  }

  void initialDataDB() {
    DateTime dateToday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    final aStepCountDB = StepCountDB()
      ..steps = "0"
      ..status = "?"
      ..date = dateToday;

    addStep(aStepCountDB);
  }

  void setDataDB() async {
    DateTime dateToday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    final aStepCountDB = StepCountDB()
      ..steps = _steps
      ..status = _status
      ..date = dateToday;

    addStep(aStepCountDB);
  }

  void onStepCount(StepCount event) {
    print(event);

    showDataDB();

    if (_stepcountdbList.isNotEmpty) {
      _steps = (event.steps - int.parse(_stepcountdbList[0].steps)).toString();
    }
    // _steps = event.steps.toString();

    //_steps = event.steps.toString();

    //setDataDB();

    // StepCountDB stepCountDB = StepCountDB(_steps, _status);
    // addStep(stepCountDB);

    notifyListeners();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);

    _status = event.status;

    // Workmanager()
    //     .registerOneOffTask(simpleTaskKey, simpleTaskKey, inputData: null
    //         // inputData: <String, dynamic>{
    //         //   'int': 1,
    //         //   'bool': true,
    //         //   'double': 1.0,
    //         //   'string': _steps,
    //         //   'array': [1, 2, 3],
    //         // },
    //         );

    // Workmanager().registerPeriodicTask(
    //   simplePeriodicTask,
    //   simplePeriodicTask,
    //   frequency: const Duration(minutes: 15),
    // );

    notifyListeners();
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');

    _status = 'Pedestrian Status not available';

    print(_status);

    notifyListeners();
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');

    _steps = 'Step Count not available';

    notifyListeners();
  }

  Future<void> initPlatformState() async {
    if (await Permission.activityRecognition.request().isGranted) {
      //StepCounterViewModel stepCounterProvider = StepCounterViewModel();
      //stepCounterProvider.initialDataDB();

      _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
      _stepCountStream = await Pedometer.stepCountStream;

      /// Listen to streams and handle errors
      _stepCountStream.listen(onStepCount).onError(onStepCountError);
      _pedestrianStatusStream
          .listen(onPedestrianStatusChanged)
          .onError(onPedestrianStatusError);

      // _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
      // _pedestrianStatusStream
      //     .listen(onPedestrianStatusChanged)
      //     .onError(onPedestrianStatusError);

      // _stepCountStream = Pedometer.stepCountStream;
      // _stepCountStream.listen(onStepCount).onError(onStepCountError);

      notifyListeners();
    }
  }

  Future<void> repeatState() async {
    _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
    _stepCountStream = await Pedometer.stepCountStream;

    /// Listen to streams and handle errors
    _stepCountStream.listen(onStepCount).onError(onStepCountError);
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);
  }
}
