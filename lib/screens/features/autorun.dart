import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../../db/config.dart';
import '../../utils/intents.dart';

class AutoRun extends StatefulWidget {
  const AutoRun({super.key});

  @override
  State<AutoRun> createState() => _AutoRunState();
}

class _AutoRunState extends State<AutoRun> {

  late DataBase db;
  bool isAutoRunEnabled = false;
  String action = "Enable";

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

    if (isAutoRunEnabled) {
      action = "Disable";
    }
  }

  @override
  Widget build(BuildContext context) {
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
                  Row(
                    children: [
                      Text("$action Auto Run",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
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
                                ),
                              )
                            ]
                          )
                        ),
                      )
                    ],
                  )
                ]
              )
            ),
            Positioned(
              bottom: 1,
              right: 1,
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
            )
            )
          ],
        ),
      ),
    );
  }
}