import 'package:flutter/material.dart';
import 'package:get/get.dart';

class First extends StatelessWidget {
  final String first;

  const First({Key key, this.first}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&   $first');

    return Scaffold(
      appBar: AppBar(
        title: Text(first),
        centerTitle: true,
      ),
      body: Container(
          alignment: Alignment.center,
          child: Center(
            child: Column(
              children: [
                Text(first),
                RaisedButton(
                    child: Text('go to second'),
                    onPressed: () {
                      // Get.find<SecondController>();
                      Get.toNamed("/Second", arguments: 'Allah');
                    })
              ],
            ),
          )),
    );
  }
}
