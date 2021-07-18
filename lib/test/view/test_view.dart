import 'package:flutter/material.dart';
class TestView {

  static buildDropdownMethod(String? hint,List? listItems,var text,var itemValue,var itemSelection){
    return new Center(
      child: new DropdownButton(
        hint: Text(hint!=null?hint:"Select"),
        items: listItems!.map((item) {
          return new DropdownMenuItem(
            child: new Text(text),
            value: itemValue,
          );
        }).toList(),
        onChanged: (newVal) {

          itemSelection = newVal;
          //getCarsByColorId(int.tryParse(newVal));

        },
        value: itemSelection,
      ),
    );
  }
//   Widget buildCard() {
// return Obx((){
//   return ListView.builder(
//       itemCount: carController.carDetailList.length,
//       itemBuilder: (BuildContext context, index) {
//         var car=carController.carDetailList[index];
//         return SizedBox(
//           child: Card(
//             child: Column(
//               children: [
//                 Image.network(
//                     "https://10.0.2.2:5001/" + car.imagePath!),
//
//                 buildListTile(
//                     Icon(Icons.car_rental,color: Colors.blue[500],),
//                     car.carName!,
//                     car.brandName!,
//                     TextButton(child: Text("Detail"),
//                       onPressed: () {setState(() {getCarImagesFromApi(car);});},
//                     )),
//                 buildListTile2(
//                   Icon(Icons.attach_money,color: Colors.blue[500],),
//                   car.dailyPrice!=null?car.dailyPrice!.toString()+" TL":"null",),
//                 ListTile(title:
//                 Text(car.modelYear!=null?car.modelYear!.toString():"null"),
//                   leading: Icon(Icons.date_range,color: Colors.blue,),),
//               ],
//             ),
//           ),
//         );
//       });
//
// });
//
//
//   }
}