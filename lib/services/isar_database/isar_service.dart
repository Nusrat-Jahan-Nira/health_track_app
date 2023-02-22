import 'package:health_track_app/business_logic/models/initialstepcountdb.dart';
import 'package:health_track_app/business_logic/models/stepcountdb.dart';
import 'package:isar/isar.dart';

class IsarService {
  late Future<Isar> db;

  IsarService() {
    db = openIsar();
  }

  Future<Isar> openIsar() async {
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open(
        [InitialStepCountDBSchema, StepCountDBSchema],
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  Future<void> createStep(StepCountDB stepCountDB) async {
    final isar = await db;
    await isar.writeTxn(() => isar.stepCountDBs.clear());
    isar.writeTxnSync<int>(() => isar.stepCountDBs.putSync(stepCountDB));
  }

  Future<void> createInitialStep(InitialStepCountDB stepCountDB) async {
    final isar = await db;
    //await isar.writeTxn(() => isar.initialStepCountDBs.clear());
    isar.writeTxnSync<int>(() => isar.initialStepCountDBs.putSync(stepCountDB));
  }

  Stream<List<StepCountDB>> getAllSteps(DateTime date) async* {
    //print(search);
    final isar = await db;
    final query = isar.stepCountDBs.where().filter().dateEqualTo(date).build();

    await for (final results in query.watch(fireImmediately: true)) {
      if (results.isNotEmpty) {
        print(results);
        yield results;
      }
    }
  }

  Stream<List<StepCountDB>> getAllStepsSevenDays(DateTime date) async* {
    //print(search);
    DateTime nowFiveDaysAfter = DateTime.now().add(const Duration(days: 7));
    final isar = await db;
    final query = isar.stepCountDBs
        .where()
        .filter()
        .dateBetween(date, nowFiveDaysAfter)
        .build();

    await for (final results in query.watch(fireImmediately: true)) {
      if (results.isNotEmpty) {
        print(results);
        yield results;
      }
    }
  }

  // Stream<List<InitialStepCountDB>> getInitialStep() async* {
  //   //print(search);
  //   final isar = await db;

  //  yield* isar.initialStepCountDBs.where().watch(fireImmediately: true);

  // }

  // final isar = await openIsar();
  // int id;

  // isar.writeTxn(() async {
  //     id = await isar.stepCountDBs.put(stepCountDB);
  //     return id;
  //   });
  // final object = await isar.stepCountDBs.get(id);
  // object!.steps = stepCountDB.steps;
  // object.date = stepCountDB.date;
  // await isar.stepCountDBs.put(object);
  // }

  // Future<void> createInitialStep(InitialStepCountDB initialStepCountDB) async {
  //   final isar = await db;

  //   await isar.writeTxn(() => isar.clear());

  //   isar.writeTxnSync<int>(
  //       () => isar.initialStepCountDBs.putSync(initialStepCountDB));
  // }

  // Stream<List<StepCountDB>> getStep() async* {
  //   final isar = await db;

  //   yield*
  //       await isar.stepCountDBs
  //       .where()
  //       .filter();

  //   // yield* isar.stepCountDBs.where().watch(fireImmediately: true);
  // }
}
