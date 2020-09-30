import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:isolate';
import 'package:flutter/services.dart';


Future<Box<T>> openBoxFromAsset<T>(String boxName, String assetName) async {
  var data = await rootBundle.load(assetName);
  var bytes = data.buffer.asUint8List();
  return Hive.openBox<T>(boxName, bytes: bytes);
}

void hiveMain(SendPort sendPort) async{
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  // Box db = await openBoxFromAsset('test','assets/test.hive');
  final msg = await receivePort.first;
  // Box db = msg[0];
  String dbPath = msg[0];
  print(dbPath);
  Hive.init(dbPath);
  Box db = await Hive.openBox('test');
  print(db.get(0));
  print(db.get(1));
}