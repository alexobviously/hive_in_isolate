import 'package:hive/hive.dart';

void main() async{
  Hive.init('db');
  Box db = await Hive.openBox('test');
  await db.put(0,'abcdef');
  await db.put(1,'defghhjdsfg');
  print(db.get(0));
}