import 'dart:convert';
import 'dart:io';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/car.dart';
import 'package:flutter_http_demo2/models/carDetails.dart';
import 'package:flutter_http_demo2/models/user.dart';
import 'package:flutter_http_demo2/models/color.dart';
import 'package:flutter_http_demo2/screens/car_detail.dart';
import 'package:flutter_http_demo2/services/car_service.dart';
import 'package:flutter_http_demo2/services/color_service.dart';
import 'package:carousel_slider/carousel_slider.dart';


class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(ApiDemo());
}

//void main() => runApp(ApiDemo());

class ApiDemo extends StatefulWidget {
  @override
  _ApiDemoState createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {
  var users = <User>[];
  var cars = <Car>[];
  var carDetails = <CarDetails>[];
  var userWidget = <Widget>[];
  var colors = <Color>[];




  @override
  void initState() {
    //getColorsFromApi();
    getCarDetailsFromApi();
    super.initState();
  }

      @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: Text("Rent a Car Flutter")),
          body: buildBody(),
        ));
  }

  Widget buildBody() {
    return buildCard();
  }


  //     Widget buildCarDetailsListWidget() {
  //   return ListView.builder(
  //       itemCount: carDetails.length,
  //       itemBuilder: (BuildContext context, index) {
  //         return ListTile(
  //           title:    Text(carDetails[index].description),
  //           subtitle: Text(carDetails[index].carName),
  //           leading:  Text("car"),
  //           trailing:  Text(carDetails[index].colorName),
  //         );
  //       });
  // }

  void getCarDetailsFromApi() {
    CarService.getCarDetails().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        print(list);
        this.carDetails =
            list.map((carDetail) => CarDetails.fromJson(carDetail)).toList();
      });
    });
  }

  void getColorsFromApi() {
    ColorService.getAll().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)["data"];
        print(list);
        this.colors = list.map((color) => Color.fromJson(color)).toList();
        });
    });
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
                      "https://10.0.2.2:5001/" + carDetails[index].imagePath),
                  ListTile(
                    title: Text(carDetails[index].carName,
                        style: TextStyle(fontWeight: FontWeight.w500)),
                    subtitle: Text(carDetails[index].brandName),
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
                    leading: Icon(Icons.date_range, color:Colors.blue,),
                    trailing: TextButton(
                      child: Text("Detay"),
                      onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) 
                        =>CarDetailScreen(carDetails[index])),).then((value)  =>setState((){}));

                      },
                    )
                  )
                   ,
                ],
              ),
            ),
          );
        });
  }


// buildCardView(){
//   return GridView.count(
//   primary: false,
//   padding: const EdgeInsets.all(10),
//   crossAxisSpacing: 5,
//   mainAxisSpacing: 5,
//   crossAxisCount: 2,
//   children: <Widget>[

//       ListView.builder(
//         itemCount: carDetails.length,
//         itemBuilder: (BuildContext context,index){
//           return Card(
//           child: Text(carDetails[index].carName),
//           );
//         })

//   ],
// );
// }
//
}