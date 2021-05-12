import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/brand.dart';
import 'package:flutter_http_demo2/models/car.dart';
import 'package:flutter_http_demo2/models/color.dart';
import 'package:flutter_http_demo2/services/brand_service.dart';
import 'package:flutter_http_demo2/services/car_service.dart';
import 'dart:convert';

import 'package:flutter_http_demo2/services/color_service.dart';



class CarAddScreen extends StatefulWidget {
  @override
  _CarAddScreenState createState() => _CarAddScreenState();
}

class _CarAddScreenState extends State<CarAddScreen> {

  var colors = <Color>[];
  var brands = <Brand>[];
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
    getBrandsFromApi();
    getColorsFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Add"),
      ),
      body: buildForm(),
    );
  }

  buildForm() {
    return Container(
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
      validator: (String value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onSaved: (String value) {
        car.carName = value;
      },
    );
  }

  buildCarDailyPriceField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Enter car daily price",
      ),
      validator: (String value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onSaved: (String value) {
        car.dailyPrice = double.tryParse(value);
      },
    );
  }

  buildCarFindexPointField() {
    return TextFormField(
      decoration: const InputDecoration(
        hintText: "Enter car findex point",
      ),
      validator: (String value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onSaved: (String value) {
        car.carFindexPoint = int.tryParse(value);
      },
    );
  }

  buildCarDescriptionField() {
    return TextFormField(
      decoration: const InputDecoration(hintText: "Enter car description"),
      onSaved: (String value) {
        car.description = value;
      },
    );
  }

  buildCarSaveButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
            // car.carName="a";
            // car.brandId=1;
            // car.colorId=1;
            // car.dailyPrice=10;
            // car.carFindexPoint=1;
            // car.modelYear=1;

            CarService.addCar(this.car).then((value) {
              setState(() {
                Navigator.pushNamed(context, "/car-list");
              });
            });
          }
        },
        child: const Text('Araba Ekle'),
      ),
    );
  }

  void getColorsFromApi() {
    ColorService.getAll().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.colors = list.map((color) => Color.fromJson(color)).toList();
      });
    });
  }

  void getBrandsFromApi() {
    BrandService.getAll().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.brands = list.map((brand) => Brand.fromJson(brand)).toList();
      });
    });
  }

  buildBrandsDropdownList() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("Select car brand",style: TextStyle(fontSize: 15),),
        new Center(
          child: new DropdownButton(
            items: brands.map((item) {
              return new DropdownMenuItem(
                child: new Text(item.brandName),
                value: item.brandId.toString(),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                this.car.brandId=int.tryParse(newVal);
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
        Text("Select car color",style: TextStyle(fontSize: 15,),),
        new Center(
          child: new DropdownButton(
            items: colors.map((item) {
              return new DropdownMenuItem(
                child: new Text(item.colorName),
                value: item.colorId.toString(),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                this.car.colorId=int.tryParse(newVal);
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
      decoration: const InputDecoration(
        hintText: "Enter car model year",
      ),
      validator: (String value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
      onSaved: (String value) {
        car.modelYear = int.tryParse(value);
      },
    );
  }


}
