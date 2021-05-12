import 'dart:convert';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/carDetails.dart';
import 'package:flutter_http_demo2/models/carImage.dart';
import 'package:flutter_http_demo2/services/car_service.dart';

// ignore: must_be_immutable
class CarDetailScreen extends StatefulWidget {
  CarDetails selectedCar;
  CarDetailScreen(CarDetails selectedCar) {
    this.selectedCar = selectedCar;
  }

  @override
  _CarDetailScreenState createState() => _CarDetailScreenState(selectedCar);
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  CarDetails selectedCar;

  _CarDetailScreenState(CarDetails selectedCar) {
    this.selectedCar = selectedCar;
  }

  var carImages = <CarImage>[];
  var baseUrl = "https://10.0.2.2:5001/";
  @override
  void initState() {
    getCarImagesFromApi(selectedCar.carId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Car Details"),
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Column(
      children: [
        Expanded(child: buildSlider()),
        Expanded(child: buildCardView()),
      ],
    );
  }

  buildSlider() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView(
        children: [
          CarouselSlider.builder(
            itemCount: carImages.length,
            itemBuilder: (context, index, realIdx) {
              var carImage = carImages[index];
              return Container(
                height: 1000,
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: NetworkImage(baseUrl + carImage.imagePath),
                      fit: BoxFit.cover),
                ),
              );
            },
            options: CarouselOptions(
              height: 180.0,
              enlargeCenterPage: true,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSlider2() {
    return ListView(
      children: [
        Expanded(
          child: SizedBox(
            height: 350,
            width: double.infinity,
            child: Carousel(
              dotSize: 4,
              dotSpacing: 25,
              dotColor: Colors.lightGreen,
              indicatorBgPadding: 5,
              dotBgColor: Colors.transparent,
              dotVerticalPadding: 5,
              dotPosition: DotPosition.bottomRight,
              images: [
                ListView.builder(
                    itemCount: carImages.length,
                    itemBuilder: (BuildContext context, index) {
                      return Row(
                        children: [
                          Expanded(
                            child: Image.network(
                                this.baseUrl + carImages[index].imagePath),
                          )
                        ],
                      );
                    }),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildCardView() {
    double fontSize = 20;
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (BuildContext context, index) {
        return Card(
          child: Column(
            children: [
              ListTile(
                leading: Icon(
                  Icons.branding_watermark_sharp,
                  color: Colors.blue,
                ),
                title: Text('Brand Name'),
                trailing: Text(selectedCar.brandName,
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(
                  Icons.car_repair,
                  color: Colors.blue,
                ),
                title: Text('Model Name'),
                trailing: Text(selectedCar.carName,
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(
                  Icons.card_giftcard,
                  color: Colors.blue,
                ),
                title: Text('Type'),
                trailing: Text(selectedCar.description,
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(
                  Icons.point_of_sale_sharp,
                  color: Colors.blue,
                ),
                title: Text('Model Year'),
                trailing: Text(selectedCar.modelYear.toString(),
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(
                  Icons.date_range,
                  color: Colors.blue,
                ),
                title: Text('Daily Price'),
                trailing: Text(selectedCar.dailyPrice.toString() + r" $",
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(
                  Icons.color_lens,
                  color: Colors.blue,
                ),
                title: Text('Color'),
                trailing: Text(selectedCar.colorName,
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold)),
              ),
              ListTile(
                leading: Icon(
                  Icons.point_of_sale_sharp,
                  color: Colors.blue,
                ),
                title: Text('Findex Point'),
                trailing: Text(selectedCar.carFindexPoint.toString(),
                    style: TextStyle(
                        fontSize: fontSize, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        );
      },
    );
  }

  void getCarImagesFromApi(int id) {
    CarService.getCarImagesByCarId(id).then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        print(list);
        this.carImages =
            list.map((carImage) => CarImage.fromJson(carImage)).toList();
      });
    });
  }
}
