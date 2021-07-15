import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/brand.dart';
import 'package:flutter_http_demo2/screens/brand/brand_update_screen.dart';
import 'package:flutter_http_demo2/services/brand_service.dart';
import 'package:flutter_http_demo2/widgets/DrawerWidget.dart';

class BrandScreen extends StatefulWidget {
  @override
  _BrandScreenState createState() => _BrandScreenState();
}

enum Options { update, delete }

class _BrandScreenState extends State<BrandScreen> {
  var brands = <Brand>[];
  var formKey = GlobalKey<FormState>();

  var brandName=TextEditingController();

  Brand brand=Brand.required(brandName:"default",);

  @override
  void initState() {
    getBrandsFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Brands")),
      body: buildBody(),
    );
  }

  buildBody() {
    return Container(
      child: Column(
        children: [
          Expanded(flex:1,child: buildFormField()),
          Expanded(flex:2,child: buildBrandList()),
        ],
      ),
    );
  }

  buildBrandList() {
    return ListView.builder(
        itemCount: brands.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(brands[index].brandName.toString()),
            onTap: () {
              //_showMyDialog();
            },
            trailing: buildPopupMenu(brands[index]),
          );
        });
  }

  Future<void>getBrandsFromApi()async {
   await BrandService.getAll().then((response) {
      setState(() {
        Iterable list = jsonDecode(response.body)["data"];
        this.brands = list.map((brand) => Brand.fromJson(brand)).toList();
      });
    });
  }

  buildAlertDialog() {
    return AlertDialog(
      title: Text("Select"),
      content: Text("Update"),
      actions: [
        TextButton(onPressed: () {}, child: Text("Update")),
      ],
      elevation: 24.0,
      backgroundColor: Colors.blue,
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[Text(''),],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Update'),
              onPressed: () {Navigator.of(context).pop();},
            ),
          ],
        );
      },
    );
  }

  buildPopupMenu(Brand brand) {
    return PopupMenuButton<Options>(
        onSelected: (value) => selectProcess(value, brand),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                child: Text("Güncelle"),
                value: Options.update,
              ),
            ]);
  }

  selectProcess(Options options, Brand brand) async {
    switch (options) {
      case Options.update:Navigator.push(context, MaterialPageRoute(builder: (context)=>BrandUpdateScreen(brand)));break;
      default:
    }
  }

  buildFormField(){
    return ListView(
      padding: EdgeInsets.all(20),
      shrinkWrap: true,
      children: [
        Form(key: formKey, child: Column(children: [
              buildBrandNameField(),
              buildBrandSubmitField(),
            ],
          ),
        ),
      ],
    );

  }

  buildBrandNameField() {
    return TextFormField(decoration: const InputDecoration(hintText: "Enter brand name"),
      autovalidateMode: AutovalidateMode.always,
      controller: brandName,
      validator: (String? value){
        if(value!=null){
          if(value.length<2){return "The brand name length must be higher than 2.";}
        }
      },
      onSaved:(String? value){brand.brandName=value!;},
    );
  }



  buildBrandSubmitField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(child:Text("Ekle"),
        onPressed: (){
        if(formKey.currentState!.validate()){
          formKey.currentState!.save();
          BrandService.brandAdd(this.brand);
        }
        },
      ),
    );
  }


}