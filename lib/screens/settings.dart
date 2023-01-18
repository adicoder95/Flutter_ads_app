// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  bool isCursorOnAudio = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_circle_left_outlined),
            onPressed: () {
              
            },
          ),
          backgroundColor: Colors.grey,
          title: Text("Settings"),
        ),
        body: Container(
          color: Color.fromARGB(255, 189, 189, 189),
          child: Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width/5,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  color: Color.fromARGB(255, 54, 244, 152),
                  child: ListView(
                    children: [
                      ListTile(
                        autofocus: true,
                        enabled: true,
                        enableFeedback: true,
                        focusColor: Colors.redAccent,
                        // selected: true,
                        leading: Icon(Icons.screenshot_monitor_outlined),
                        title: Text("Screen Template")
                      ),
                      ListTile(
                        leading: RotatedBox(
                          quarterTurns: 1,
                          child: Icon(Icons.splitscreen)
                        ),
                        title: Text("Ticker"),
                      ),
                      MouseRegion(
                        onHover: (d) {
                          print("working: ${d.position.dx}");
                          setState(() {
                            isCursorOnAudio = true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isCursorOnAudio ? Colors.yellow : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(50))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 50,
                                  child: Center(child: Icon(Icons.audiotrack))
                                ),
                                Flexible(
                                  flex: 7,
                                  child: Container(
                                    alignment: Alignment.centerLeft,
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10.0),
                                      child: Text("Audio",
                                        style: TextStyle(
                                          fontSize: 18
                                        ),
                                      ),
                                    )
                                  )
                                )
                              ]
                            ),
                          )
                        )
                      ),
                      ListTile(
                        leading: Icon(Icons.air_outlined),
                        title: Text("Scroll Behaviour"),
                      ),
                      
                      ListTile(
                        leading: Icon(Icons.start_rounded),
                        title: Text("Auto Run"),
                      ),
                      
                      ListTile(
                        leading: Icon(Icons.security_rounded),
                        title: Text("Security"),
                      ),
                      
                      ListTile(
                        leading: Icon(Icons.cloud),
                        title: Text("Cloud"),
                      ),
                      
                      ListTile(
                        leading: Icon(Icons.subscriptions_rounded),
                        title: Text("Subscription"),
                      ),
                    ]
                  )
                )
              ),
              Flexible(
                flex: 6,
                child: Container(
                  color: Color.fromARGB(255, 153, 244, 196),
                  // child: NavigationBar(
                  //   selectedIndex: 0,
                  //   onDestinationSelected: (index) {

                  //   },

                  // )
                )
              ),
            ]
          )
        ),
      )
    );
  }
}