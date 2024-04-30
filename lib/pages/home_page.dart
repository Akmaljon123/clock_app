import 'package:clock_app/models/alarm_model.dart';
import 'package:clock_app/my_app/setup.dart';
import 'package:clock_app/pages/alarm_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool onOff = false;

  Widget clockCard(int i){
    return GestureDetector(
      onTap: (){
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context)=>const AlarmPage()
          )
        );
      },
      child: Container(
        height: 75,
        width: 370,
        decoration: BoxDecoration(
            color: CupertinoColors.black,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
                color: Colors.grey
            )
        ),
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
                "${alarmList![i].hour} : ${alarmList![i].minute}",
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Switch(
                  value: onOff,
                  onChanged: (value) {
                    setState(() {
                      onOff = value;
                    });
                  },
              ),
            )

          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, i)=>clockCard(i),
                  separatorBuilder: (context, i)=>const SizedBox(height: 10),
                  itemCount: alarmList!.length
              ),
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Timer App"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 34
        ),
        backgroundColor: Colors.black,
      ),
    );
  }
}
