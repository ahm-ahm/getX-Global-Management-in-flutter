import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_details/views/First.dart';
import 'package:getx_details/views/MyBindings.dart';
import 'package:getx_details/views/Second.dart';

import 'Controller.dart';
import 'LocalizationServices.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    dynamic data = Get.arguments;
    print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ $data');
    return GetMaterialApp(
      title: 'Flutter Demo In Getx',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          // page: () => First(first: 'first'),
          page: () => LanguagesHome(),

          binding: MyBindings(),
        ),
        GetPage(
          name: '/Second',
          // page: () => Second(second: data),
          page: () {
            print('***************************$data and ${Get.arguments}');
            return Second(second: Get.arguments);
          },
          binding: MyBindings(),
        ),
        GetPage(
          name: '/Third',
          page: () => Second(),
          binding: MyBindings(),
        )
      ],
      // home: First(first: 'First'),

      //----------------localization
      locale: LocalizationService.locale,
      fallbackLocale: LocalizationService.fallbackLocale,
      translations: LocalizationService(),
    );
  }
}

//-----------------GetBuilder-----------------------------
class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  //for whole app dependency available
  //tag for multiple dependency distinction
  final Controller c = Get.put(Controller(), tag: 'uniqueTag', permanent: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GetBuilder<Controller>(
        init: Controller(),
        builder: (controller) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '${controller.count}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: c.increment,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

//-----------------getX-----------------------------
class MyHomeGetX extends StatelessWidget {
  MyHomeGetX({Key key, this.title}) : super(key: key);

  final String title;
  final Controller c = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body:
          // init: Controller(),
          Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            GetX<Controller>(
              // init: Controller(),
              builder: (controller) => Text(
                '${controller.countRx}',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: c.incrementRx,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

//-----------------Obx-----------------------------
class Home extends StatelessWidget {
  @override
  Widget build(context) {
    // Instantiate your class using Get.put() to make it available for all "child" routes there.
    //this is dependency
    final Controller c = Get.put(Controller());

    return Scaffold(
        // Use Obx(()=> to update Text() whenever count is changed.
        appBar: AppBar(title: Obx(() => Text("Clicks: ${c.countRx}"))),

        // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
        body: Center(
            child: RaisedButton(
                child: Text("Go to Other"), onPressed: () => Get.to(Other()))),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: c.incrementRx));
  }
}

class Other extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final Controller c = Get.find();

  @override
  Widget build(context) {
    // Access the updated count variable
    return Scaffold(
        body: Center(
          child: Text("${c.count}"),
        ),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.arrow_back), onPressed: Get.back));
  }
}

/*

MediaQuery.of(context).width=	Get.width
Navigator.push(context,NextScreen())=	Get.to(NextScreen())
Flutter Dialog=	Get.dialog()
Sharing data between screen	=Get.find(ControllerName())
 */

//=============================== dialog
/**
 
Get.dialog(DialogWidget());
 */
