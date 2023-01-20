import 'package:app_tv_ads/screens/home.dart';
import 'package:flutter/material.dart';
class DataTransfer extends StatefulWidget {
  const DataTransfer({Key? key}) : super(key: key);

  @override
  State<DataTransfer> createState() => _DataTransferState();
}

class _DataTransferState extends State<DataTransfer> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Container(
          height: MediaQuery.of(context).size.height/4,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.orange,
            borderRadius: BorderRadius.circular(100),
            border: Border.all(color: Colors.white,width: 3)
          ),
        ),
      ),
    );
  }
}
