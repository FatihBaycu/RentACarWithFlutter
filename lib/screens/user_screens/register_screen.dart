import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_http_demo2/models/users/user_for_register.dart';
import 'package:flutter_http_demo2/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var companyName = TextEditingController();
  var formKey = GlobalKey<FormState>();

  UserForRegister userForRegister = new UserForRegister.withEmpty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("register".tr),
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
          child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Wrap(
            runSpacing: 20,
            children: [
              buildTextFormField(firstName, "firstName".tr),
              buildTextFormField(lastName,  "lastName".tr),
              buildTextFormField(email, "email".tr),
              buildTextFormField(password, "password".tr, obsureText: true),
              buildTextFormField(companyName, "companyName".tr),
              Center(
                  child: ElevatedButton(
                child: Text("register".tr),
                onPressed: () {
                  userForRegister.firstName = firstName.text;
                  userForRegister.lastName = lastName.text;
                  userForRegister.email = email.text;
                  userForRegister.password = password.text;
                  userForRegister.companyName = companyName.text;

                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    AuthService.register(userForRegister);
                  }
                },
              )),
            ],
          ),
        ),
      )),
    );
  }

  Widget buildTextFormField(TextEditingController controller, String labelText,
      {bool? obsureText}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.white)),
      validator: (val) => val!.isEmpty ? "cannotBeEmpty".tr : null,
      obscureText: obsureText == null ? false : true,
     autovalidateMode: AutovalidateMode.always,
    );
  }
}
