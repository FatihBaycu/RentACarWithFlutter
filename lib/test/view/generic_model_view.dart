import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/test/model/api_response.dart';
import 'package:flutter_http_demo2/test/model/my_model.dart';
import 'package:http/http.dart' as http;

class GenericModelView extends StatefulWidget {
  const GenericModelView({Key? key}) : super(key: key);

  @override
  _GenericModelViewState createState() => _GenericModelViewState();
}

class _GenericModelViewState extends State<GenericModelView> {
/*
* I/chatty  ( 6811): uid=10171(com.example.flutter_http_demo2) 1.ui identical 1 line
E/flutter ( 6811): [ERROR:flutter/lib/ui/ui_dart_state.cc(199)] Unhandled Exception: type '_InternalLinkedHashMap<String, dynamic>' is not a subtype of type 'List<dynamic>' in type cast
E/flutter ( 6811): #0      _GenericModelViewState.getAll (package:flutter_http_demo2/test/view/generic_model_view.dart:26:46)
E/flutter ( 6811): <asynchronous suspension>
E/flutter ( 6811):
* */

  Future<List<ApiResponse<MyModel>>> getAll() async {
    ApiResponse apiResponse = ApiResponse<MyModel>();
    var json = apiResponse.toJson();
    var response = await http.get(Uri.parse('https://run.mocky.io/v3/41fc758a-08a3-4044-8fd8-eab414a651b5'));
    if (response.statusCode == 200) {
      var result= (jsonDecode(response.body) as List).map((e) => ApiResponse<MyModel>.fromJson(json, (data) => MyModel.fromJson(data))).toList();
            print(result.first.message);
        return result;
    } else {
      throw "ERRORR";
    }
  }

  @override
  void initState() {
    getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Generic Response Model"),
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Center(child: Text("Hello"));
  }

  // buildBody() {
  //   return FutureBuilder<List<ApiResponse<MyModel>>>(
  //       future: getAll(),
  //       builder: (BuildContext context,AsyncSnapshot snapshot){
  //         if(snapshot.hasData){
  //         List<ApiResponse<MyModel>> response=snapshot.data!;
  //               MyModel? cars=response.first.data;
  //
  //           return ListView.builder(
  //               itemCount: cars.length,
  //               itemBuilder: (context,index){
  //                 var car=cars[index];
  //                 return ListTile(
  //                   title: Text(cars[index].),
  //                 );
  //               });
  //         }
  //         else
  //           return Center(child: CircularProgressIndicator(),);
  //       }
  //   );
  // }
}
