import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/brand_controller.dart';
import 'package:flutter_http_demo2/controllers/car_controller.dart';
import 'package:flutter_http_demo2/controllers/color_controller.dart';
import 'package:flutter_http_demo2/globalVariables.dart';
import 'package:flutter_http_demo2/models/carDetails.dart';
import 'package:flutter_http_demo2/screens/car/car_detail.dart';
import 'package:flutter_http_demo2/widgets/DrawerWidget.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class CarListScreen extends StatefulWidget {
  @override
  _CarListScreenState createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  BrandController brandController = Get.put(BrandController(), permanent: true);
  ColorController colorController = Get.put(ColorController(), permanent: true);
  CarController carController = Get.put(CarController());

  var _myBrandSelection;
  var _myColorSelection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: buildFloatingActionButton(context),
      appBar: AppBar(title: Text("carList".tr),
    
      ),
      body: LayoutBuilder(
          builder:(BuildContext context,BoxConstraints boxCons){
        if(boxCons.maxWidth<600)
       return  buildBody();
        else
          return buildBodyForTablet();
      } ),
      drawer: DrawerWidget(),
    );
  }

  FloatingActionButton buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton.extended(
      backgroundColor: Colors.black,
      onPressed: () => Get.toNamed("/car-add"),
      icon: Icon(
        Icons.add,
        color: Colors.white,
      ),
      label: Text(
        "addCar".tr,
        style: TextStyle(color: Colors.white),
      ),
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
                Expanded(flex: 1, child: buildSelectFilterButton()),
                Expanded(flex: 1, child: buildClearFilterButton()),
              ],
            )),

        Expanded(child: buildCard()),
        // Expanded(child: buildCard()),
      ],
    );
  }


  Widget buildBodyForTablet() {
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

        Expanded(child: buildCardForTablet()),
        // Expanded(child: buildCard()),
      ],
    );
  }

  buildColorsDropdownList() {
    return Center(
      child: DropdownButton(
        hint: Text("colors".tr),
        items: colorController.colorList.map((item) {
          return DropdownMenuItem(
            child: Text(item.colorName!),
            value: item.colorId.toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            _myColorSelection = newVal;
          });
        },
        value: _myColorSelection,
      ),
    );
  }

  buildBrandsDropdownList() {
    return Center(
      child: DropdownButton(
        hint: Text("brands".tr),
        items: brandController.brandList.map((item) {
          return DropdownMenuItem(
            child: Text(item.brandName!),
            value: item.brandId.toString(),
          );
        }).toList(),
        onChanged: (newVal) {
          setState(() {
            _myBrandSelection = newVal;
          });
        },
        value: _myBrandSelection,
      ),
    );
  }

  Widget buildCard() {
    return GetBuilder<CarController>(builder: (controller) {
      return Obx(() {
        if (carController.isLoading.value)
           return Center(child: CircularProgressIndicator());
        else
          return ListView.builder(
              itemCount: controller.carDetailList.length,
              itemBuilder: (BuildContext context, index) {
                var car = controller.carDetailList[index];

                return SizedBox(
                  child: Card(
                    child: Column(
                      children: [
                        car.imagePath != null
                            ? Image.network(
                                GlobalVariables.apiUrlBase + car.imagePath!)
                            :  Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.white,
                          child:
                          Expanded(child: CircularProgressIndicator()), //Your custom layout comes here...
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.car_rental,
                            color: Colors.blue[500],
                          ),
                          title: Text(car.carName!),
                          subtitle: Text(car.brandName!),
                          trailing: TextButton(
                            child: Text("detail".tr),
                            onPressed: () => getCarImagesFromApi(car),
                          ),
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.attach_money,
                            color: Colors.blue[500],
                          ),
                          title: Text("${car.dailyPrice} \$"),
                        ),
                        ListTile(
                          title: Text(car.modelYear!.toString()),
                          leading: Icon(
                            Icons.date_range,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
      });
    });
  }

  Widget buildCardForTablet() {
    return GetBuilder<CarController>(builder: (controller) {
      return Obx(() {
        if (carController.isLoading.value)
           return Center(child: CircularProgressIndicator());
        else
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 500,
              childAspectRatio: 3/2,
              crossAxisSpacing: 20,
              mainAxisSpacing:20
            ),
              itemCount: controller.carDetailList.length,
              itemBuilder: (BuildContext context, index) {
                var car = controller.carDetailList[index];
                return SizedBox(
                  child: Card(
                    child: Column(
                      children: [
                        car.imagePath != null
                            ? Expanded(
                              child: GestureDetector(
                                onTap: ()=>getCarImagesFromApi(car),
                                child: Image.network(
                                    GlobalVariables.apiUrlBase + car.imagePath!),
                              ),
                            )
                            :  Shimmer.fromColors(
                          baseColor: Colors.grey[300]!,
                          highlightColor: Colors.white,
                          child:
                          Expanded(child: CircularProgressIndicator()), //Your custom layout comes here...
                        ),
                        ListTile(
                          leading: Icon(
                            Icons.car_rental,
                            color: Colors.blue[500],
                          ),
                          title: Text(car.carName!),
                            onTap: ()=>getCarImagesFromApi(car),
                          subtitle: Text(car.brandName!),
                          trailing: Text("${car.dailyPrice} \$"),
                        ),
                        // ListTile(
                        //   leading: Icon(
                        //     Icons.attach_money,
                        //     color: Colors.blue[500],
                        //   ),
                        //   title: Text("${car.dailyPrice} \$"),
                        // ),
                        // ListTile(
                        //   title: Text(car.modelYear!.toString()),
                        //   leading: Icon(
                        //     Icons.date_range,
                        //     color: Colors.blue,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                );
              });
      });
    });
  }

  Future<void> getCarImagesFromApi(CarDetails carDetails) async {
    await carController.getCarImagesByCarId(carDetails.carId!);
    Get.to(() => CarDetailScreen(carDetails, carController.carImageList));
  }

  buildSelectFilterButton() {
    return IconButton(
      icon: Icon(Icons.search_sharp, color: Colors.blue),
      onPressed: () {
        setState(() {
          if (_myBrandSelection != null && _myColorSelection != null) {
            carController.getAllCarDetailsByBrandAndColorId(
                int.parse(this._myBrandSelection),
                int.parse(this._myColorSelection));
          } else if (_myBrandSelection != null && _myColorSelection == null) {
            carController
                .getAllCarDetailsByBrandId(int.parse(this._myBrandSelection));
          } else if (this._myColorSelection != null) {
            carController
                .getAllCarDetailsByColorId(int.parse(this._myColorSelection));
          } else {}
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
          carController.getAllCarDetails();
        });
      },
    );
  }
}
