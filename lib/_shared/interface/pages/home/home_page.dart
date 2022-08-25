import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? themeMode = 'System';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Welcome John",
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(
            height: 100,
          ),
          DropdownButton(
              value: themeMode,
              alignment: Alignment.centerLeft,
              icon: const Icon(Icons.arrow_drop_down_circle),
              items: ['System', 'Light', 'Dark']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  themeMode = newValue;
                });
              }),
        ],
      ),
    );
  }
}
