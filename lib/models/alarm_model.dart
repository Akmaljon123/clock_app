import 'package:hive/hive.dart';
part 'alarm_model.g.dart';

@HiveType(typeId: 0)
class AlarmModel{
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String hour;
  @HiveField(2)
  late String minute;
  @HiveField(3)
  late bool isSound;
  @HiveField(4)
  late bool isVibration;

  AlarmModel({
    required this.name,
    required this.hour,
    required this.isSound,
    required this.isVibration,
    required this.minute
  });

  AlarmModel.fromJson(Map<String, Object?> json){
    name = json["name"] as String;
    hour = json["hour"] as String;
    minute = json["minute"] as String;
    isSound = json["isSound"] as bool;
    isVibration = json["isVibration"] as bool;
  }

  Map<String, Object?> toJson(){
    return {
      "name": name,
      "hour": hour,
      "minute": minute,
      "isSound": isSound,
      "isVibration": isVibration
    };
  }

}