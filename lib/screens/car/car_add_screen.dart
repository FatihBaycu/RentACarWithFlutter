import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/brand_controller.dart';
import 'package:flutter_http_demo2/controllers/color_controller.dart';
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

  var _myBrandSelection;
  var _myColorSelection;
  var formKey = GlobalKey<FormState>();
  Car car = Car.required(
      colorId: 1,
      brandId: 1,
      modelYear: 2012,
      carFindexPoint: 80,
      carName: "A",
      dailyPrice: 201,
      description: "b"
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Car"),
      ),
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildColorsDropdownList(),
                buildBrandsDropdownList(),
                buidCarNameField(),
                buildCarModelYearField(),
                buildCarDailyPriceField(),
                buildCarFindexPointField(),
                buildCarDescriptionField(),
                buildCarSaveButton(),
              ],
            ),
          ),
        ]));
  }

  buidCarNameField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Enter car name year",
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onSaved: (String? value) {
        car.carName=value!;
      },
    );
  }

  buildCarDailyPriceField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: "Enter car daily price",
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onSaved: (String ?value) {
        car.dailyPrice = double.parse(value!);
      },
    );
  }

  buildCarFindexPointField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(hintText: "Enter car findex point",),
      validator: (String? value) {
        if (value == null || value.isEmpty) {return 'Please enter some text';}
        return null;
      },
      onSaved: (String? value) {car.carFindexPoint = int.parse(value!);},
    );
  }

  buildCarDescriptionField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: "Enter car description"),
      onSaved: (String? value) { car.description = value!;},
    );
  }

  buildCarSaveButton() {
     return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            CarService.addCar(this.car).then((value) {
              setState(() { Get.toNamed("/car-list"); });
            });
          }
        },
        child: Text('Add Car'),
      ),
    );
  }




  buildBrandsDropdownList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Select car brand",style: TextStyle(fontSize: 16),),
         Center(
          child:  DropdownButton(
            hint: Text("Brand"),
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
      ],
    );
  }


  buildColorsDropdownList() {
    return Row(
      mainAxisAlignment:  MainAxisAlignment.spaceBetween,
      children: [
        Text("Select car color",style: TextStyle(fontSize: 16,),),
        new Center(
          child: new DropdownButton(
            hint: Text("Color"),
            items: colorController.colorList.map((item) {
              return new DropdownMenuItem(
                child: new Text(item.colorName.toString()),
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
        ),
      ],
    );
  }

  buildCarModelYearField() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        hintText: "Enter car model year",
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onSaved: (String? value) {
        car.modelYear = int.parse(value!);
      },
    );
  }


}
