import 'package:flutter_http_demo2/test/model/my_model.dart';

import 'api_response.dart';

class Test {
  test() {
    ApiResponse apiResponse = ApiResponse<MyModel>();
    var json = apiResponse.toJson();
    var response = ApiResponse<MyModel>.fromJson(json, (data) => MyModel.fromJson(data));
  }
}