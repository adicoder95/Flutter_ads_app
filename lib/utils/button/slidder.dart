import 'dart:async';

import 'package:flutter/material.dart';

import '../intents.dart';

class SlidderButton extends StatefulWidget {
  final FocusNode focusNode;
  final StreamController focusStream;
  final bool isEnabled;
  final String semanticLabel;
  final VoidCallback? onStateChange;
  final FocusNode? belowFocusNode;
  const SlidderButton({
    super.key, 
    required this.focusNode, 
    required this.focusStream, 
    required this.isEnabled, 
    required this.semanticLabel,
    required this.onStateChange, 
    this.belowFocusNode
  });

  @override
  State<SlidderButton> createState() => _SlidderButtonState();
}

class _SlidderButtonState extends State<SlidderButton> {
  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: <Type, Action<Intent>>{
        SelectButtonIntent: CallbackAction<SelectButtonIntent>(
          onInvoke: (intent) {
            if (widget.onStateChange != null) {
              widget.onStateChange!();
            }
            return null; 
          }
        ),
        DownButtonIntent: CallbackAction<DownButtonIntent>(
          onInvoke: (intent) {
            if (widget.belowFocusNode != null) {
              setState(() {
                FocusScope.of(context).requestFocus(widget.belowFocusNode);
              });
            }
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
        focusNode: widget.focusNode,
        child: Row(
          children: [            
            Text(widget.semanticLabel,
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
                  color: widget.focusNode.hasFocus ? Colors.white : Colors.transparent,
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
                            color: widget.isEnabled ? Colors.transparent : Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                          ),
                          alignment: Alignment.center,
                          child: Text(widget.isEnabled ? "" : "off")
                        ),
                      ),
                      Flexible(
                        flex: 5,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                            color: widget.isEnabled ? Colors.yellow : Colors.transparent,
                            borderRadius: const BorderRadius.all(Radius.circular(50)),
                          ),
                          alignment: Alignment.center,
                          child: Text(widget.isEnabled ? "on" : "")
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
    );
  }
}