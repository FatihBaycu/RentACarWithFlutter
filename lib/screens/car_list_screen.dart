import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/brand.dart';
import 'package:flutter_http_demo2/models/car.dart';
import 'package:flutter_http_demo2/models/carDetails.dart';
import 'package:flutter_http_demo2/models/carImage.dart';
import 'package:flutter_http_demo2/models/user.dart';
import 'package:flutter_http_demo2/models/color.dart';
import 'package:flutter_http_demo2/screens/car_add_screen.dart';
import 'package:flutter_http_demo2/screens/car_detail.dart';
import 'package:flutter_http_demo2/services/brand_service.dart';
import 'package:flutter_http_demo2/services/car_service.dart';
import 'package:flutter_http_demo2/services/color_service.dart';
import 'package:flutter_http_demo2/widgets/DrawerWidget.dart';

class CarListScreen extends StatefulWidget {
  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  var users = <User>[];
  var cars = <Car>[];
  var carDetails = <CarDetails>[];
  var userWidget = <Widget>[];
  var colors = <Color>[];
  var brands = <Brand>[];

  var carImages = <CarImage>[];

  var _myBrandSelection;
  var _myColorSelection;

  @override
  void initState() {
    getColorsFromApi();
    getBrandsFromApi();
    getCarDetailsFromApi();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, "/car-add"),
      ),
      appBar: AppBar(title: Text("Car List"),),
      body: buildBody(),
      drawer: DrawerWidget(),
    );
  }

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
                Expanded(flex:1,child:buildSelectFilterButton()),
                Expanded(flex: 1,child:buildClearFilterButton()),
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

  Widget buildCard() {
    return ListView.builder(
        itemCount: carDetails.length,
        itemBuilder: (BuildContext context, index) {
          return SizedBox(
            child: Card(
              child: Column(
                children: [
                  Image.network(
                      "https://10.0.2.2:5001/" + carDetails[index].imagePath!),
                  ListTile(
                    title: Text(carDetails[index].carName!,
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text(carDetails[index].brandName!),
                    leading: Icon(
                      Icons.car_rental,
                      color: Colors.blue[500],
                    ),
                  ),
                  ListTile(
                    title: Text(carDetails[index].dailyPrice.toString(),
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    leading: Icon(
                      Icons.attach_money,
                      color: Colors.blue[500],
                    ),
                  ),
                  ListTile(
                      title: Text(carDetails[index].modelYear.toString()),
                      leading: Icon(
                        Icons.date_range,
                        color: Colors.blue,
                      ),
                      trailing: TextButton(
                        child: Text("Detail"),
                        onPressed: () {
                          setState(() {
                            getCarImagesFromApi(carDetails[index]);
                          });
                        },
                      )),
                ],
              ),
            ),
          );
        });
  }

  Future<void> getCarsByColorId(int colorId)async {
    await CarService.getCarDetailsByColorId(colorId).then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.carDetails =
            list.map((carDetail) => CarDetails.fromJson(carDetail)).toList();
      });
    });
  }

  Future<void>  getCarsByBrandId(int brandId) async{
    await CarService.getCarDetailsByBrandId(brandId).then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.carDetails =
            list.map((carDetail) => CarDetails.fromJson(carDetail)).toList();
      });
    });
  }

  Future<void>  getCarsByBrandAndColorId(int brandId, int colorId)async {
    await CarService.getCarDetailsByBrandAndColorId(brandId, colorId)
        .then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.carDetails =
            list.map((carDetail) => CarDetails.fromJson(carDetail)).toList();
      });
    });
  }

  Future<void> getCarDetailsFromApi() async{
   await CarService.getCarDetails().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.carDetails =
            list.map((carDetail) => CarDetails.fromJson(carDetail)).toList();
      });
    });
  }




  Future<void>  getColorsFromApi()async {
    await ColorService.getAll().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.colors = list.map((color) => Color.fromJson(color)).toList();
      });
    });
  }

  Future<void> getBrandsFromApi() async{
    await BrandService.getAll().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        this.brands = list.map((brand) => Brand.fromJson(brand)).toList();
      });
    });
  }

  Future<void> getCarImagesFromApi(CarDetails carDetails)async {
    await CarService.getCarImagesByCarId(carDetails.carId!).then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
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
          if (_myBrandSelection != null &&
              _myColorSelection != null) {
            getCarsByBrandAndColorId(
                int.parse(this._myBrandSelection),
                int.parse(this._myColorSelection));
          } else if (_myBrandSelection != null &&
              _myColorSelection == null) {
            getCarsByBrandId(
                int.parse(this._myBrandSelection));
          } else {
            getCarsByColorId(
                int.parse(this._myColorSelection));
          }
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