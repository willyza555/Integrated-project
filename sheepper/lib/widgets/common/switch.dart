import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key, this.isOpen, required this.handler});
  late bool? isOpen;
  final Function handler;
  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromARGB(255, 237, 223, 223),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CustomSwitch(
              key: ,
              value: true,
              activeColor: Color.fromARGB(255, 0, 210, 102),
              onChanged: (value) {
                print(value);
                setState(() {
                  widget.isOpen = value;
                  widget.handler();
                });
              },
            ),
          ]),
    );
  }
}
