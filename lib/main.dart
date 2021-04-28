import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/models/car.dart';
import 'package:flutter_http_demo2/models/carDetails.dart';
import 'package:flutter_http_demo2/models/user.dart';
import 'package:flutter_http_demo2/services/car_service.dart';


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
runApp(ApiDemo());}

//void main() => runApp(ApiDemo());

class ApiDemo extends StatefulWidget {
  @override
  _ApiDemoState createState() => _ApiDemoState();
}

class _ApiDemoState extends State<ApiDemo> {
  
  var users = <User>[];
  var cars=<Car>[];
  var carDetails=<CarDetails>[];
  var userWidget = <Widget>[];

  @override
  void initState() {
    //getUsersFromApi();
    //getCarsFromApi();
    getCarDetailsFromApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(title: Text("Rent a Car Flutter")), body: buildCard(),));
  }

  // buildListWidget() {
  //   return ListView.builder(
  //       itemCount: users.length,
  //       itemBuilder: (BuildContext context, index) {
  //         return ListTile(
  //           title: Text(users[index].firstName),
  //         );
  //       });
  // }

  // void getUsersFromApi() {
  //   UserService.getAllUsers().then((response) {
  //     setState(() {
  //       Iterable list = json.decode(response.body);
  //       print(list);
  //       this.users = list.map((user) => User.fromJson(user)).toList();
  //     });
  //   });
  // }

  Widget buildCarListWidget() {
    return ListView.builder(
        itemCount: cars.length,
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            title: Text(cars[index].carName),
          );
        });
  }

  void getCarsFromApi() {
    CarService.getAll().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        //print(response.body);
        this.cars = list.map((car) => Car.fromJson(car)).toList();
      });
    });
  }

      Widget buildCarDetailsListWidget() {
    return ListView.builder(
        itemCount: carDetails.length,
        itemBuilder: (BuildContext context, index) {
          return ListTile(
            title:    Text(carDetails[index].description),
            subtitle: Text(carDetails[index].carName),
            leading:  Text("car"),
            trailing:  Text(carDetails[index].colorName),
          );
        });
  }

  void getCarDetailsFromApi() {
    CarService.getCarDetails().then((response) {
      setState(() {
        Iterable list = json.decode(response.body)['data'];
        print(response.body);
        this.carDetails = list.map((carDetail) => CarDetails.fromJson(carDetail)).toList();
      });
    });
  }


Widget buildCard(){
 
  return ListView.builder(
    itemCount: carDetails.length,
    itemBuilder: (BuildContext context,index){
        return SizedBox(
    child: Card(
      child: Column(
        children: [
          Image.network(
            "https://www.ford.com.tr/getmedia/fa7efa78-8944-4ce6-8e35-ae765b27663a/yeni-ford-mondeo.png?width=295"
              ,width:250
              ,height: 250,
              ),
          ListTile(
            title: Text(carDetails[index].carName, style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text(carDetails[index].brandName),
            leading: Icon(Icons.car_rental,color: Colors.blue[500],),
          ),
          ListTile(
            title: Text(carDetails[index].dailyPrice.toString(),style: TextStyle(fontWeight: FontWeight.w500)),
            leading: Icon(Icons.attach_money,color: Colors.blue[500],),
          ),
          ListTile(
            title: Text(carDetails[index].modelYear.toString()),
            leading: Icon(Icons.date_range,color: Colors.blue[500],),
            trailing: TextButton(child: Text("Kirala"),onPressed: (){debugPrint(carDetails[index].carName+" Kiralandı.");},
          ),
          ),
        ],
      ),
    ),
        );

        
      
    });
  
}
buildCardView(){
  return GridView.count(
  primary: false,
  padding: const EdgeInsets.all(10),
  crossAxisSpacing: 5,
  mainAxisSpacing: 5,
  crossAxisCount: 2,
  children: <Widget>[


      ListView.builder(
        itemCount: carDetails.length,
        itemBuilder: (BuildContext context,index){
          return Card(
            
            child: Text(carDetails[index].carName),
            
          );
        })

  ],
);
}
}
