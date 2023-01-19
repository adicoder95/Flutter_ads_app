import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class Ticker extends StatefulWidget {
  const Ticker({super.key});

  @override
  State<Ticker> createState() => _TickerState();
}

class _TickerState extends State<Ticker> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.topLeft,
        child: const Text("Ticker Section")
      ),
    );
  }
}