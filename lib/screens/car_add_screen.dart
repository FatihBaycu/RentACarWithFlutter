import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/car.dart';

class CarAddScreen extends StatefulWidget {
  @override
  _CarAddScreenState createState() => _CarAddScreenState();
}

class _CarAddScreenState extends State<CarAddScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Car car=Car(0,0,0,"",0,0,"",0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: Scaffold(
      appBar: AppBar(title: Text("Araba Ekle"),),
      body:buildForm(),
          ),
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
      key: _formKey,
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
                   TextFormField(decoration: const InputDecoration(hintText: "Enter car description",),
              validator: (String value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              onSaved: (String value){
                car.description=value;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  if(!_formKey.currentState.validate()){
                    debugPrint(car.description+car.carName);
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