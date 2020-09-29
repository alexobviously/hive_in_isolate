import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:isolate';

void hiveMain(SendPort sendPort) async{
  ReceivePort receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  final msg = await receivePort.first;
  String dbPath = msg[0];
  print(dbPath);
  Hive.init(dbPath);
  Box db = await Hive.openBox('test');
  print(db.get(0));
  print(db.get(1));
}