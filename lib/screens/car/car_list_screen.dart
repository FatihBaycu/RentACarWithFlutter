import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/brand_controller.dart';
import 'package:flutter_http_demo2/models/brand.dart';
import 'package:flutter_http_demo2/models/car.dart';
import 'package:flutter_http_demo2/models/carDetails.dart';
import 'package:flutter_http_demo2/models/carImage.dart';
import 'package:flutter_http_demo2/models/user.dart';
import 'package:flutter_http_demo2/models/color.dart';
import 'package:flutter_http_demo2/screens/car/car_detail.dart';
import 'package:flutter_http_demo2/services/brand_service.dart';
import 'package:flutter_http_demo2/services/car_service.dart';
import 'package:flutter_http_demo2/services/color_service.dart';
import 'package:flutter_http_demo2/widgets/DrawerWidget.dart';
import 'package:get/get.dart';


class CarListScreen extends StatefulWidget {
  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {

  BrandController brandController=Get.put(BrandController());



  var users = <User>[];
  var cars = <Car>[];
  List carDetails = <CarDetails>[];
  late List<CarDetails> carDetails2;
  var userWidget = <Widget>[];
  var colors = <Color>[];
  var brands = <Brand>[];

  var carImages = <CarImage>[];

  var _myBrandSelection;
  var _myColorSelection;

  @override
  void initState() {
      brands=brandController.brandList;
    getColorsFromApi();
    getCarDetailsFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(context),
      appBar: AppBar(title: Text("Car List"),),
      body: buildBody(),
      drawer: DrawerWidget(),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) => FloatingActionButton(child: Icon(Icons.add),onPressed: () => Navigator.pushNamed(context, "/car-add"),);

  Widget buildBody() {
    return Column(
      children: [
        SizedBox(
            width: double.infinity,
            height: 100,
            child: Row(
              children: [
                Expanded(flex: 2, child: buildColorsDropdownList()),
                Expanded(flex: 2, child: buildBrandsDropdownList()),
                Expanded(flex: 1, child: buildSelectFilterButton()),
                Expanded(flex: 1, child: buildClearFilterButton()),
              ],
            )),
        Expanded(child: buildCard()),
      ],
    );
  }


  buildColorsDropdownList() {
    return new Center(
      child: new DropdownButton(
        hint: Text("Colors"),
        items: colors.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.colorName!),
            value: item.colorId.toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            _myColorSelection = newVal;
            //getCarsByColorId(int.tryParse(newVal));
          });
        },
        value: _myColorSelection,
      ),
    );
  }

  buildBrandsDropdownList() {
    return new Center(
      child: new DropdownButton(
        hint: Text("Brands"),
        items: brands.map((item) {
          return new DropdownMenuItem(
            child: new Text(item.brandName!),
            value: item.brandId.toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            _myBrandSelection = newVal;
            //getCarsByBrandId(int.tryParse(newVal));
          });
        },
        value: _myBrandSelection,
      ),
    );
  }

  Widget buildListTile(Icon leading, String subTitle,String title){
    subTitle="";
    return ListTile(
      leading: leading,
      title: Text(title,style: TextStyle(fontWeight: FontWeight.w500)),
      subtitle: Text(subTitle),
    );
  }

  Widget buildListTile2(Icon leading,String title){
    return ListTile(
      leading: leading,
      title: Text(title,style: TextStyle(fontWeight: FontWeight.w500)),
    );
  }

  Widget buildListTile3(Icon leading,String title,IconButton tralling){
    return ListTile(
      leading: leading,
      title: Text(title,style: TextStyle(fontWeight: FontWeight.w500)),
      trailing: tralling,
    );
  }

  Widget buildCard() {
    return ListView.builder(
        itemCount: carDetails.length,
        itemBuilder: (BuildContext context, index) {
          var car=carDetails[index];
          return SizedBox(
            child: Card(
              child: Column(
                children: [
                  Image.network(
                      "https://10.0.2.2:5001/" + car.imagePath!),

                  buildListTile(Icon(Icons.car_rental,color: Colors.blue[500],),car.carName!,car.brandName!,),
                  buildListTile2(Icon(Icons.attach_money,color: Colors.blue[500],),car.dailyPrice!.toString(),),
                  ListTile(title: Text(carDetails[index].modelYear.toString()),
                      leading: Icon(Icons.date_range,color: Colors.blue,),
                      trailing: TextButton(child: Text("Detail"),
                        onPressed: () {setState(() {getCarImagesFromApi(carDetails[index]);
                          });
                        },
                      )),
                ],
              ),
            ),
          );
        });
  }

  Future<void> getCarsByColorId(int colorId) async {
    await CarService.getCarDetailsByColorId(colorId).then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.carDetails =
            list.map((carDetail) => CarDetails.fromJson(carDetail)).toList();
      });
    });
  }

  Future<void> getCarsByBrandId(int brandId) async {
    await CarService.getCarDetailsByBrandId(brandId).then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.carDetails =
            list.map((carDetail) => CarDetails.fromJson(carDetail)).toList();
      });
    });
  }

  Future<void> getCarsByBrandAndColorId(int brandId, int colorId) async {
    await CarService.getCarDetailsByBrandAndColorId(brandId, colorId)
        .then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.carDetails =
            list.map((carDetail) => CarDetails.fromJson(carDetail)).toList();
      });
    });
  }

  Future<void> getCarDetailsFromApi() async {
    await CarService.getCarDetails().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.carDetails =
            list.map((carDetail) => CarDetails.fromJson(carDetail)).toList();
      });
    });
  }

  Future<void> getColorsFromApi() async {
    await ColorService.getAll().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.colors = list.map((color) => Color.fromJson(color)).toList();
      });
    });
  }


  Future<void> getCarImagesFromApi(CarDetails carDetails) async {
    await CarService.getCarImagesByCarId(carDetails.carId!).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.carImages =
            list.map((carImage) => CarImage.fromJson(carImage)).toList();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) {
            return CarDetailScreen(carDetails, this.carImages);
          }),
        );
      });
    });
  }

  buildSelectFilterButton() {
    return IconButton(
      icon: Icon(Icons.search_sharp, color: Colors.blue),
      onPressed: () {
        setState(() {
          if (_myBrandSelection != null && _myColorSelection != null) {
            getCarsByBrandAndColorId(int.parse(this._myBrandSelection),
                int.parse(this._myColorSelection));
          } else if (_myBrandSelection != null && _myColorSelection == null) {
            getCarsByBrandId(int.parse(this._myBrandSelection));
          } else if(this._myColorSelection!=null){
            getCarsByColorId(int.parse(this._myColorSelection));
          }
          else{}
        });
      },
    );
  }

  buildClearFilterButton() {
    return IconButton(
      icon: Icon(
        Icons.delete,
        color: Colors.red,
      ),
      onPressed: () {
        setState(() {
          _myBrandSelection = null;
          _myColorSelection = null;
          getCarDetailsFromApi();
        });
      },
    );
  }
}
