import 'dart:async';
import 'package:flutter/material.dart';
import 'package:health_track_app/business_logic/models/initialstepcountdb.dart';
import 'package:health_track_app/business_logic/models/stepcountdb.dart';
import 'package:health_track_app/services/isar_database/isar_service.dart';
import 'package:isar/isar.dart';
import 'package:pedometer/pedometer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StepCounterViewModel extends ChangeNotifier {
  //variable declare
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  int _steps = 0;

  List<InitialStepCountDB> _initialStepDB = [];
  List<StepCountDB> _StepDB = [];
  List<StepCountDB> _stepcountdbList = [];
  int _firstFlag = 0;

  //getter
  List<InitialStepCountDB> get getInitialStepDB => _initialStepDB;
  List<StepCountDB> get getStepDB => _StepDB;
  int get getFirstFlag => _firstFlag;

  void checkBackgroundSteps() {
    final isarService = IsarService();
    isarService.db.then((isar) async {
      final stepCollection = isar.initialStepCountDBs;
      _initialStepDB = (await stepCollection.where().findAll());

      isarService.db.then((isar) async {
        final astepCollection = isar.stepCountDBs;
        _StepDB = (await astepCollection.where().findAll());

        if (_initialStepDB != null && _StepDB != null) {
          if (_StepDB[0].steps > _initialStepDB[0].steps) {
            _steps = _StepDB[0].steps - _initialStepDB[0].steps;
          } else {
            _steps = _initialStepDB[0].steps - _StepDB[0].steps;
          }

          setDataDB(_steps, isarService);
        }
      });
    });

    isarService.db.then((isar) async {
      final stepCollection = isar.initialStepCountDBs;
      _initialStepDB = (await stepCollection.where().findAll());

      if (_initialStepDB != null) {
        int tempStepCount = _steps - _initialStepDB[0].steps;

        print("tempStepCount" + tempStepCount.toString());

        setDataDB(tempStepCount, isarService);
      }
    });
  }

  void setFlagValue() async {
    print("flag Value" + "1");

    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setInt("flagValue", 1);
  }

  void setDataDB(int stepValue, IsarService isarService) async {
    DateTime dateToday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    final stepCounter = StepCountDB()
      ..steps = stepValue
      ..status = "Walking"
      ..date = dateToday;

    isarService.createStep(stepCounter);

    print("added" + stepCounter.steps.toString());

    //notifyListeners();
  }

  void saveInitialStepDB(StepCount stepValue, IsarService isarService) async {
    DateTime dateToday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    final stepCounter = InitialStepCountDB()
      ..steps = stepValue.steps
      ..date = stepValue.timeStamp;

    isarService.createInitialStep(stepCounter);

    print("added" + stepCounter.steps.toString());

    //notifyListeners();
  }

  void onStepCount(StepCount event) {
    print(event);

    final isarService = IsarService();
    int tempStep;

    isarService.db.then((isar) async {
      final stepCollection = isar.initialStepCountDBs;
      _initialStepDB = (await stepCollection.where().findAll());

      if (_initialStepDB != null) {
        _steps = event.steps - _initialStepDB[0].steps;
        setDataDB(_steps, isarService);
      }
    });

    notifyListeners();
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    //print(event);

    // _status = event.status;
    notifyListeners();
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');

    // _status = 'Pedestrian Status not available';

    // print(_status);

    notifyListeners();
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');

    // _steps = 'Step Count not available';

    notifyListeners();
  }

  Future<void> initPlatformState(IsarService isarService) async {
    if (await Permission.activityRecognition.request().isGranted) {
      _pedestrianStatusStream = await Pedometer.pedestrianStatusStream;
      _stepCountStream = await Pedometer.stepCountStream;

      StepCount test = await Pedometer.stepCountStream.first;

      saveInitialStepDB(await Pedometer.stepCountStream.first, isarService);

      /// Listen to streams and handle errors
      _stepCountStream.listen(onStepCount).onError(onStepCountError);
      _pedestrianStatusStream
          .listen(onPedestrianStatusChanged)
          .onError(onPedestrianStatusError);
    }
  }
}
