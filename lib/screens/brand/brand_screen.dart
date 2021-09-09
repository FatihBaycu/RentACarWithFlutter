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

enum Options { update }

class _BrandScreenState extends State<BrandScreen> {
  var brands = <Brand>[];
  var formKey = GlobalKey<FormState>();

  var brandName = TextEditingController();

  Brand brand = Brand.required(
    brandName: "default",
  );

  //BrandController brandController = Get.put(BrandController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Brands")),
      body: buildBody(),
    );
  }

  buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              buildFormField(),
              buildNewBrandListWidget(),
            ],
          ),
        ),
      ),
    );
  }

  buildNewBrandListWidget() {
    return GetX<BrandController>(
      init: BrandController(),
      builder: (_brandController){
     return SingleChildScrollView(
          child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.only(left: 20, right: 20),
              itemCount: _brandController.brandList.length,
              itemBuilder: (context, int index) {
                var brands = _brandController.brandList;
                return ListTile(
                  title: Text(brands[index].brandName.toString()),
                  onTap: () {},
                  trailing: buildPopupMenu(brands[index]),
                );
              }),
        );
    });
  }

   
  

  buildPopupMenu(Brand brand) {
    return PopupMenuButton<Options>(
        onSelected: (value) => selectProcess(value, brand),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                child: Text("update".tr),
                value: Options.update,
              ),
            ]);
  }

  selectProcess(Options options, Brand brand) async {
    switch (options) {
      case Options.update:
        Get.to(() => BrandUpdateScreen(brand));
        break;
      default:
    }
  }

  buildFormField() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          buildBrandNameField(),
          buildBrandSubmitField(),
        ],
      ),
    );
  }

  buildBrandNameField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "enterBrandName".tr,
        border: OutlineInputBorder(),
      ),
      autovalidateMode: AutovalidateMode.always,
      controller: brandName,
      validator: (String? value) {
        if (value != null) {
          if (value.length < 2) {
            return "brandNameErrorLength".tr;
          }
        }
      },
      onSaved: (String? value) {
        brand.brandName = value!;
      },
    );
  }


  buildBrandSubmitField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        child: Text('add'.tr),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            BrandService().brandAdd(this.brand);
            BrandController().getAll().then((value) => Get.toNamed("/car-list"));
          }
        },
      ),
    );
  }
}
