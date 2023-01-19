import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../db/config.dart';

class Security extends StatefulWidget {
  const Security({super.key});

  @override
  State<Security> createState() => _SecurityState();
}

class _SecurityState extends State<Security> {

  late DataBase db;

  @override
  void initState() {
    super.initState();
    db = GetIt.I.get<DataBase>();
  }
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        alignment: Alignment.topLeft,
        child: const Text("Security Template")
      ),
    );
  }
}