import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/color_controller.dart';
import 'package:flutter_http_demo2/core/ResponseService.dart';
import 'package:flutter_http_demo2/models/color.dart';
import 'package:flutter_http_demo2/screens/car/car_list_screen.dart';
import 'package:flutter_http_demo2/screens/color/color_update_screen.dart';
import 'package:flutter_http_demo2/services/color_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

class ColorScreen extends StatefulWidget {
  @override
  _ColorScreenState createState() => _ColorScreenState();
}
enum Options {update}

class _ColorScreenState extends State<ColorScreen> {


  var colorName=TextEditingController();
  var colorCode=TextEditingController();

  ColorController colorController=Get.put(ColorController());

  var formKey = GlobalKey<FormState>();
  Color color=Color.required(
    colorName:"default",
    colorCode:"default"
  );



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Colors")),
      body: Column(
        children: [
          Expanded(flex:1,child: buildFormField()),
          Expanded(flex:2,child: buildColorList()),
        ],
      ),
    );
  }

  buildColorList() {
    return Obx((){
      if(colorController.isLoading.value)
          return Center(child: CircularProgressIndicator());
      else
          return ListView.builder(
        padding: EdgeInsets.only(left:20,right: 20),
          itemCount:colorController.colorList.length,
          itemBuilder: (context,index){
          var colors=colorController.colorList;
            return ListTile(
              title: Text(colors[index].colorName!),
              trailing: buildPopupMenu(colors[index]),
            );
          }
    );
    }
  );
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

      autovalidateMode: AutovalidateMode.always,
      controller: colorName,
      validator: (String? value){
        if(value!=null){
          if(value.length<2){return
          "The color name length must be higher than 2.";}
        }
      },
      decoration:  InputDecoration(labelText: "Enter color name", border: OutlineInputBorder(),),
      onSaved:(String? value){color.colorName=value!;},
    );
  }

  buildColorCodeField() {
    return TextFormField(
      decoration:  InputDecoration(labelText: "Enter color code", border: OutlineInputBorder(),),
      controller: colorCode,
      autovalidateMode: AutovalidateMode.always,
      validator: (String? value){
        if(value!=null){
          if(value.length<2){return "The color code length must be higher than 2.";}
        }
      },
      onSaved:(String? value){color.colorCode=value!;},
    );
  }

  generateResponse(dynamic param){ return jsonDecode(param);}

  clearFilelds(){
    colorName.text="";
    colorCode.text="";
  }


  buildColorSubmitField() {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: ElevatedButton(
             child:Text("Add"),
            onPressed: (){
              if(formKey.currentState!.validate()){
                formKey.currentState!.save();
                ColorService().colorAdd(this.color).then((response){
                  ResponseSnackbarService.generateResponse(response);
                  Get.to(CarListScreen());
                  clearFilelds();
                });
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
        ]);
  }

  selectProcess(Options options, Color color) async {
    switch (options) {
      case Options.update:
        Get.to(()=>ColorUpdateScreen(color));
        break;

      default:
    }
  }

}
