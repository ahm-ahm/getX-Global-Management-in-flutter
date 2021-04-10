import 'package:flutter/material.dart';
import 'package:get/get.dart';
//GetxController which extends DisposableInterface.
// This means that our controller will get deleted from memory as soon as they anr not used

//class GetxController extends DisposableInterface with ListNotifier
//We don’t have to manually dispose anything and the memory consumption is reduced,
// resulting in high performance.

//GetxController comes with onInit() and onClose()  and onReady() methods like init and dispose of stateful widget

/*
onInt()=memory allocation
onReady()=when screen is rendered 
onClose()=when getx controller is deleted from memory
 */

class Controller extends GetxController {
  //------------via update----via classical approach--------------------
  int count = 0;
  void increment() {
    count++;
    print(count);
    update(); //like setstate
  }

  //------------via reactive approach   ie; stream based ------------------------

  //make it observable ie; stream of type int...This means that we can listen
  //to the changes made to counter from our view using GetX.
  RxInt countRx = 0.obs;
  void incrementRx() {
    countRx++;
    print(countRx);
  }
}

//------------------------------------class observable example-----------
class User {
  String name;
  User({this.name});
}

class UserController extends GetxController {
  var user = User(name: "Aachman").obs; // declare just like any other variable

  void changeName() => user.value.name =
      "Garg"; // use .value and access any variables of the class

}

/*




Which one to choose?????????

GetBuilder:

When maintaining ephemeral state. 
Which basically means use it wherever you would use setState.
If performance is the top most priority. 
State is shared among builders and much RAM is not consumed.
If you don’t want to work with streams.


GetX::

When you want the power of reactive programming.
It redraws the widget only when the value of variable is actually changed.
 Say value of variable is changed from "Garg" to "Garg", then widgets will not be redrawn.
If you don’t want to instantiate controllers.



Obx::

If you prefer a simple syntax.
If you’ll be using with multiple controllers in the same widget.
 Obx doesn't need a type, so it can be used with any number of controllers. Something like this:

eg:
Obx(() => Text(
  '${firstController.counter.value + thirtySeventhController.counter.value}'
  ),
),
 */

/*




MIXIMBUILDER::::: A HYBRIB APPROACH.



class Controller extends GetxController {
	
  int one = 1; // simple variable

  void incrementOne() {
    one++;
    update();
  }

  var two = 2.obs; // reactive stream

  void incrementTwo() => two.value++;

}

  MixinBuilder(
    builder: (controller) => Text(
      '${controller.one + controller.two.value}' // this should work!
    ),
  ),

 */

//----------------------------------------GETX AS DEPENDENCY--------------------------
/*


class HomePage extends StatelessWidget {
	
  Controller controller; // create a variable of Controller type
	
  HomePage({this.controller}); // inject Controller dependency through contructor

}

class OtherPage extends StatelessWidget {

  Controller someController = Controller(); // Controller instantiated

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HomePage(controller: someController), // instance of Controller passed to HomePage
    );
  }
}


///////////////////////////SO THIS DEPENDENCY IS ACHIEVED AS SIMPLE AND SHORT///////////////
class HomePage extends StatelessWidget {
	
  Controller controller = Get.put(Controller());

}

class SecondPage extends StatelessWidget {

  Controller controller = Get.find(); // like this!

}
*/

//-----------------------CONSTRUCTOR DEPENDENCY---------------------------
class HomePageOne extends StatelessWidget {
  final Controller controller; // create a variable of Controller type

  HomePageOne({this.controller});

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  } // inject Controller dependency through contructor

}

class OtherPage extends StatelessWidget {
  final Controller someController = Controller(); // Controller instantiated

  @override
  Widget build(BuildContext context) {
    return Container(
      child: HomePageOne(
          controller:
              someController), // instance of Controller passed to HomePage
    );
  }
}

//NOW USE GETX FOR THIS  DEPENDENCY
class HomePageGetX extends StatelessWidget {
  final Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}

class SecondPageGetX extends StatelessWidget {
  final Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  } // like this!

}

//----------------------------------------------Bindings class-----------------------------
/*
 we are still declaring our dependencies in the view class.
 To make it clear or decoupling of code use Bindings class
 
class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<Controller1>(Controller1());
    Get.put<Controller2>(Controller2());
  }
}

*/

//---Now bind them
//so GetPage, Get.to and Get.toNamed are parts of route management,
/*

GetMaterialApp( 
  initialRoute: "/",
  getPages: [
    GetPage(name: "/", page: () => HomePage(), binding: HomeBinding()), // here!
  ],
);
-------------------------or
Get.to(HomePage(), binding: HomeBinding()); // or like this!
Get.toNamed("/", binding: HomeBinding()); // and this!




----------------------------------or
GetMaterialApp(
  initialRoute: "/",
  initialBinding: BindingsBuilder(() => {Get.put(Controller())}), // like this!
);



-------------------MOST OF CASES
WE PUT OR INJECT DEPENDENCY VIA put() 
AND FIND  VIA find().

----------AS BELOW
class HomePage extends StatelessWidget {
	
  Controller controller = Get.put(Controller()); // Controller dependency injected
	
  @override
  Widget build(BuildContext context) {
    return Text(controller.name); // can be used directly
  }
}

---------IF THERE ARE MULTIPLE DEPENDENCIES OF SAME CONTROLLER ...SO USE tag


class HomePage extends StatelessWidget {
	
  Controller controller1 = Get.put(Controller(), tag: 'aUniqueTag');
  Controller controller2 = Get.put(Controller(), tag: 'anotherUniqueTag');

}

class SecondPage extends StatelessWidget {

  Controller controller1 = Get.find(tag: 'aUniqueTag');
  Controller controller2 = Get.find(tag: 'anotherUniqueTag');

}

--------DEPENDENCIES ARE DELETED BY DEFAULT AS STACK NAVIGATION TO AVOID THIS USE permanent=true



//-----------------------------------Get.lazyPut--------------------------------
---Normally, Get.lazyPut loads dependencies only one time, which means that if the route gets removed, and created again,
 Get.lazyPut will not load them again. so to reinitialize them when route is back.so use fenix=true

 Get.lazyPut(() => Controller(), fenix: true);


//-----------------------------------Get.putAsync--------------------------------
When using SharedPreferences or databases, we need to work with dependencies asynchronously


Get.putAsync<SharedPreferences>(() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('name', 'Batman');
  return prefs;
}, tag: 'tagsAreEverywhere', permanent: true); // Yes, we do get tag and permanent properties with this as well

Get.find<SharedPreferences>().getString('name'); // Get.find works as you'd expect
*/

//----------------------------------------------controllers----------------------------------------------------
class FirstController extends GetxController {
  var name = 'first';
}

class SecondController extends GetxController {
  var name = 'second';
}
