import 'dart:isolate';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'hive_isolate.dart';
import 'package:hive/hive.dart';

Future<void> copyDatabase() async{
  Directory directory = await getApplicationDocumentsDirectory();
  var dbPath = join(directory.path, "test.hive");
  if (FileSystemEntity.typeSync(dbPath) == FileSystemEntityType.notFound) {
    ByteData data = await rootBundle.load("assets/test.hive");
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(dbPath).writeAsBytes(bytes);
  }
}

class Manager{
  Isolate hiveIsolate;
  SendPort hivePort;

  void init() async{
    //await copyDatabase();
    ReceivePort initPort = ReceivePort();
    hiveIsolate = await Isolate.spawn(hiveMain, initPort.sendPort);
    hivePort = await initPort.first;
    final appDocDir = await getApplicationDocumentsDirectory();
    //String dbPath = join(appDocDir.path, 'test.hive');
    //Box db = await openBoxFromAsset('test', 'assets/test.hive');
    hivePort.send([appDocDir.path]);
  }
}