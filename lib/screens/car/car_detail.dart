import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/car_controller.dart';
import 'package:flutter_http_demo2/controllers/rental_controller.dart';
import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:flutter_http_demo2/models/carDetails.dart';
import 'package:flutter_http_demo2/models/carImage.dart';
import 'package:flutter_http_demo2/screens/car/car_update_screen.dart';
import 'package:flutter_http_demo2/screens/rental/car_rental_screen.dart';
import 'package:flutter_http_demo2/widgets/list_tile_widget.dart';
import 'package:get/get.dart';


// ignore: must_be_immutable
class CarDetailScreen extends StatefulWidget {
  CarDetails? selectedCar;
  List<CarImage>? carImages;

  CarDetailScreen(this.selectedCar, this.carImages);

  @override
  _CarDetailScreenState createState() => _CarDetailScreenState();
}

class _CarDetailScreenState extends State<CarDetailScreen> {

  CarController carController=Get.put(CarController());
  RentalController rentalController=Get.put(RentalController());
  var baseUrl = GlobalVariables.apiUrlBase;

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
        children: [buildCarouselSlider(),],
      ),
    );
  }


   Widget buildCarouselSlider() {
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
              ListTile(leading:Icon(Icons.update,color: Colors.orange,),title:Text("Update"), trailing: Icon(Icons.navigate_next,color: Colors.orangeAccent,),onTap: (){Get.to(()=>CarUpdateScreen(widget.selectedCar!));}),
              ListTile(leading:Icon(Icons.car_rental,color: Colors.red,),title:Text("Rent"), trailing: Icon(Icons.navigate_next,color: Colors.red,),onTap: (){

                rentalController.rental().carId=widget.selectedCar!.carId;
                carController.carDetail(widget.selectedCar);
                Get.to(()=>CarRentalScreen());

              }),
              buildListTile(Icon(Icons.car_repair,color: Colors.blue,),"Model Name",widget.selectedCar!.carName! ,fontSize),
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

