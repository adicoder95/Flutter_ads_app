import 'package:app_tv_ads/screens/templates/3_split_child/70-30_spli_screen.dart';
import 'package:flutter/material.dart';
class ThirtySeventy extends StatefulWidget {
  const ThirtySeventy({Key? key}) : super(key: key);

  @override
  State<ThirtySeventy> createState() => _ThirtySeventyState();
}

class _ThirtySeventyState extends State<ThirtySeventy> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width*0.3,
              child: SeventyThirtySplitChild()),
          Container(
              width: MediaQuery.of(context).size.width*0.7,
              child: SeventyThirtySplitChild()),
        ],
      ),
    );
  }
}
