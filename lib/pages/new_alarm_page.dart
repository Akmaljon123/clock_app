import 'dart:async';
import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:clock_app/models/alarm_model.dart';
import 'package:clock_app/my_app/setup.dart';
import 'package:clock_app/pages/home_page.dart';
import 'package:clock_app/pages/setting_page.dart';
import 'package:clock_app/services/hive_service.dart';
import 'package:clock_app/services/language_extension_service.dart';
import 'package:flutter/material.dart';

class NewAlarmPage extends StatefulWidget {
  const NewAlarmPage({super.key});

  @override
  State<NewAlarmPage> createState() => _NewAlarmPageState();
}

class _NewAlarmPageState extends State<NewAlarmPage> {
  int hour = 0;
  int minute = 0;
  String name = "";
  bool isSound = false;
  bool isVibration = false;
  bool onOff = false;
  AudioPlayer audioPlayer = AudioPlayer();
  int currentHour = DateTime.now().hour;
  int currentMinute = DateTime.now().minute;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("setAlarm".translate),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 32, color: Colors.white),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context)=>const SettingsPage()
                  )
              );
            },
            icon: const Icon(
              Icons.settings,
              size: 28,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40),
                      child: SizedBox(
                        width: 150,
                        child: ListWheelScrollView.useDelegate(
                          overAndUnderCenterOpacity: 0.7,
                          useMagnifier: true,
                          magnification: 1.2,
                          itemExtent: 40,
                          squeeze: 1,
                          onSelectedItemChanged: (index)async{
                            await audioPlayer.play(AssetSource("musics/click.mp3"));
                            log(hour.toString());
                            hour = index;
                            setState(() {});
                          },
                          physics: const BouncingScrollPhysics(),
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              return Text(
                                index>=0 && index <=9 ? "0$index" : "$index",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              );
                            },
                            childCount: 24,
                          ),
                        ),
                      ),
                    ),

                    const Text(
                      " : ",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 50),
                      child: SizedBox(
                        width: 150,
                        child: ListWheelScrollView.useDelegate(
                          itemExtent: 30,
                          overAndUnderCenterOpacity: 0.7,
                          useMagnifier: true,
                          magnification: 1.2,
                          squeeze: 1,
                          onSelectedItemChanged: (index)async{
                            await audioPlayer.play(AssetSource("musics/click.mp3"));
                            log(index.toString());
                            minute = index;
                            setState(() {});
                          },
                          physics: const BouncingScrollPhysics(),
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              return Text(
                                index>=0 && index <=9 ? "0$index" : "$index",
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              );
                            },
                            childCount: 60,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 800,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.grey.shade900,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)
                    )
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 30),

                    Text(
                      "alarmSoundAfter".translate,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white
                      ),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: RichText(
                            text: TextSpan(
                                text: "alarmSound".translate,
                                style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white
                                ),
                                children: [
                                  const WidgetSpan(
                                    child: SizedBox(height: 5),
                                  ),

                                  TextSpan(
                                      text: "homeComing".translate,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.deepPurple
                                      )
                                  )
                                ]
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 180),
                          child: Switch(
                              value: onOff,
                              onChanged: (value){
                                setState(() {
                                  onOff = value;
                                  isSound = onOff;
                                });
                              }
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 15),

                    Container(
                      height: 2,
                      width: 360,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(15)
                      ),
                    ),

                    const SizedBox(height: 15),

                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: RichText(
                            text: TextSpan(
                                text: "vibration".translate,
                                style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white
                                ),
                                children: [
                                  const WidgetSpan(
                                    child: SizedBox(height: 5),
                                  ),

                                  TextSpan(
                                      text: "call".translate,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.deepPurple
                                      )
                                  )
                                ]
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 220),
                          child: Switch(
                              value: onOff,
                              onChanged: (value){
                                setState(() {
                                  onOff = value;
                                  isVibration = onOff;
                                });
                              }
                          ),
                        )
                      ],
                    ),

                    const SizedBox(height: 350),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        MaterialButton(
                            onPressed: (){},
                            child: Text(
                              "cancel".translate,
                              style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.white
                              ),
                            )
                        ),

                        MaterialButton(
                            onPressed: ()async{
                              AlarmModel alarmModel = AlarmModel(
                                  name: name,
                                  hour: hour.toString(),
                                  isSound: isSound,
                                  isVibration: isVibration,
                                  minute: minute.toString()
                              );
                              await HiveService.saveAlarm(alarmModel: alarmModel);

                              alarmList = await HiveService.getAlarm();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context)=> HomePage()
                                  ),
                                      // (route) => false
                              );

                              if(currentHour >= hour && currentMinute>= minute){
                                int timerHour = currentHour - hour;
                                int timerMinute = currentMinute - minute;
                                
                                await Future.delayed(Duration(hours: timerHour, minutes: timerMinute));
                                await audioPlayer.play(AssetSource("musics/music.mp3"));
                                await Future.delayed(const Duration(seconds: 5));
                                await audioPlayer.stop();
                              }else{
                                int timerHour = hour - currentHour;
                                int timerMinute = minute - currentMinute;

                                log("$timerMinute, $timerHour");
                                await Future.delayed(Duration(hours: timerHour, minutes: timerMinute));
                                log("playing");
                                await audioPlayer.play(AssetSource("musics/music.mp3"));
                                log("playing");
                                setState(() {});
                                await Future.delayed(const Duration(seconds: 5));
                                await audioPlayer.stop();
                              }
                            },
                            child: Text(
                              "create".translate,
                              style: const TextStyle(
                                  fontSize: 28,
                                  color: Colors.white
                              ),
                            )
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
