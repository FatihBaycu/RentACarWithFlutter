import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/brand_controller.dart';
import 'package:get/get.dart';

class BrandTestView extends StatelessWidget {

  final BrandController brandController=Get.put(BrandController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AppString.productList"),
      ),
      body: Obx((){
        if(brandController.isLoading.value)
              return Center(child: CircularProgressIndicator(),);
        else
              return ListView.builder(
              itemCount: brandController.brandList.length,
              itemBuilder: (context,int index){
                return Column(
                  children: [
                    Text(brandController.brandList[index].brandName!,)
                  ],
                );
              }
          );

      }),
    );
  }
}
