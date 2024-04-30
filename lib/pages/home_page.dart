import 'package:audioplayers/audioplayers.dart';
import 'package:clock_app/my_app/setup.dart';
import 'package:clock_app/pages/alarm_page.dart';
import 'package:clock_app/pages/new_alarm_page.dart';
import 'package:clock_app/pages/setting_page.dart';
import 'package:clock_app/services/hive_service.dart';
import 'package:clock_app/services/language_extension_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  bool? isPlaying;
  HomePage({super.key, this.isPlaying});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onOff = false;
  AudioPlayer audioPlayer = AudioPlayer();

  Widget clockCard(int i, bool switcher) {
    return GestureDetector(
      onLongPress: ()async{
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.black,
              title: const Text("Do you want to delete this note?"),
              titleTextStyle: TextStyle(
                fontSize: 24,
                color: Colors.white.withOpacity(0.7),
              ),
              content: const Text(
                  "You will not be able to restore this note once you delete it."),
              contentTextStyle: TextStyle(
                  fontSize: 16, color: Colors.white.withOpacity(0.7)),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.red),
                        alignment: Alignment.center,
                        child: const Text(
                          "No",
                          style:
                          TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: ()async{
                        await HiveService.deleteData(i);
                        alarmList = await HiveService.getAlarm();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context)=> HomePage()),
                                (route) => false);
                      },
                      child: Container(
                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Colors.green),
                        alignment: Alignment.center,
                        child: const Text(
                          "Yes",
                          style:
                          TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ));
      },
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AlarmPage(i: i)));
      },
      child: Container(
        height: 75,
        width: 370,
        decoration: BoxDecoration(
            color: CupertinoColors.black,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Icon(
                Icons.alarm,
                color: Colors.white.withOpacity(0.7),
                size: 36,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 120),
              child: Text(
                "${alarmList[i].hour} : ${alarmList[i].minute}",
                style: const TextStyle(fontSize: 22, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Switch(
                value: switcher,
                onChanged: (value) {
                  setState(() {
                    switcher = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: TextButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SettingsPage()));
          },
          child: Text(
              "title".translate,
            style: const TextStyle(
              fontSize: 28
            ),
          ),
        ),
        titleTextStyle: const TextStyle(color: Colors.white, fontSize: 34),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, i) => clockCard(i, true),
                separatorBuilder: (context, i) => const SizedBox(height: 10),
                itemCount: alarmList.length,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewAlarmPage()));
        },
        child: Container(
          height: 75,
          width: 75,
          decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.grey),
              shape: BoxShape.circle),
          child: const Icon(
            Icons.add,
            size: 30,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
