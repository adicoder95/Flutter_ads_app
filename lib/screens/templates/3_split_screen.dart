import 'package:flutter/material.dart';

import '3_split_child/three_split_child.dart';
class ThreeSplit extends StatefulWidget {
  const ThreeSplit({Key? key}) : super(key: key);

  @override
  State<ThreeSplit> createState() => _ThreeSplitState();
}

class _ThreeSplitState extends State<ThreeSplit> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ThreeSplitChild(),
          ThreeSplitChild(),
          ThreeSplitChild(),
        ],
      ),
    );
  }
}
