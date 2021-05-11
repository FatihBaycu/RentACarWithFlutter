import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/car.dart';
import 'package:flutter_http_demo2/services/car_service.dart';
import 'dart:convert';

class CarAddScreen extends StatefulWidget {
  @override
  _CarAddScreenState createState() => _CarAddScreenState();
}

class _CarAddScreenState extends State<CarAddScreen> {
  var formKey = GlobalKey<FormState>();
  Car car=Car.required(colorId: 1,brandId: 1,modelYear: 2012,carFindexPoint: 80,carName: "A",dailyPrice: 201,description: "b");


  @override
  Widget build(BuildContext context) {
      return Scaffold(
      appBar: AppBar(title: Text("Araba Ekle"),),
      body:buildForm(),
          );

      }
    
      buildForm() {
        return Container(
                //margin: EdgeInsets.all(20.0),

          child: ListView(
            shrinkWrap: true,
                        padding: EdgeInsets.only(left: 15,right: 15,top:10),
children: <Widget>[
              Form(
      key: formKey,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
      // TextFormField(decoration: const InputDecoration(hintText: "Enter color id",),
      //         validator: (String value) {
      //           if (value == null || value.isEmpty) {
      //             return 'Please enter some text';
      //           }
      //           return null;
      //         },
      //         onSaved: (String value){
      //           car.colorId=int.tryParse(value);
      //         },
      //       ),

      // TextFormField(decoration: const InputDecoration(hintText: "Enter brand id",),
      //         validator: (String value) {
      //           if (value == null || value.isEmpty) {
      //             return 'Please enter some text';
      //           }
      //           return null;
      //         },
      //         onSaved: (String value){
      //           car.brandId=int.tryParse(value);
      //         },
      //       ),
      //
      //             TextFormField(decoration: const InputDecoration(hintText: "Enter car name",),
      //         validator: (String value) {
      //           if (value == null || value.isEmpty) {
      //             return 'Please enter some text';
      //           }
      //           return null;
      //         },
      //         onSaved: (String value){
      //           car.carName=value;
      //         },
      //       ),
      //
      //
      //             TextFormField(decoration: const InputDecoration(hintText: "Enter car model year",),
      //         validator: (String value) {
      //           if (value == null || value.isEmpty) {
      //             return 'Please enter some text';
      //           }
      //           return null;
      //         },
      //         onSaved: (String value){
      //           car.modelYear=int.tryParse(value);
      //         },
      //       ),
      //
      //             TextFormField(decoration: const InputDecoration(hintText: "Enter car daily price",),
      //         validator: (String value) {
      //           if (value == null || value.isEmpty) {
      //             return 'Please enter some text';
      //           }
      //           return null;
      //         },
      //         onSaved: (String value){
      //           car.dailyPrice=double.tryParse(value);
      //         },
      //       ),
      //
      //
      //              TextFormField(decoration: const InputDecoration(hintText: "Enter car findex point",),
      //         validator: (String value) {
      //           if (value == null || value.isEmpty) {
      //             return 'Please enter some text';
      //           }
      //           return null;
      //         },
      //         onSaved: (String value){
      //           car.carFindexPoint=int.tryParse(value);
      //         },
      //       ),
      //
                   TextFormField(
                     decoration: const InputDecoration(
                       hintText: "Enter car description"),
                    onSaved: (String value){
                          car.description=value;

                          },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if(formKey.currentState.validate()){
                    formKey.currentState.save();
                    // car.carName="a";
                    // car.brandId=1;
                    // car.colorId=1;
                    // car.dailyPrice=10;
                    // car.carFindexPoint=1;
                    // car.modelYear=1;
                    CarService.addCar(this.car).then((value) => print(json.decode(value.body)));
                  }
               
                },
                child: const Text('Submit'),
              ),
            ),
          ],
      ),
    ),]
        )
        );
 }
}