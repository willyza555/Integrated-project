import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key, this.isOpen, required this.handler});
  final bool? isOpen;
  final Function handler;
  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  late bool _isSwitch;
  @override
  void initState() {
    setState(() {
      _isSwitch = !widget.isOpen!;
      print(_isSwitch);
    });
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
              value: _isSwitch,
              activeColor: Color.fromARGB(255, 0, 210, 102),
              onChanged: (value) {
                setState(() {
                  _isSwitch = value;
                  print(_isSwitch);
                  // widget.isOpen = value;
                  widget.handler();
                });
              },
            ),
          ]),
    );
  }
}
