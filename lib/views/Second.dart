import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Second extends StatelessWidget {
  final String second;

  const Second({Key key, this.second}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(second),
        centerTitle: true,
      ),
      body: Container(
          alignment: Alignment.center,
          child: Text(second + ' page with data= $data ')),
    );
  }
}
