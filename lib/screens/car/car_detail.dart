import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/carDetails.dart';
import 'package:flutter_http_demo2/models/carImage.dart';
import 'package:flutter_http_demo2/screens/car/car_update_screen.dart';

// ignore: must_be_immutable
class CarDetailScreen extends StatefulWidget {
  CarDetails? selectedCar;
  List<CarImage>? carImages;

  CarDetailScreen(this.selectedCar, this.carImages);

  @override
  _CarDetailScreenState createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {
  //var carImages = <CarImage>[];
  var baseUrl = "https://10.0.2.2:5001/";
  @override
  void initState() {
    //getCarImagesFromApi(widget.selectedCar.carId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Car Details"), ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Column(
      children: [
        Expanded(flex: 2,child: buildSlider()),
        Expanded(flex: 3,child: buildCardView()),
      ],
    );
  }

   buildSlider() {
     return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView(
        children: [
          buildCarouselSlider(),
        ],
      ),
    );
  }

   CarouselSlider buildCarouselSlider() {
     return CarouselSlider.builder(
          itemCount: widget.carImages!.length,
          itemBuilder: (context, index, realIdx) {
            var carImage = widget.carImages![index];
            return
              Container(
              margin: EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                    image: NetworkImage(baseUrl + carImage.imagePath!),
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
        );
   }

 Widget buildListTile(Icon leadingIcon, String title, String tralling, double fontSize){
    return ListTile(
      leading: leadingIcon,
      title: Text(title),
      trailing: Text(tralling,style:TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
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
              GestureDetector(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>CarUpdateScreen(widget.selectedCar!)));}
                  ,child: buildListTile(Icon(Icons.update,color: Colors.blue,),"Update", "Go",fontSize)),
              buildListTile(Icon(Icons.car_repair,color: Colors.blue,),"Model Name", widget.selectedCar!.carName!,fontSize),
              buildListTile(Icon(Icons.card_giftcard,color: Colors.blue,),"Model Name", widget.selectedCar!.description!,fontSize),
              buildListTile(Icon(Icons.point_of_sale_sharp,color: Colors.blue,),"Model Year", widget.selectedCar!.modelYear!.toString(),fontSize),
              buildListTile(Icon(Icons.date_range,color: Colors.blue,),"Daily Price", widget.selectedCar!.dailyPrice!.toString() + r" $",fontSize),
              buildListTile(Icon(Icons.color_lens,color: Colors.blue,),"Color Name", widget.selectedCar!.colorName!,fontSize),
              buildListTile(Icon(Icons.point_of_sale_sharp,color: Colors.blue,),"Findex Point", widget.selectedCar!.carFindexPoint!.toString(),fontSize),
            ],
          ),
        );
      },
    );
  }

}
