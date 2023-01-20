import 'dart:async';

import 'package:android_autostart/android_autostart.dart';
import 'package:flutter/material.dart';

import '../../db/config.dart';
import '../intents.dart';

class ApplyButton extends StatefulWidget {
  final int index;
  final Map<String ,String> changeLog;
  final FocusNode focusNode;
  final FocusNode nearestFocusNode;
  final StreamController focusStream;
  const ApplyButton({super.key, required this.index, required this.focusNode, required this.nearestFocusNode, required this.focusStream, required this.changeLog});

  @override
  State<ApplyButton> createState() => _ApplyButtonState();
}

class _ApplyButtonState extends State<ApplyButton> {
  late DataBase db;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 1,
      right: 1,
      child: Actions(
        actions: <Type, Action<Intent>>{
          SelectButtonIntent: CallbackAction<SelectButtonIntent>(
            onInvoke: (intent) async {
              print("Apply Select Button Working");
              widget.changeLog.forEach((key, value) async {
                if (value == "enabled") {
                  await AndroidAutostart.navigateAutoStartSetting;
                }
                db.set("settings", key, value);
              });
              widget.changeLog.clear();
              print("Apply");
              return null; 
            }
          ),
          UpButtonIntent: CallbackAction<UpButtonIntent>(
            onInvoke: (intent) {
              FocusScope.of(context).requestFocus(widget.focusNode);
              setState(() {});
              return null;
            }
          ),
          LeftButtonIntent: CallbackAction<LeftButtonIntent>(
            onInvoke: (intent) {
              widget.focusStream.sink.add(widget.index);
              return null;
            }
          )
        },
        child: Focus(
          focusNode: widget.focusNode,
          child: Container(
            width: 154,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.focusNode!.hasFocus ? Colors.white : Colors.transparent,
              borderRadius: const BorderRadius.all(Radius.circular(50))
            ),
            child: Container(
            width: 150,
            height: 40,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 54, 244, 152),
              borderRadius: BorderRadius.all(Radius.circular(50))
            ),
            child: const Text("Apply Change",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              ),
            )
                      ),
          ),
        ),
      )
    );
  }
}