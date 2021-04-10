import 'package:getx_details/models/product.dart';
import 'package:http/http.dart' as http;

class RemoteServices {
  // static var client = http.Client();

  static Future<List<Product>> fetchProducts() async {
    // var response = await client.get()
    var response = await http.get(
        'http://makeup-api.herokuapp.com/api/v1/products.json?brand=maybelline');
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return productFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
