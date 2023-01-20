import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import '../../db/config.dart';
import '../../utils/intents.dart';

class AutoRun extends StatefulWidget {
  final StreamController<int> focusStream;
  const AutoRun({super.key, required this.focusStream});

  @override
  State<AutoRun> createState() => _AutoRunState();
}

class _AutoRunState extends State<AutoRun> {

  bool isAutoRunEnabled = false;

  FocusNode? _autorunFocusNode;
  FocusNode? _applyFocusNode;

  Map<String, String> changeLog = {};

  late DataBase db;

  initializeFousNodes() {
    _autorunFocusNode = FocusNode();
    _applyFocusNode = FocusNode();
    FocusScope.of(context).requestFocus(_autorunFocusNode);
    setState(() {});
  }
  
  @override
  void initState() {
    super.initState();
    db = GetIt.I.get<DataBase>();

    String? autoRun = db.get("settings", "autorun");
    if (autoRun != null) {
      if (autoRun == "enabled") {
        isAutoRunEnabled = true;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _autorunFocusNode!.dispose();
    _applyFocusNode!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_autorunFocusNode == null) {
      initializeFousNodes();
    }

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Shortcuts(
        shortcuts: <LogicalKeySet, Intent>{
          LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftButtonIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowRight): RightButtonIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowUp): UpButtonIntent(),
          LogicalKeySet(LogicalKeyboardKey.arrowDown): DownButtonIntent(),
          LogicalKeySet(LogicalKeyboardKey.select): SelectButtonIntent()
        },
        child: Stack(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Actions(
                    actions: <Type, Action<Intent>>{
                      SelectButtonIntent: CallbackAction<SelectButtonIntent>(
                        onInvoke: (intent) {
                          print("Select Button Working");
                          if (isAutoRunEnabled) {
                            setState(() {
                              isAutoRunEnabled = false;
                              changeLog["autorun"] = "disabled";
                            });
                          } else {
                            setState(() {
                              isAutoRunEnabled = true;
                              changeLog["autorun"] = "enabled";
                            });
                          }
                          return null; 
                        }
                      ),
                      DownButtonIntent: CallbackAction<DownButtonIntent>(
                        onInvoke: (intent) {
                          FocusScope.of(context).requestFocus(_applyFocusNode);
                          setState(() {
                            
                          });
                          return null;
                        }
                      ),
                      LeftButtonIntent: CallbackAction<LeftButtonIntent>(
                        onInvoke: (intent) {
                          print("Move to left window");
                          widget.focusStream.sink.add(4);
                          return null;
                        }
                      )
                    },
                    child: Focus(
                      focusNode: _autorunFocusNode,
                      child: Row(
                        children: [
                          Text("${isAutoRunEnabled ? "Disable" : "Enable"} Auto Run",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Container(
                              width: 64,
                              height: 34,
                              decoration: BoxDecoration(
                                color: _autorunFocusNode!.hasFocus ? Colors.white : Colors.transparent,
                                borderRadius: const BorderRadius.all(Radius.circular(50))
                              ),
                              alignment: Alignment.center,
                              child: Container(
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: const Color.fromARGB(255, 54, 244, 152),
                                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                                  border: Border.all(
                                    color: const Color.fromARGB(255, 54, 244, 152),
                                    width: 2
                                  )
                                ),
                                child: Row(
                                  children: [
                                    Flexible(
                                      flex: 5,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: isAutoRunEnabled ? Colors.transparent : Colors.white,
                                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(isAutoRunEnabled ? "" : "off")
                                      ),
                                    ),
                                    Flexible(
                                      flex: 5,
                                      child: Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: isAutoRunEnabled ? Colors.yellow : Colors.transparent,
                                          borderRadius: const BorderRadius.all(Radius.circular(50)),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(isAutoRunEnabled ? "on" : "")
                                      ),
                                    )
                                  ]
                                )
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ]
              )
            ),
            Positioned(
              bottom: 1,
              right: 1,
              child: Actions(
                actions: <Type, Action<Intent>>{
                  SelectButtonIntent: CallbackAction<SelectButtonIntent>(
                    onInvoke: (intent) async {
                      print("Apply Select Button Working");
                      changeLog.forEach((key, value) async {
                        if (value == "enabled") {
                          // needs to implement Auto Start Feature
                        }
                        db.set("settings", key, value);
                      });
                      changeLog.clear();
                      print("Apply");
                      return null; 
                    }
                  ),
                  UpButtonIntent: CallbackAction<UpButtonIntent>(
                    onInvoke: (intent) {
                      FocusScope.of(context).requestFocus(_autorunFocusNode);
                      setState(() {});
                      return null;
                    }
                  ),
                  LeftButtonIntent: CallbackAction<LeftButtonIntent>(
                    onInvoke: (intent) {
                      widget.focusStream.sink.add(4);
                      return null;
                    }
                  )
                },
                child: Focus(
                  focusNode: _applyFocusNode,
                  child: Container(
                    width: 154,
                    height: 44,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: _applyFocusNode!.hasFocus ? Colors.white : Colors.transparent,
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
            )
          ],
        ),
      ),
    );
  }
}