import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/brand.dart';
import 'package:flutter_http_demo2/models/color.dart';
import 'package:flutter_http_demo2/models/car.dart';
import 'package:flutter_http_demo2/models/carDetails.dart';
import 'package:flutter_http_demo2/services/brand_service.dart';
import 'package:flutter_http_demo2/services/car_service.dart';
import 'package:flutter_http_demo2/services/color_service.dart';

class CarUpdateScreen extends StatefulWidget {
  CarDetails carDetails;
  CarUpdateScreen(this.carDetails);

  @override
  _CarUpdateScreenState createState() => _CarUpdateScreenState();
}



class _CarUpdateScreenState extends State<CarUpdateScreen> {

  var colors = <Color>[];
  var brands = <Brand>[];
  var myBrandSelection;
  var myColorSelection;
  Car car=new Car(0, 0, 0, "", 0, 0, "", 0);

  var formKey = GlobalKey<FormState>();
  var carId = TextEditingController();
  var carName = TextEditingController();
  var brandName = TextEditingController();
  var modelYear = TextEditingController();
  var colorName = TextEditingController();
  var dailyPrice = TextEditingController();
  var imagePath = TextEditingController();
  var brandId = TextEditingController();
  var colorId = TextEditingController();
  var carFindexPoint = TextEditingController();
  var description = TextEditingController();

  @override
  void initState() {
    // myColorSelection=widget.carDetails.colorId;
    // myBrandSelection=widget.carDetails.brandId;
    //
    getColorsFromApi();
    getBrandsFromApi();
    carId.text=widget.carDetails.carId.toString();
    carName.text=widget.carDetails.carName!;
    brandName.text=widget.carDetails.brandName!;
    modelYear.text=widget.carDetails.modelYear!.toString();
    colorName.text=widget.carDetails.colorName!;
    dailyPrice.text=widget.carDetails.dailyPrice!.toString();
    imagePath.text=widget.carDetails.imagePath!;
    brandId.text=widget.carDetails.brandId!.toString();
    colorId.text=widget.carDetails.colorId!.toString();
    carFindexPoint.text=widget.carDetails.carFindexPoint!.toString();
    description.text=widget.carDetails.description!.toString();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Update"),
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: formKey,
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                 TextFormField(controller: carId,autovalidateMode: AutovalidateMode.always,
                  readOnly: true,
                  decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Car Id"),
                  validator: (value){if(value!=null){}else{ return "Cannot be empty.";}},
                onChanged: (value)=>car.id=int.parse(value)
                ),


                TextFormField(
                  decoration: InputDecoration(hintText: "Enter Description",border: OutlineInputBorder(),labelText: "Descrition"),
                  controller: description,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (val){
                    if(val!.isEmpty){return "Description cannot be empty";}
                    else if(val.length<=2){return "Description length must be greater than two";}
                    else {return null;}
                  },
                  onSaved:(value){car.description=value!;},
                ),

                TextFormField(
                    controller: carName,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Car Name"),
                    validator: (val){
                      if(val!.isEmpty){return "Description cannot be empty";}
                      else {return null;}
                    },
                onChanged: (value)=>car.carName=value
                ),
                TextFormField(controller: modelYear,autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Model Year"),
                    validator: (val){
                      if(val!.isEmpty){return "Model Year cannot be empty";}
                      else {return null;}
                    },onChanged: (value)=>car.modelYear=int.parse(value)
                ),

                buildColorsDropdownList(),
                buildBrandsDropdownList(),
                TextFormField(controller: dailyPrice,autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Daily Price"),
                    validator: (val){
                      if(val!.isEmpty){return "Daily Price cannot be empty";}
                      else if(val.length<=1){return "Daily Price length must be greater than 0";}
                      else {return null;}
                    },                onChanged: (value)=>car.dailyPrice=double.parse(value)
                ),

                TextFormField(controller: carFindexPoint,autovalidateMode: AutovalidateMode.always,
                  keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: "Car Findex Point"),
                    validator: (val){
                      if(val!.isEmpty){return "Car Findex Point cannot be empty";}
                      else {return null;}
                    },
                onChanged: (value){car.carFindexPoint=int.parse(value);
                print(value); print(car.carFindexPoint.toString());}
                ),
                buildCarSubmitField(),
              ],
            ),
        ),
      ),
    );
  }



  Widget buildTextFormField(TextEditingController controller,String labelText){
    return TextFormField(
      controller: controller,
      autovalidateMode: AutovalidateMode.always,
      decoration: InputDecoration(labelText:labelText,border: OutlineInputBorder()),

      onSaved:(value){},

    );
  }
  buildBrandsDropdownList() {
    return Container(
        child: InputDecorator(
          decoration: InputDecoration(labelText: 'Brands',border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    child:DropdownButton(
      hint: Text("Brands"),
      menuMaxHeight:250,
      items: brands.map((item) {
        return  DropdownMenuItem(
          child:  Text(item.brandName!),
          value: item.brandId.toString()
        );
      }).toList(),
      onChanged: (newVal) {
        setState(() {
          myBrandSelection = newVal;
          car.brandId=int.parse(myBrandSelection);
          print(car.brandId);
          //getCarsByBrandId(int.tryParse(newVal));
        });
      },
      value: myBrandSelection,
    ),
    ),
    );
  }
  buildColorsDropdownList() {
    return  Container(
      child: InputDecorator(
      decoration: InputDecoration(labelText: 'Color',border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),
    ),
    ),
    child:DropdownButton(
      menuMaxHeight:250,
      hint: Text("Colors"),
      items: colors.map((item) {
        return DropdownMenuItem(
          child:  Text(item.colorName!),
          value: item.colorId.toString(),
        );
      }).toList(),
      onChanged: (newVal) {
        setState(() {myColorSelection = newVal;});
        car.colorId=int.parse(myColorSelection);
      },
      value: myColorSelection,
    ),
      ),
    );
  }

  Future<void> getColorsFromApi() async {
    await ColorService.getAll().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.colors = list.map((color) => Color.fromJson(color)).toList();
      });
    });
  }

  buildCarSubmitField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        child:Text("Update"),
        onPressed: (){
          if(formKey.currentState!.validate()){
            formKey.currentState!.save();
            car.id=widget.carDetails.carId;
           CarService.updateCar(car).then((value) => Navigator.pushReplacementNamed(context, "/car-list"));
          }
        },
      ),
    );
  }


  Future<void> getBrandsFromApi() async {
    await BrandService.getAll().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.brands = list.map((brand) => Brand.fromJson(brand)).toList();
      });
    });
  }
}
