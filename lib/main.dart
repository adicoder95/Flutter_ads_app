// ignore_for_file: sort_child_properties_last
import 'package:get_it/get_it.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'db/config.dart';
import 'screens/home.dart';

bool isHome = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory document = await getApplicationDocumentsDirectory();

  // initializing db object
  DataBase db = DataBase();
  // initialiazing hive databse
  isHome = await db.intializeHiveDB(document.path);
  // registering db object for accessing it from anywhere inside the project
  GetIt.I.registerSingleton<DataBase>(db);
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Ad App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
