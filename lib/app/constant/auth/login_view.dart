import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:notephp/app/constant/linkapo.dart';
import 'package:notephp/main.dart';

import '../../crud.dart';
import '../../components/customtextform.dart';
import '../../components/valid.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  GlobalKey<FormState> formState = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Curd curd = Curd();
  bool isLoading = false;
  login() async {
    if (formState.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await curd.postRequset(linklogin, {
        "email": email.text,
        "password": password.text,
      });
      isLoading = false;
      setState(() {});
      if (response['status'] == "sccuess") {
        sharedPre.setString("id", response['data']['id'].toString());
        sharedPre.setString("username", response['data']['username']);
        sharedPre.setString("email", response['data']['email']);

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushNamedAndRemoveUntil("home", (route) => false);
      } else {
        AwesomeDialog(
          context: context,
          title: "Warning",
          body: const Text(
            "Not found account OR Password is wrong OR Email is wrong",
          ),
        ).show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : ListView(
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
                            return validInput(val!, 2, 20);
                          },
                          hint: "email",
                          mycontroller: email,
                        ),
                        CustomTextFormSign(
                          valid: (val) {
                            return validInput(val!, 2, 20);
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
                            await login();
                          },
                          child: const Text("Login"),
                        ),
                        Container(
                          height: 10,
                        ),
                        InkWell(
                          child: const Text("sign UP"),
                          onTap: () {
                            Navigator.of(context).pushNamed("signup");
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
