import 'package:app_tv_ads/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'slideshow.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final FocusNode _focusNode = FocusNode();
  bool isScreenController = true;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Focus(
        autofocus: true,
        focusNode: _focusNode,
        child: Visibility(
          replacement: const SettingScreen(),
          visible: isScreenController,
          child: const ScreenController(),
        ),
        onKey: (node, event) {
          if (event.isKeyPressed(LogicalKeyboardKey.goBack)) {
            // print("Go Back");
            setState(() {
              isScreenController = false;
            });
          }
          return KeyEventResult.handled;
        },
      ),
    );
  }
}
