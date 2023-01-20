import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:group_radio_button/group_radio_button.dart';

class Template extends StatefulWidget {
  const Template({super.key});

  @override
  State<Template> createState() => _TemplateState();
}
class _TemplateState extends State<Template> {
  bool saveButton= true;
  List values=['50-50','70-30','30-70'];
  String gender="Full-Screen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
    padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text("Select Template Ratio",style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.bold,fontSize: 25),),
            RadioButton(
              description: "Full Screen",
              value: "Full-Screen",
              groupValue: gender,
              onChanged: (value) => setState(
                    () => gender = value!,
              ),
              activeColor: Colors.green,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            RadioButton(
              description: "70-30 Split",
              value: "70-30",
              groupValue: gender,
              onChanged: (value) => setState(
                    () => gender = value!,
              ),
              activeColor: Colors.green,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            RadioButton(
              description: "50-50 Split",
              value: "50-50",
              groupValue: gender,
              onChanged: (value) => setState(
                    () => gender = value!,
              ),
              activeColor: Colors.green,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            RadioButton(
              description: "Three Split",
              value: "Three Split",
              groupValue: gender,
              onChanged: (value) => setState(
                    () => gender = value!,
              ),
              activeColor: Colors.green,
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: (){

                },
                onFocusChange: (d){
                  setState(() {
                    saveButton=!saveButton;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(color: saveButton?Colors.blue:Colors.green,borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(saveButton?'save':'saved',style: TextStyle(fontSize: 20,color: Colors.white),),
                  ),
                ),
              ),
            )
          ],
        )
      ),
    );
  }
}