import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';

class SwitchScreen extends StatefulWidget {
  @override
  SwitchClass createState() => new SwitchClass();
}

class SwitchClass extends State {
  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 237, 223, 223),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  <Widget>[
            CustomSwitch(
              value: isSwitched,
              activeColor: Color.fromARGB(255, 0, 210, 102),
              onChanged: (value) {
                setState(() {
                  isSwitched = value;
                });
              },
            ),
            
          ]
          ),
    );
  }
}
