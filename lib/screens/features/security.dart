import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../../db/config.dart';
import '../../utils/button/applybtn.dart';
import '../../utils/button/slidder.dart';
import '../../utils/intents.dart';

class Security extends StatefulWidget {
  final StreamController<int> focusStream;
  const Security({super.key, required this.focusStream});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {

  late DataBase db;
  FocusNode? _applyFocusNode;
  FocusNode? _slidderBtnNode;

  Map<String, String> changeLog = {};
  bool isSlidderBtnEnabled = false;

  initializeFocusNodes() {
    _slidderBtnNode = FocusNode();
    _applyFocusNode = FocusNode();
    FocusScope.of(context).requestFocus(_slidderBtnNode);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    db = GetIt.I.get<DataBase>();
  }

  @override
  void dispose() {
    super.dispose();
    _applyFocusNode!.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    if (_applyFocusNode == null) {
      initializeFocusNodes();
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
                  SlidderButton(
                    focusNode: _slidderBtnNode!,
                    focusStream: widget.focusStream,
                    isEnabled: isSlidderBtnEnabled,
                    semanticLabel: "Screen Password",
                    onStateChange: () {},
                    belowFocusNode: _applyFocusNode,
                  ),
                ]
              ),
            ),
            ApplyButton(
              index: 5,
              focusNode: _applyFocusNode!,
              nearestFocusNode: _applyFocusNode!,
              focusStream: widget.focusStream,
              changeLog: changeLog,
            )
          ]
        )
      ),
    );
  }
}