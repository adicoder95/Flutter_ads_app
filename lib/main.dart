// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet,Intent>{
        LogicalKeySet(LogicalKeyboardKey.select) : const ActivateIntent()
      },
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

void show() {
  print("Working");
}

class _MyHomePageState extends State<MyHomePage> {
  final FocusNode _focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onSecondaryLongPressUp: show,
        onSecondaryLongPressDown: (d) {print(d.localPosition);},
        onSecondaryLongPressEnd: (d) {print(d.localPosition);},
        onSecondaryTap: show,
        onSecondaryTapUp: (d) {print(d.kind);},
        onSecondaryTapDown: (d) {print(d.kind);},
        onTertiaryTapUp: (d) {print(d.kind);},
      child: RawKeyboardListener(
        focusNode: _focusNode,
        child: Container(
          child: Row(
            children: [
              Flexible(
                flex: 3,
                child: Container(
                  color: Colors.red,
                )
              ),
              Flexible(
                flex: 4,
                child: Container(
                  color: Colors.yellow,
                )
              ),
              Flexible(
                flex: 3,
                child: Container(
                  color: Colors.blue
                )
              ),
            ]
          ),
        ),
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.goBack)) {
            print("Back");
          }
        },
      ),
    );
  }
}
