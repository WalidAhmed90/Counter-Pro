import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

import 'counter_model.dart';
import 'counter_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(CounterModelAdapter());
  await Hive.openBox<CounterModel>('counterBox');


  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Counter Pro',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CounterScreen(),
    );
  }
}

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {

    final counterState = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(title: Text('Counter Pro'),),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter Value:',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold
                )
            ),
            Text('${counterState.count}', style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: ref.read(counterProvider.notifier).isEven() ? Colors.green : Colors.red
            ),),
            SizedBox(height: 20),
            Text('Last updated: ${counterState.lastUpdated}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14
            ),),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: ref.read(counterProvider.notifier).increment,
          tooltip: 'Increment',
          child: Icon(Icons.add),),
          SizedBox(width: 20,),
          FloatingActionButton(onPressed: ref.read(counterProvider.notifier).decrement,
          tooltip: 'Increment',
          child: Icon(Icons.remove),),
          SizedBox(width: 20,),
          FloatingActionButton(onPressed: ref.read(counterProvider.notifier).reset,
          tooltip: 'Reset',
          child: Icon(Icons.refresh),)
        ],
      ),
    );
  }
}

