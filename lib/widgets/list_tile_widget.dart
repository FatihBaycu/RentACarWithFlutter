import 'package:flutter/material.dart';

class ListTileWidget{
  Widget buildListTile(Icon leadingIcon, String title, String tralling, double fontSize){
    return ListTile(
      leading: leadingIcon,
      title: Text(title),
      trailing: Text(tralling,style:TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold)),
    );
  }
}