import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/color.dart';
import 'package:flutter_http_demo2/services/color_service.dart';

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


  @override
  void initState() {
    colorId.text=widget.color.colorId.toString();
    colorName.text=widget.color.colorName!;
    colorCode.text=widget.color.colorCode!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.color.colorName} Rengi"),),
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
      decoration: InputDecoration(hintText: "Enter color Id",border: OutlineInputBorder(),labelText: "Color Id"),
      controller: colorId,
      readOnly: true,
      validator: (val){
        if(val!.isEmpty){return "color id cannot be empty";}
        else {return null;}
      },
    );
  }
  buildColorNameField() {
    return TextFormField(
      decoration: InputDecoration(hintText: "Enter color name",border: OutlineInputBorder(),labelText: "Color Name"),
      controller: colorName,
      validator: (val){
        if(val!.isEmpty){return "color name cannot be empty";}
        else {return null;}
      },
      onSaved:(String? value){widget.color.colorName=value!;},
    );
  } buildColorCodeField() {
    return TextFormField(
      decoration: InputDecoration(hintText: "Enter color code",border: OutlineInputBorder(),labelText: "Color Code"),
      controller: colorCode,
      validator: (val){
        if(val!.isEmpty){return "color code cannot be empty";}
        else {return null;}
      },
      onSaved:(String? value){widget.color.colorCode=value!;},
    );
  }

  buildBrandSubmitField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        child:Text("Ekle"),
        onPressed: (){
          if(formKey.currentState!.validate()){
            formKey.currentState!.save();
            widget.color.colorName=colorName.text;
            widget.color.colorCode=colorCode.text;
            ColorService.colorUpdate(widget.color).then((value) => Navigator.pushReplacementNamed(context, "/color"));
          }
        },
      ),
    );
  }
}
