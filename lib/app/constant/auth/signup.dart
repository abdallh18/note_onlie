import 'package:flutter/material.dart';
import 'package:notephp/app/crud.dart';
import 'package:notephp/app/components/valid.dart';
import 'package:notephp/app/constant/linkapo.dart';

import '../../components/customtextform.dart';

class singupView extends StatefulWidget {
  const singupView({super.key});

  @override
  State<singupView> createState() => _singupViewState();
}

class _singupViewState extends State<singupView> {
  GlobalKey<FormState> formState = GlobalKey();
  Curd _crud = Curd();
  bool isLoding = false;
  TextEditingController email = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  singUp() async {
    if (formState.currentState!.validate()) {
      isLoding = true;
      setState(() {});
      var response = await _crud.postRequset(linkSignUp, {
        "username": username.text,
        "email": email.text,
        "password": password.text,
      });
      isLoding = false;
      setState(() {});
      if (response['status'] == "sccuess") {
        Navigator.of(context)
            .pushNamedAndRemoveUntil("success", (route) => false);
      }
      {
        print("SignUp fail");
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoding == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: ListView(
                children: [
                  Form(
                    key: formState,
                    child: Column(
                      children: [
                        Image.asset(
                          "images/lohonote.jpg",
                          width: 200,
                          height: 200,
                        ),
                        CustomTextFormSign(
                          valid: (val) {
                            return validInput(val!, 5, 40);
                          },
                          hint: "email",
                          mycontroller: email,
                        ),
                        CustomTextFormSign(
                          valid: (val) {
                            return validInput(val!, 5, 40);
                          },
                          hint: "username",
                          mycontroller: username,
                        ),
                        CustomTextFormSign(
                          valid: (val) {
                            return validInput(val!, 3, 20);
                          },
                          hint: "password",
                          mycontroller: password,
                        ),
                        MaterialButton(
                          color: Colors.blue[400],
                          textColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 70),
                          onPressed: () async {
                            await singUp();
                          },
                          child: const Text("sign UP"),
                        ),
                        Container(
                          height: 10,
                        ),
                        InkWell(
                          child: const Text("Login"),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
