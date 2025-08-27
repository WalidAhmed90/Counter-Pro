import 'package:counter_pro/counter_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/models/counter_model.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CounterModelAdapter());
  await Hive.openBox<CounterModel>('counter_box');

  runApp(
    BlocProvider(
      create: (_) => CounterCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CounterScreen(),
      ),
    ),
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
  
    return Scaffold(
      appBar: AppBar(title: Text('Counter Pro'),),
      body: BlocBuilder<CounterCubit, CounterModel>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Counter Value:',
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold
                    )
                ),
                Text('${state.count}', style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: context.read<CounterCubit>().isEven() ? Colors.green : Colors.red
                ),),
                SizedBox(height: 20),
                Text('Last updated: ${state.lastUpdated}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14
                  ),),
              ],
            ),
          );
        }
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(onPressed: context.read<CounterCubit>().increment,
          tooltip: 'Increment',
          child: Icon(Icons.add),),
          SizedBox(width: 20,),
          FloatingActionButton(onPressed: context.read<CounterCubit>().decrement,
          tooltip: 'Decrement',
          child: Icon(Icons.remove),),
          SizedBox(width: 20,),
          FloatingActionButton(onPressed: context.read<CounterCubit>().reset,
          tooltip: 'Reset',
          child: Icon(Icons.refresh),)
        ],
      ),
    );
  }
}

