import 'package:clock_app/models/alarm_model.dart';
import 'package:hive/hive.dart';

class HiveService{
  static Future<void> saveAlarm({required AlarmModel alarmModel})async{
    final box = await Hive.openBox("alarm");
    await box.add(alarmModel);
  }

  static Future<void> updateData(AlarmModel alarmModel,int i)async{
    var box = await Hive.openBox("alarm");
    await box.putAt(i, alarmModel);
  }

  static Future<void> deleteData(int i)async{
    var box = await Hive.openBox("alarm");
    await box.deleteAt(i);
  }

  static Future<List<AlarmModel>> getAlarm() async {
    final box = await Hive.openBox("alarm");
    List<dynamic> alarmList = box.values.toList();


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