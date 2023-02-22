import 'package:isar/isar.dart';

part 'initialstepcountdb.g.dart';

@Collection()
class InitialStepCountDB {
  Id id = Isar.autoIncrement;
  late int steps;
  late DateTime date;
}
