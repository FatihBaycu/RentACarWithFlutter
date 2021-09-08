import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/brand_controller.dart';
import 'package:flutter_http_demo2/controllers/color_controller.dart';
import 'package:flutter_http_demo2/core/ResponseService.dart';
import 'package:flutter_http_demo2/models/car.dart';
import 'package:flutter_http_demo2/services/car_service.dart';
import 'package:get/get.dart';



class CarAddScreen extends StatefulWidget {
  @override
  _CarAddScreenState createState() => _CarAddScreenState();
}

class _CarAddScreenState extends State<CarAddScreen> {

  BrandController brandController=Get.put(BrandController());
  ColorController colorController=Get.put(ColorController());


  var carName = TextEditingController();
  var modelYear = TextEditingController();
  var dailyPrice = TextEditingController();
  var brandId = TextEditingController();
  var colorId = TextEditingController();
  var carFindexPoint = TextEditingController();
  var description = TextEditingController();


  var _myBrandSelection;
  var _myColorSelection;
  var formKey = GlobalKey<FormState>();
  Car car = Car.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("addCar".tr),),
      body: buildForm(),
    );
  }

  buildForm() {
    return Container(
      padding: EdgeInsets.all(20),
        child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            children: <Widget>[
          Form(
            key: formKey,
            child: Wrap(
              runSpacing: 20,
              children: <Widget>[
                buildColorsDropdownList(),
                buildBrandsDropdownList(),

                buidTextFormField(carName,"carName".tr),
                buidTextFormField(modelYear,"modelYear".tr),
                buidTextFormField(dailyPrice,"dailyPrice".tr),
                buidTextFormField(carFindexPoint,"carFindexPoint".tr),
                buidTextFormField(description,"description".tr),

                buildCarSaveButton(),
              ],
            ),
          ),
        ]));
  }


  buidTextFormField(TextEditingController controller,String labelText) {
    return TextFormField(
      controller: controller,
      decoration:  InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) { return "pleaseSomeText".tr;}
        return null;
      },
    );
  }


  buildCarSaveButton() {
     return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if(formKey.currentState!.validate()){
            formKey.currentState!.save();

            car.description=description.text;
            car.modelYear=int.parse(modelYear.text);
            car.carFindexPoint=int.parse(carFindexPoint.text);
            car.carName=carName.text;
            car.colorId=int.parse(_myColorSelection);
            car.brandId=int.parse(_myBrandSelection);
            car.dailyPrice=double.parse(dailyPrice.text);

           CarService().addCar(car).then((response) =>Get.offAllNamed("/car-list")!.then((value) => ResponseSnackbarService.generateResponse(response)));

          }
        },
        child: Text("addCar".tr),
      ),
    );
  }



  buildBrandsDropdownList() {
    return Container(
      child: InputDecorator(
        decoration: InputDecoration(labelText: "brands".tr,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),
        ),
        ),
        child: DropdownButton(
          menuMaxHeight: Get.height/2,
          hint: Text("brand".tr),
          items: brandController.brandList.map((item) {
            return  DropdownMenuItem(
              child:  Text(item.brandName!),
              value: item.brandId.toString(),
            );
          }).toList(),
          onChanged: (newVal) {
            setState(() {
              this.car.brandId=int.parse(newVal.toString());
              _myBrandSelection = newVal;
            });
          },
          value:_myBrandSelection,
        ),
      ),
    );
  }


  buildColorsDropdownList() {
    return Container(
        child: InputDecorator(
        decoration: InputDecoration(labelText: "colors".tr,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),
    ),
    ),
    child:  DropdownButton(
      menuMaxHeight: Get.height/2,
        hint: Text("Color".tr),
        items: colorController.colorList.map((item) {
          return  DropdownMenuItem(
            child:  Text(item.colorName.toString()),
            value: item.colorId.toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            this.car.colorId=int.parse(newVal.toString());
            _myColorSelection = newVal;
          });
        },
        value: _myColorSelection,
      ),
    )
    );
  }

}
