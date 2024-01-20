import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../home_screen/model/api_model.dart';

class ecom_helper {
  ecom_helper._();

  static ecom_helper api = ecom_helper._();

  Future<List<Ecommodel>?> getdata() async {
    String api = "https://fakestoreapi.com/products";

    http.Response responce = await http.get(
      Uri.parse(api),
    );
    log("${responce.statusCode}");
    if (responce.statusCode == 200) {
      List DecodedData = jsonDecode(responce.body);

      List<Ecommodel> data =
          DecodedData.map((e) => Ecommodel.fromAPI(data: e)).toList();

      return data;
    } else {
      return null;
    }
  }
}
