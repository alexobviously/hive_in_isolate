import 'dart:isolate';
import 'package:path_provider/path_provider.dart';
import 'hive_isolate.dart';

class Manager{
  Isolate hiveIsolate;
  SendPort hivePort;

  void init() async{
    ReceivePort initPort = ReceivePort();
    hiveIsolate = await Isolate.spawn(hiveMain, initPort.sendPort);
    hivePort = await initPort.first;
    final appDocDir = await getApplicationDocumentsDirectory();
    String dbPath = appDocDir.path + '/lib/db';
    hivePort.send([dbPath]);
  }
}