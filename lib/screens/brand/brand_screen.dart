import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/brand_controller.dart';
import 'package:flutter_http_demo2/models/brand.dart';
import 'package:flutter_http_demo2/screens/brand/brand_update_screen.dart';
import 'package:flutter_http_demo2/services/brand_service.dart';
import 'package:get/get.dart';

class BrandScreen extends StatefulWidget {
  @override
  _BrandScreenState createState() => _BrandScreenState();
}

enum Options {update}

class _BrandScreenState extends State<BrandScreen> {
  var brands = <Brand>[];
  var formKey = GlobalKey<FormState>();

  var brandName=TextEditingController();

  Brand brand=Brand.required(brandName:"default",);

  BrandController brandController =Get.put(BrandController());

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
          Expanded(flex:2,child: buildNewBrandListWidget()),
        ],
      ),
    );
  }

  buildNewBrandListWidget(){
    return Obx((){
      if(brandController.isLoading.value)
          return Center(child: CircularProgressIndicator(),);
      else
        return ListView.builder(
          itemCount: brandController.brandList.length,
          itemBuilder: (context,int index){
            var brands=brandController.brandList;
            return ListTile(
              title: Text(brands[index].brandName.toString()),
              onTap: () {
              },
              trailing: buildPopupMenu(brands[index]),
            );
          });
    });
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
      case Options.update:Get.to(()=>BrandUpdateScreen(brand));break;
      default:
    }
  }

  buildFormField(){
    return ListView(
      padding: EdgeInsets.all(20),
      shrinkWrap: true,
      children: [
        Form(key: formKey, child: Column(
          children: [
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
