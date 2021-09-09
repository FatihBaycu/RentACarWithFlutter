import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/brand.dart';
import 'package:flutter_http_demo2/services/brand_service.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class BrandUpdateScreen extends StatefulWidget {
  Brand brand;
  BrandUpdateScreen(this.brand);

  @override
  _BrandUpdateScreenState createState() => _BrandUpdateScreenState();
}

class _BrandUpdateScreenState extends State<BrandUpdateScreen> {
  var formKey = GlobalKey<FormState>();
  var brandName = TextEditingController();
  var brandId = TextEditingController();

  @override
  void initState() {
    brandName.text = widget.brand.brandName!;
    brandId.text = widget.brand.brandId.toString();
    print("widget.brand!.brandName");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.brand.brandName} " + 'brand'.tr),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: buildFormField(),
        ),
      ),
    );
  }

  buildFormField() {
    return ListView(
      padding: EdgeInsets.all(20),
      shrinkWrap: true,
      children: [
        Form(
          key: formKey,
          child: Column(
            children: [
              buildBrandIdField(),
              SizedBox(
                height: 10,
              ),
              buildBrandNameField(),
              buildBrandSubmitField(),
            ],
          ),
        ),
      ],
    );
  }

  buildBrandIdField() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "enterBrandName".tr, border: OutlineInputBorder()),
      controller: brandId,
      readOnly: true,
      validator: (val) {
        if (val!.isEmpty) {
          return "brandNameErrorEmpty".tr;
        } else {
          return null;
        }
      },
      onSaved: (String? value) {
        widget.brand.brandName = value!;
      },
    );
  }

  buildBrandNameField() {
    return TextFormField(
      decoration: InputDecoration(
          hintText: "enterBrandName".tr,
          border: OutlineInputBorder(),
          labelText: "brandName".tr),
      controller: brandName,
      validator: (val) {
        if (val!.isEmpty) {
          return "brandNameErrorEmpty".tr;
        } else {
          return null;
        }
      },
      onSaved: (String? value) {
        widget.brand.brandName = value!;
      },
    );
  }

  buildBrandSubmitField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        child: Text("update".tr),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            widget.brand.brandName = brandName.text;
            widget.brand.brandId = int.parse(brandId.text);
            BrandService()
                .brandUpdate(widget.brand)
                .then((value) => Get.offNamed("/brand"));
          }
        },
      ),
    );
  }
}
