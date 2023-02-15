import 'package:isar/isar.dart';

part 'stepcountdb.g.dart';

@Collection()
class StepCountDB {
  Id id = Isar.autoIncrement;

  String steps = "0";

  String status = "?";

  late DateTime date;

  //StepCountDB(this.steps, this.status);
}
