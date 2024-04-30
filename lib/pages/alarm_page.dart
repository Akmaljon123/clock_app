import 'package:clock_app/models/alarm_model.dart';
import 'package:clock_app/my_app/setup.dart';
import 'package:clock_app/pages/home_page.dart';
import 'package:clock_app/services/hive_service.dart';
import 'package:flutter/material.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({super.key});

  @override
  State<AlarmPage> createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  String hour = "";
  String minute = "";
  String name = "";
  bool isSound = false;
  bool isVibration = false;
  bool onOff = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Set your Alarm"),
        centerTitle: true,
        titleTextStyle: const TextStyle(fontSize: 32, color: Colors.white),
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
                          onSelectedItemChanged: (index){
                            hour = index.toString();
                          },
                          physics: const BouncingScrollPhysics(),
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              return Text(
                                "${index + 1}",
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
                          onSelectedItemChanged: (index){
                            minute = index.toString();
                          },
                          physics: const BouncingScrollPhysics(),
                          childDelegate: ListWheelChildBuilderDelegate(
                            builder: (context, index) {
                              return Text(
                                "${index + 1}",
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

                    const Text(
                        "Alarm will sound after 6 hour 32 minutes",
                      textAlign: TextAlign.center,
                      style: TextStyle(
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
                            text: const TextSpan(
                                text: "Alarm Sound\n",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white
                                ),
                                children: [
                                  WidgetSpan(
                                    child: SizedBox(height: 5),
                                  ),

                                  TextSpan(
                                      text: "Homecoming",
                                      style: TextStyle(
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
                            text: const TextSpan(
                                text: "Vibration\n",
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.white
                                ),
                                children: [
                                  WidgetSpan(
                                    child: SizedBox(height: 5),
                                  ),

                                  TextSpan(
                                      text: "Basic call",
                                      style: TextStyle(
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
                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white
                              ),
                            )
                        ),

                        MaterialButton(
                            onPressed: ()async{
                              AlarmModel alarmModel = AlarmModel(
                                  name: name,
                                  hour: hour,
                                  isSound: isSound,
                                  isVibration: isVibration,
                                  minute: minute
                              );
                              await HiveService.saveAlarm(alarmModel: alarmModel);

                              alarmList = await HiveService.getAlarm();
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context)=>HomePage()
                                  ),
                                      (route) => false
                              );
                            },
                            child: const Text(
                              "Create",
                              style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white
                              ),
                            )
                        )
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
