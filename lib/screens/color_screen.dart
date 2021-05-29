import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/color.dart';
import 'package:flutter_http_demo2/screens/color_update_screen.dart';
import 'package:flutter_http_demo2/services/color_service.dart';

class ColorScreen extends StatefulWidget {
  @override
  _ColorScreenState createState() => _ColorScreenState();
}
enum Options { update, delete }

class _ColorScreenState extends State<ColorScreen> {

  var colors=<Color>[];
  var formKey = GlobalKey<FormState>();
  Color color=Color.required(
    colorName:"default",
    colorCode:"default"
  );
  @override
  void initState() {
    getColorsFromApi();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Colors")),
      body: Column(
        children: [
          Expanded(flex:2,child: buildFormField()),
          Expanded(flex:3,child: buildColorList()),
        ],
      ),
    );
  }

  buildColorList() {
    return ListView.builder(
      padding: EdgeInsets.only(left:20,right: 20),
        itemCount:colors.length,
        itemBuilder: (context,index){
          return ListTile(
            title: Text(colors[index].colorName.toString()),
            trailing: buildPopupMenu(colors[index]),
          );
        });
  }

  getColorsFromApi(){
    ColorService.getAll().then((response){
      setState(() {
        Iterable list=jsonDecode(response.body)["data"];
        this.colors=list.map((c) => Color.fromJson(c)).toList();
      });
    });
  }


  buildFormField(){
  return ListView(
    padding: EdgeInsets.all(20),
    shrinkWrap: true,
    children: [
      Form(
          key: formKey,
          child: Column(
            children: [
              buildColorNameField(),
              buildColorCodeField(),
              buildColorSubmitField(),
            ],
          ),
      ),
    ],
  );

  }

  buildColorNameField() {
    return TextFormField(
      decoration: const InputDecoration(

        hintText: "Enter color name"
      ),
      onSaved:(String? value){color.colorName=value!;},
    );
  }

  buildColorCodeField() {
    return TextFormField(
      decoration: const InputDecoration(
          hintText: "Enter color code"
      ),
      onSaved:(String? value){color.colorCode=value!;},
    );
  }

  buildColorSubmitField() {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
             child:Text("Ekle"),
            onPressed: (){
              if(formKey.currentState!.validate()){
                formKey.currentState!.save();
                ColorService.colorAdd(this.color);
              }
            },
          ),
        );
      }

  buildPopupMenu(Color color) {
    return PopupMenuButton<Options>(
        onSelected: (value) => selectProcess(value, color),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
          PopupMenuItem<Options>(
            child: Text("Update"),
            value: Options.update,
          ),
          PopupMenuItem<Options>(
            child: Text("Delete"),
            value: Options.delete,
          ),
        ]);
  }

  selectProcess(Options options, Color color) async {
    switch (options) {
      case Options.update:
        print("Seçili renk için, Silme işlemleri buraya yazılacak");
        break;
      case Options.delete:
        print("Seçili renk için, Silme işlemleri buraya yazılacak");
        break;
      default:
    }
  }

}
