
import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';

import 'counter_model.dart';

class CounterProvider extends ChangeNotifier{

  final _box = Hive.box<CounterModel>('counter_box');


  CounterModel get countryModel =>
      _box.get('counter') ?? CounterModel(count: 0, lastUpdated: DateTime.now().toLocal().toString());

  void increment(){
    final counter = _box.get('counter');
    if(counter != null){
      _box.put('counter', counter.copyWith(count: counter.count + 1, lastUpdated: DateTime.now().toLocal().toString()));
    }
    notifyListeners();
  }

  void decrement(){
    final counter = _box.get('counter');
    if(counter != null){
      if(counter.count == 0){
        return;
      }
      _box.put('counter', counter.copyWith(count: counter.count - 1, lastUpdated: DateTime.now().toLocal().toString()));
    }
    notifyListeners();
  }

  void reset(){
    _box.put('counter', CounterModel(count: 0, lastUpdated: DateTime.now().toLocal().toString()));
    notifyListeners();
  }

  bool isEven(){
    final counter = _box.get('counter');
    if(counter != null){
      return counter.count % 2 == 0;
    }
    return false;
  }
}