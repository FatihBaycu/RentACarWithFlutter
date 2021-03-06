import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_http_demo2/controllers/color_controller.dart';
import 'package:flutter_http_demo2/models/color.dart';
import 'package:flutter_http_demo2/screens/color/color_update_screen.dart';
import 'package:flutter_http_demo2/services/color_service.dart';
import 'package:get/get.dart';

class ColorScreen extends StatefulWidget {
  @override
  _ColorScreenState createState() => _ColorScreenState();
}

enum Options { update }

class _ColorScreenState extends State<ColorScreen> {
  var colorName = TextEditingController();
  var colorCode = TextEditingController();

  var formKey = GlobalKey<FormState>();
  Color color = Color.required(colorName: "default", colorCode: "default");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("colors".tr)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              buildFormField(),
              buildColorList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildColorList() {
    return GetX<ColorController>(
        init: ColorController(),
        builder: (_colorController) {
          return SingleChildScrollView(
            child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.only(left: 20, right: 20),
                itemCount: _colorController.colorList.length,
                itemBuilder: (context, index) {
                  var colors = _colorController.colorList;
                  return ListTile(
                    title: Text(colors[index].colorName!),
                    trailing: buildPopupMenu(colors[index]),
                  );
                }),
          );
        });
  }

  buildFormField() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          buildColorNameField(),
          buildColorCodeField(),
          buildColorSubmitField(),
        ],
      ),
    );
  }

  buildColorNameField() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      controller: colorName,
      validator: (String? value) {
        if (value != null) {
          if (value.length < 2) {
            return "lengthGreaterThanTwo".tr;
          }
        }
      },
      decoration: InputDecoration(
        labelText: "colorName".tr,
        border: OutlineInputBorder(),
      ),
      onSaved: (String? value) {
        color.colorName = value!;
      },
    );
  }

  buildColorCodeField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: "colorCode".tr,
        border: OutlineInputBorder(),
      ),
      controller: colorCode,
      autovalidateMode: AutovalidateMode.always,
      validator: (String? value) {
        if (value != null) {
          if (value.length < 2) {
            return "lengthGreaterThanTwo".tr;
          }
        }
      },
      onSaved: (String? value) {
        color.colorCode = value!;
      },
    );
  }

  generateResponse(dynamic param) {
    return jsonDecode(param);
  }

  clearFilelds() {
    colorName.text = "";
    colorCode.text = "";
  }

  buildColorSubmitField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        child: Text("add".tr),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            ColorService().colorAdd(this.color).then((response) {
              ColorController().getAll().then((value) => Get.toNamed("/car-list"));
              clearFilelds();
            });
          }
        },
      ),
    );
  }

  buildPopupMenu(Color color) {
    return PopupMenuButton<Options>(
        onSelected: (value) => selectProcess(value, color),
        itemBuilder: (BuildContext context) => <PopupMenuEntry<Options>>[
              PopupMenuItem<Options>(
                child: Text("update".tr),
                value: Options.update,
              ),
            ]);
  }

  selectProcess(Options options, Color color) async {
    switch (options) {
      case Options.update:
        Get.to(() => ColorUpdateScreen(color));
        break;
      default:
    }
  }
}
