import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/brand_controller.dart';
import 'package:flutter_http_demo2/controllers/color_controller.dart';
import 'package:flutter_http_demo2/models/brand.dart';
import 'package:flutter_http_demo2/models/color.dart';
import 'package:flutter_http_demo2/models/car.dart';
import 'package:flutter_http_demo2/models/carDetails.dart';
import 'package:flutter_http_demo2/services/car_service.dart';
import 'package:get/get.dart';

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

  var selectionColorValue;
  var selectionBrandValue;
  @override
  void initState() {
    car.id=widget.carDetails.carId!=null?widget.carDetails.carId:0;
    car.colorId=widget.carDetails.colorId!=null?widget.carDetails.colorId:0;
    car.brandId=widget.carDetails.brandId!=null?widget.carDetails.brandId:0;
    car.description=widget.carDetails.description!=null?widget.carDetails.description:"null";
    car.modelYear=widget.carDetails.modelYear!=null?widget.carDetails.modelYear:0;
    car.dailyPrice=widget.carDetails.dailyPrice!=null?widget.carDetails.dailyPrice!.toDouble():0;
    car.carFindexPoint=widget.carDetails.carFindexPoint!=null?widget.carDetails.carFindexPoint:0;
    car.carName=widget.carDetails.carName!=null?widget.carDetails.carName:"null";

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


    myBrandSelection=widget.carDetails.brandId;
    myColorSelection=widget.carDetails.colorId;

    super.initState();
  }


  ColorController colorController=Get.put(ColorController());
  BrandController brandController=Get.put(BrandController());

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("carUpdate".tr),
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
                  validator: (value){if(value!=null){}else{ return "cannotBeEmpty".tr;}},
                onChanged: (value)=>car.id=int.parse(value)
                ),


                TextFormField(
                  decoration: InputDecoration(hintText: "description".tr,border: OutlineInputBorder(),labelText: "description".tr),
                  controller: description,
                  autovalidateMode: AutovalidateMode.always,
                  validator: (val){
                    if(val!.isEmpty){return "cannotBeEmpty".tr;}
                    else if(val.length<=2){return "lengthGreaterThanTwo".tr;}
                    else {return null;}
                  },
                  onSaved:(value){car.description=value!;},
                ),

                TextFormField(
                    controller: carName,
                    autovalidateMode: AutovalidateMode.always,
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: "carName".tr),
                    validator: (val){
                    if(val!.isEmpty){return "cannotBeEmpty".tr;}
                      else {return null;}
                    },
                onChanged: (value)=>car.carName=value
                ),
                TextFormField(controller: modelYear,autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: "modelYear".tr),
                    validator: (val){
                    if(val!.isEmpty){return "cannotBeEmpty".tr;}
                      else {return null;}
                    },onChanged: (value)=>car.modelYear=int.parse(value)
                ),

                buildColorsDropdownList(),
                buildBrandsDropdownList(),
                TextFormField(controller: dailyPrice,autovalidateMode: AutovalidateMode.always,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: "dailyPrice".tr),
                    validator: (val){
                    if(val!.isEmpty){return "cannotBeEmpty".tr;}
                      else if(val.length<=1){return "dailyPriceError".tr;}
                      else {return null;}
                    },                onChanged: (value)=>car.dailyPrice=double.parse(value)
                ),

                TextFormField(controller: carFindexPoint,autovalidateMode: AutovalidateMode.always,
                  keyboardType: TextInputType.number,
                    decoration: InputDecoration(border: OutlineInputBorder(),labelText: "findexPoint".tr),
                    validator: (val){
                    if(val!.isEmpty){return "cannotBeEmpty".tr;}
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


  buildBrandsDropdownList() {
    return Container(
        child: InputDecorator(
          decoration: InputDecoration(labelText: "brand".tr,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    child:DropdownButton(
      hint: Text(widget.carDetails.brandName!,style: TextStyle(fontWeight: FontWeight.bold),),
      menuMaxHeight:250,
      items: brandController.brandList.map((item) {
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
           selectionBrandValue=myBrandSelection;
        });
      },
      value: selectionBrandValue,
    ),
    ),
    );
  }
  buildColorsDropdownList() {
    return  Container(
      child: InputDecorator(
      decoration: InputDecoration(labelText: "color".tr,border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0),
    ),
    ),
    child:Obx(() {
      return DropdownButton(
        menuMaxHeight: 250,
        hint: Text(widget.carDetails.colorName!,
          style: TextStyle(fontWeight: FontWeight.bold),),
        items: colorController.colorList.map((item) {
          return DropdownMenuItem(
            child: Text(item.colorName!),
            value: item.colorId.toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            myColorSelection = newVal;
            selectionColorValue=myColorSelection;
          });
          car.colorId = int.parse(myColorSelection);
        },
        value: selectionColorValue,
      );
    }),
      ),
    );
  }



  buildCarSubmitField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        child:Text("update".tr),
        onPressed: ()  {


          if(formKey.currentState!.validate()){
            formKey.currentState!.save();
            car.id=widget.carDetails.carId;
            car.description=description.text;
            car.modelYear=int.parse(modelYear.text);
            car.carFindexPoint=int.parse(carFindexPoint.text);
            car.carName=carName.text;
            car.dailyPrice=double.parse(dailyPrice.text);
             CarService().updateCar(car);
             Get.toNamed("/car-list");

          }
        },
      ),
    );
  }
}
