import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import 'counter_model.dart';

class CounterProvider extends ChangeNotifier {
  final Box<CounterModel> _box = Hive.box<CounterModel>('counter_box');

  CounterModel get counterModel =>
      _box.get('counter') ??
          CounterModel(count: 0, lastUpdated: DateTime.now().toLocal().toString());

  void increment() {
    final current = _box.get('counter') ??
        CounterModel(count: 0, lastUpdated: DateTime.now().toLocal().toString());

    final updated = current.copyWith(
      count: current.count + 1,
      lastUpdated: DateTime.now().toLocal().toString(),
    );

    _box.put('counter', updated);
    notifyListeners();
  }

  void decrement() {
    final current = _box.get('counter') ??
        CounterModel(count: 0, lastUpdated: DateTime.now().toLocal().toString());

    if (current.count == 0) return;

    final updated = current.copyWith(
      count: current.count - 1,
      lastUpdated: DateTime.now().toLocal().toString(),
    );

    _box.put('counter', updated);
    notifyListeners();
  }

  void reset() {
    final updated =
    CounterModel(count: 0, lastUpdated: DateTime.now().toLocal().toString());
    _box.put('counter', updated);
    notifyListeners();
  }

  bool isEven() {
    final counter = _box.get('counter');
    if (counter != null) {
      return counter.count % 2 == 0;
    }
    return true; // default case: treat 0 as even
  }
}
