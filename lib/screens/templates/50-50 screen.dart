import 'package:app_tv_ads/screens/templates/3_split_child/50-50_split_child.dart';
import 'package:flutter/material.dart';
class FiftyScreen extends StatefulWidget {
  const FiftyScreen({Key? key}) : super(key: key);

  @override
  State<FiftyScreen> createState() => _FiftyScreenState();
}

class _FiftyScreenState extends State<FiftyScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FiftySplitChild(),
          FiftySplitChild()
        ],
      ),
    );
  }
}
