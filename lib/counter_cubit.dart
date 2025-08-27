import 'package:counter_pro/data/models/counter_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class CounterCubit extends Cubit<CounterModel>{
  final _box = Hive.box<CounterModel>('counter_box');

  CounterCubit() : super(
    Hive.box<CounterModel>('counter_box').get('counter', defaultValue:CounterModel(count: 0, lastUpdated: 'Never Updated'))!
  );

  void increment() {
    final newState = state.copyWith(
      count: state.count + 1,
      lastUpdated: DateTime.now().toLocal().toString(),
    );
    emit(newState);
    _save(newState);
  }
  void decrement() {
    if (state.count <= 0) return;
    final newState = state.copyWith(
      count: state.count - 1,
      lastUpdated: DateTime.now().toLocal().toString(),
    );
    emit(newState);
    _save(newState);
  }

  void reset() {
    final newState = state.copyWith(
      count: 0,
      lastUpdated: 'Reset at ${DateTime.now().toLocal()}',
    );
    emit(newState);
    _save(newState);
  }

  bool isEven() {
    return state.count % 2 == 0;
  }


  void _save(CounterModel counterModel){
    _box.put('counter', counterModel);
  }

}