import 'package:hive/hive.dart';

part 'counter_model.g.dart';

@HiveType(typeId: 0)
class CounterModel extends HiveObject{

  @HiveField(0)
  int count = 0;

  @HiveField(1)
  String lastUpdated = "Never";

  CounterModel({required this.count, required this.lastUpdated});

  CounterModel copyWith({int? count, String? lastUpdated}) {
    return CounterModel(
      count: count ?? this.count,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

}