import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _counter = 0;
  String _lastUpdated = "Never";

  void _incrementCount(){
    setState(() {
      _counter++;
      _lastUpdated = DateTime.now().toLocal().toString();
    });
  }

  void _resetCount(){
    setState(() {
      _counter = 0;
      _lastUpdated = "Reset at ${DateTime.now().toLocal()}";
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isEven = _counter % 2 ==0;
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
            Text('$_counter', style: TextStyle(
              fontSize: 50,
              fontWeight: FontWeight.bold,
              color: isEven ? Colors.green : Colors.red
            ),),
            SizedBox(height: 20),
            Text('Last updated: $_lastUpdated',
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
          FloatingActionButton(onPressed: _incrementCount,
          tooltip: 'Increment',
          child: Icon(Icons.add),),
          SizedBox(width: 20,),
          FloatingActionButton(onPressed: _resetCount,
          tooltip: 'Reset',
          child: Icon(Icons.refresh),)
        ],
      ),
    );
  }
}

