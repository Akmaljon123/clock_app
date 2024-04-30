import 'package:clock_app/my_app/my_app.dart';
import 'package:clock_app/my_app/setup.dart';
import 'package:flutter/cupertino.dart';

void main()async{
  await setup();
  runApp(const MyApp());
}