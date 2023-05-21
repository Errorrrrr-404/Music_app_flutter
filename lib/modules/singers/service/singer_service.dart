import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../shared/services/api_client.dart';
import '../models/Singer.dart';

class SingerService {
  ApiClient _apiClient = ApiClient();
  Future<List<Singer>> getSingers() async {
    String url = dotenv.env['Singers_url']!;
    Response response = await _apiClient.get(url);
    print(response.data);
    // Convert String (JSON) to Object
   // dynamic object = jsonDecode(response.data);
    //print(object);
    //print(object.runtimeType);
    print("****************");
    print(response.data.runtimeType);
    List<dynamic> list = response.data["singers"]!;
    List<Singer> singer = list.map((m) => Singer.fromJSON(m)).toList();
    print("Singers $singer");
    return singer;
  }
}
