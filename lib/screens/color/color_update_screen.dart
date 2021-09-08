import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/color.dart';
import 'package:flutter_http_demo2/services/color_service.dart';
import 'package:get/get.dart';

class ColorUpdateScreen extends StatefulWidget {
  Color color;
  ColorUpdateScreen(this.color);
  @override
  _ColorUpdateScreenState createState() => _ColorUpdateScreenState();
}

class _ColorUpdateScreenState extends State<ColorUpdateScreen> {

  var formKey = GlobalKey<FormState>();
  var colorName=TextEditingController();
  var colorCode=TextEditingController();
  var colorId=TextEditingController();

  var snackBar = SnackBar(content: Text("success.toString()+message"));

  @override
  void initState() {
    colorId.text=widget.color.colorId!=null?widget.color.colorId.toString():"null";
    colorName.text=widget.color.colorName!=null?widget.color.colorName.toString():"null";
    colorCode.text=widget.color.colorCode!=null?widget.color.colorCode.toString():"null";
    // colorName.text=widget.color.colorName!;
    // colorCode.text=widget.color.colorCode!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(title: Text("${widget.color.colorName} "+'color'.tr),),
      body: SingleChildScrollView(
        child: Center(
          child: buildFormField(),
        ),
      ),
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
              buildColorIdField(),
              SizedBox(height: 10,),
              buildColorNameField(),
              SizedBox(height: 10,),
              buildColorCodeField(),
              buildBrandSubmitField(),
            ],
          ),
        ),
      ],
    );

  }

  buildColorIdField() {
    return TextFormField(
      decoration: InputDecoration(hintText: "colorId".tr,border: OutlineInputBorder(),labelText: "colorId".tr),
      controller: colorId,
      readOnly: true,
      validator: (val){
        if(val!.isEmpty){return "cannotBeEmpty".tr;}
        else {return null;}
      },
    );
  }
  buildColorNameField() {
    return TextFormField(
      decoration: InputDecoration(hintText: "colorName".tr,border: OutlineInputBorder(),labelText: "colorName".tr),
      controller: colorName,
      validator: (val){
        if(val!.isEmpty){return "cannotBeEmpty".tr;}
        else {return null;}
      },
      onSaved:(String? value){widget.color.colorName=value!;},
    );
  } buildColorCodeField() {
    return TextFormField(
      decoration: InputDecoration(hintText: "colorCode".tr,border: OutlineInputBorder(),labelText: "colorCode".tr),
      controller: colorCode,
      validator: (val){
        if(val!.isEmpty){return "cannotBeEmpty".tr;}
        else {return null;}
      },
      onSaved:(String? value){widget.color.colorCode=value!;},
    );
  }

  buildBrandSubmitField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        child:Text("update".tr),
        onPressed: (){
          if(formKey.currentState!.validate()){
            formKey.currentState!.save();
            widget.color.colorName=colorName.text;
            widget.color.colorCode=colorCode.text;

            ColorService().colorUpdate(widget.color);
          }
        },
      ),
    );
  }
}
