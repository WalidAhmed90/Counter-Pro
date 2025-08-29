import 'package:counter_pro/counter_model.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'counter_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CounterModelAdapter());
  await Hive.openBox<CounterModel>('counter_box');

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CounterProvider())
    ],
    child: MyApp(),
  )
  );
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

class CounterScreen extends StatelessWidget{
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final provider = Provider.of<CounterProvider>(context);

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
            Text('${provider.counterModel.count}', style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: provider.isEven() ? Colors.green : Colors.red
            ),),
            SizedBox(height: 20),
            Text('Last updated: ${provider.counterModel.lastUpdated}',
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
          FloatingActionButton(onPressed: provider.increment,
          tooltip: 'Increment',
          child: Icon(Icons.add),),
          SizedBox(width: 20,),
          FloatingActionButton(onPressed: provider.decrement,
          tooltip: 'Decrement',
          child: Icon(Icons.remove),),
          SizedBox(width: 20,),
          FloatingActionButton(onPressed: provider.reset,
          tooltip: 'Reset',
          child: Icon(Icons.refresh),)
        ],
      ),
    );
  }
}

