import 'package:choice/choice.dart';
import 'package:clock_app/pages/home_page.dart';
import 'package:clock_app/services/language_extension_service.dart';
import 'package:clock_app/services/language_service.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedChoice = "en";
  String selectedCountryChoice = "US";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Choice(
              builder: (context, i) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RadioListTile(
                      title: const Text('English'),
                      value: 'English',
                      groupValue: selectedChoice,
                      onChanged: (String? value) {
                        setState(() {
                          selectedChoice = value!;
                          selectedCountryChoice = "US";
                        });
                      },
                      activeColor: Colors.black,
                    ),
                    RadioListTile(
                      title: const Text('Russian'),
                      value: 'Russian',
                      groupValue: selectedChoice,
                      onChanged: (String? value) {
                        setState(() {
                          selectedChoice = value!;
                          selectedCountryChoice = "RU";
                        });
                      },
                      activeColor: Colors.black,
                    ),
                    RadioListTile(
                      title: const Text('Uzbek'),
                      value: 'Uzbek',
                      groupValue: selectedChoice,
                      onChanged: (String? value) {
                        setState(() {
                          selectedChoice = value!;
                          selectedCountryChoice = "UZ";
                        });
                      },
                      activeColor: Colors.black,
                    ),
                    const SizedBox(height: 20),
                    Text('Selected choice: $selectedChoice'),
                  ],
                );
              },
            ),
            
            GestureDetector(
              onTap: (){
                LanguageService.switchLanguage(selectedChoice.substring(0,2).toLowerCase());
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context)=>HomePage()
                    ),
                        (route) => false
                );
              },
              child: Container(
                height: 75,
                width: 360,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.grey
                  )
                ),
                alignment: Alignment.center,
                child: Text(
                    "update".translate,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 22
                  ),
                ),
              ),
            )
          ],
        ),
      )
      );
  }
}
