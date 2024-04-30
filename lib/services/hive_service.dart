import 'package:clock_app/models/alarm_model.dart';
import 'package:clock_app/my_app/setup.dart';
import 'package:hive/hive.dart';

class HiveService{
  static Future<void> saveAlarm({required AlarmModel alarmModel})async{
    final box = await Hive.openBox("alarm");
    alarmList?.add(alarmModel);
    await box.add(alarmList);
  }


  static Future<List<AlarmModel>> getAlarm() async {
    final box = await Hive.openBox("alarm");
    List<dynamic> alarmList = box.values.toList();

    // Now try to cast each value individually to AlarmModel
    List<AlarmModel> castedAlarmList = [];
    for (var value in alarmList) {
      if (value is AlarmModel) {
        castedAlarmList.add(value);
      } else {
      }
    }

    return castedAlarmList;
  }



}