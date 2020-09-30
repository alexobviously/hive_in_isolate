import 'package:flutter/material.dart';
import 'manager.dart';
import 'hive_isolate.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hive in Isolate',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Hive in Isolate'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () async{
              copyDatabase();
            },
            tooltip: "Copy DB",
            child: Icon(Icons.content_copy),
          ),
          FloatingActionButton(
            onPressed: () async{
              //String p = Directory.current.path;
              //print(p);
              //Hive.init('${p}db');
              //Box db = await Hive.openBox('test');
              Box db = await openBoxFromAsset('test', 'assets/test.hive');
              print(db.get(0));
            },
            tooltip: 'Test',
            child: Icon(Icons.check),
          ),
          FloatingActionButton(
            onPressed: (){
              Manager manager = Manager();
              manager.init();
            },
            tooltip: 'DB',
            child: Icon(Icons.sd_card),
          ),
        ],
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
