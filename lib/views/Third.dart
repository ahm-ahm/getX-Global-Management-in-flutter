import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_details/Controller.dart';

class Third extends StatelessWidget {
  final String third;

  const Third({Key key, this.third}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(third),
        centerTitle: true,
      ),
      body: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              Text(third),
              RaisedButton(
                  child: Text('go to second'),
                  onPressed: () {
                    // Get.find<SecondController>();
                    Get.toNamed("/Second", arguments: 'Allah');
                  })
            ],
          )),
    );
  }
}
