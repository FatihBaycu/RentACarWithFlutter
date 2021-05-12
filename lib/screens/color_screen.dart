import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/services/color_service.dart';
import 'package:flutter_http_demo2/models/color.dart';

class ColorScreen extends StatefulWidget {
  @override
  _ColorScreenState createState() => _ColorScreenState();
}

class _ColorScreenState extends State<ColorScreen> {

  var colors = <Color>[];

  @override
  void initState() {
    getColorsFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title:Text("Colors")),
        body: buildBody(),
      ),
    );
  }

  buildBody() {
    return Column(
      children:<Widget> [
       buildColorList(),
      ],
    );
  }
  buildColorAdd(){

  }
  buildColorList(){
    return  Container(
      child: ListView.builder(
        scrollDirection:Axis.vertical,
          itemCount: this.colors.length,
          itemBuilder: (BuildContext context,index){
            ListTile(
              title: Text(this.colors[index].colorName),
              trailing: Icon(Icons.color_lens_outlined),
              leading: IconButton(icon: Icon(Icons.update),onPressed: (){print("eklenecek.");},),
            );
          },
        ),
    );

  }

  void getColorsFromApi() {
    ColorService.getAll().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.colors = list.map((color) => Color.fromJson(color)).toList();
      });
    });
  }

}
