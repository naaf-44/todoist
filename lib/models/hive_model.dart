import 'package:hive/hive.dart';

part 'hive_model.g.dart';

@HiveType(typeId: 0)
class HiveModel extends HiveObject {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? status;

  @HiveField(2)
  String? startDate;

  @HiveField(3)
  String? endDate;

  HiveModel({this.id, this.status, this.startDate, this.endDate});
}