import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ChooseFac extends StatefulWidget {
  @override
  _ChooseFacState createState() => _ChooseFacState();
}

class _ChooseFacState extends State<ChooseFac> {
  String? dropdownValue = "One";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: DropdownButton<String>(
        hint: Text("اختر كليتك"),
        value: dropdownValue,
        icon: const Icon(Icons.arrow_downward),
        iconSize: 24,
        elevation: 16,
        style: const TextStyle(color: Colors.deepPurple),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
            print(newValue);
          });
        },
        items: <String>['One', 'Two', 'Free', 'Four']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }
}
