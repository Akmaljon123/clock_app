import 'package:clock_app/models/alarm_model.dart';
import 'package:clock_app/services/hive_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/adapters.dart';
List<AlarmModel> alarmList = [];


Future<void> setup()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmModelAdapter());
  alarmList = await HiveService.getAlarm();
}