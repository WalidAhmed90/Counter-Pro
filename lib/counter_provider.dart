import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import 'counter_model.dart';


class CounterNotifier extends StateNotifier<CounterModel> {
  final Box _box = Hive.box<CounterModel>('counterBox');

  CounterNotifier()
      : super(
    Hive.box<CounterModel>('counterBox').get(
      'counter',
      defaultValue: CounterModel(count: 0, lastUpdated: "Never Updated"),
    )!,
  );

  void increment() {
   final updateState = state.copyWith(
      count: state.count + 1,
      lastUpdated: DateTime.now().toLocal().toString(),
    );
    _saveToHive(updateState);
  }

  void decrement() {
    if (state.count == 0) {
      return;
    }
    final updateState = state.copyWith(
      count: state.count - 1,
      lastUpdated: DateTime.now().toLocal().toString(),
    );
    _saveToHive(updateState);
  }

  void reset() {
    final updateState = CounterModel(
      count: 0,
      lastUpdated: "Reset at ${DateTime.now().toLocal()}",
    );
    _saveToHive(updateState);
  }

  bool isEven(){
    return state.count % 2 == 0;
  }

  void _saveToHive(CounterModel newState) {
    _box.put('counter', newState);
    state = newState;
  }
}

final counterProvider =
StateNotifierProvider<CounterNotifier, CounterModel>((ref) {
  return CounterNotifier();
});
