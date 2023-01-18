import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {

  int sectionSelectedIndex = 0;
  
  FocusNode? _templateFocusNode;
  FocusNode? _tickerFocusNode;
  FocusNode? _audioFocusNode; 
  FocusNode? _scrollFocusNode;
  FocusNode? _autorunFocusNode;
  FocusNode? _securityFocusNode;
  FocusNode? _cloudFocusNode;
  FocusNode? _subscriptionFocusNode;

  void initializedFocusNodes(BuildContext context) {
    _templateFocusNode = FocusNode();
    _tickerFocusNode = FocusNode();
    _audioFocusNode = FocusNode();
    _scrollFocusNode = FocusNode();
    _autorunFocusNode = FocusNode();
    _securityFocusNode = FocusNode();
    _cloudFocusNode = FocusNode();
    _subscriptionFocusNode = FocusNode();

    FocusScope.of(context).requestFocus(_templateFocusNode);
  }

  @override
  void dispose() {
    super.dispose();
    _templateFocusNode!.dispose();
    _tickerFocusNode!.dispose();
    _audioFocusNode!.dispose();
    _scrollFocusNode!.dispose();
    _autorunFocusNode!.dispose();
    _securityFocusNode!.dispose();
    _cloudFocusNode!.dispose();
    _subscriptionFocusNode!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_templateFocusNode == null) {
      initializedFocusNodes(context);
    }
    return Material(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            splashRadius: 25,
            icon: const Icon(Icons.arrow_circle_left_outlined),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.grey,
          title: const Text("Settings"),
        ),
        body: Container(
          color: const Color.fromARGB(255, 189, 189, 189),
          child: Row(
            children: [
              Shortcuts(
                shortcuts: <LogicalKeySet, Intent>{
                  LogicalKeySet(LogicalKeyboardKey.arrowLeft): LeftButtonIntent(),
                  LogicalKeySet(LogicalKeyboardKey.arrowRight): RightButtonIntent(),
                  LogicalKeySet(LogicalKeyboardKey.arrowUp): UpButtonIntent(),
                  LogicalKeySet(LogicalKeyboardKey.arrowDown): DownButtonIntent(),
                  LogicalKeySet(LogicalKeyboardKey.select): SelectButtonIntent()
                },
                child: Container(
                  width: MediaQuery.of(context).size.width/4,
                  height: MediaQuery.of(context).size.height,
                  color: const Color.fromARGB(255, 54, 244, 152),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                    child: ListView(
                      children: [
                        tile(0, "Screen Template", Icons.screenshot_monitor_outlined, _templateFocusNode!, nextFocusNode: _tickerFocusNode!),
                        tile(1, "Ticker", Icons.splitscreen, _tickerFocusNode!, nextFocusNode: _audioFocusNode!, previousFocusNode: _templateFocusNode!),
                        tile(2, "Audio", Icons.audiotrack, _audioFocusNode!, nextFocusNode: _scrollFocusNode, previousFocusNode: _tickerFocusNode),
                        tile(3, "Scroll Behaviour", Icons.air_outlined, _scrollFocusNode!, nextFocusNode: _autorunFocusNode, previousFocusNode: _audioFocusNode),
                        tile(4, "Auto Run", Icons.start_rounded, _autorunFocusNode!, nextFocusNode: _securityFocusNode, previousFocusNode: _scrollFocusNode),
                        tile(5, "Security", Icons.security_rounded, _securityFocusNode!, nextFocusNode: _cloudFocusNode, previousFocusNode: _autorunFocusNode),
                        tile(6, "Cloud", Icons.cloud, _cloudFocusNode!, nextFocusNode: _subscriptionFocusNode, previousFocusNode: _securityFocusNode),
                        tile(7, "Subscription", Icons.subscriptions_rounded, _subscriptionFocusNode!, previousFocusNode: _cloudFocusNode),
                      ]
                    ),
                  )
                ),
              ),
              
              Flexible(
                flex: 6,
                child: Container(
                  color: const Color.fromARGB(255, 153, 244, 196),
                  child: [
                    templateSection(),
                    tickerSection(),
                    audioSection(),
                    scrollSection(),
                    autorunSection(),
                    securitySection(),
                    cloudSection(),
                    subscriptionSection()
                  ][sectionSelectedIndex]
                )
              ),
            ]
          )
        ),
        floatingActionButton: Container(
          width: 200,
          height: 50,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 54, 244, 152),
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          child: const Text("Apply Change",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold
            ),
          )
        ),
      )
    );
  }

  _changeFocus(BuildContext context, FocusNode focus) {
    FocusScope.of(context).requestFocus(focus);
    setState(() {});
  }

  Widget tile(int index, String title, IconData iconData, FocusNode focusNode, {FocusNode? nextFocusNode, FocusNode? previousFocusNode}) {
    Map<Type, Action<Intent>> actions = {
      SelectButtonIntent: CallbackAction<SelectButtonIntent>(
        onInvoke: (intent) {
          setState(() {
            sectionSelectedIndex = index;
          });
          return null; 
        }
      )
    };
    if (nextFocusNode != null) {
      actions.addAll({
        DownButtonIntent: CallbackAction<DownButtonIntent>(
          onInvoke: (intent) => _changeFocus(context, nextFocusNode)
        ),
      });
    }
    if (previousFocusNode != null) {
      actions.addAll({
        UpButtonIntent: CallbackAction<UpButtonIntent>(
          onInvoke: (intent) => _changeFocus(context, previousFocusNode)
        )
      });
    }
    return Actions(
      actions: actions,
      child: Focus(
        focusNode: focusNode,
        child: Container(
          decoration: BoxDecoration(
            color: focusNode.hasFocus ? Colors.yellow : Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(50))
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 50,
                  child: Center(child: Icon(iconData))
                ),
                Flexible(
                  flex: 7,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(title,
                        style: const TextStyle(
                          fontSize: 18
                        ),
                      ),
                    )
                  )
                )
              ]
            ),
          )
        ),
      ),
    );
  }

  Widget templateSection() {
    return Container(
      alignment: Alignment.center,
      child: const Text("Screen Template")
    );
  }

  Widget tickerSection() {
    return Container(
      alignment: Alignment.center,
      child: const  Text("Ticker Template")
    );
  }

  Widget audioSection() {
    return Container(
      alignment: Alignment.center,
      child: const Text("Audio Template")
    );
  }

  Widget scrollSection() {
    return Container(
      alignment: Alignment.center,
      child: const Text("Scroll Template")
    );
  }

  Widget autorunSection() {
    return Container(
      alignment: Alignment.center,
      child: const Text("Auto Run Template")
    );
  }

  Widget securitySection() {
    return Container(
      alignment: Alignment.center,
      child: const Text("Security Template")
    );
  }

  Widget cloudSection() {
    return Container(
      alignment: Alignment.center,
      child: const Text("Cloud Template")
    );
  }

  Widget subscriptionSection() {
    return Container(
      alignment: Alignment.center,
      child: const Text("Subscription Template")
    );
  }
}

class LeftButtonIntent extends Intent {}
class RightButtonIntent extends Intent {}
class UpButtonIntent extends Intent {}
class DownButtonIntent extends Intent {}
class SelectButtonIntent extends Intent {}

//this is testing purpose
// updated by shikhar...