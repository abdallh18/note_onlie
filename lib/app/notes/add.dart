import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notephp/app/components/customtextform.dart';
import 'package:notephp/app/components/valid.dart';
import 'package:notephp/app/constant/linkapo.dart';
import 'package:notephp/app/crud.dart';
import 'package:notephp/main.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> with Curd {
  File? myFile;
  GlobalKey<FormState> fromstate = GlobalKey<FormState>();
  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();
  bool isLoading = false;
  addNotes() async {
    if (myFile == null) {
      return AwesomeDialog(
        context: context,
        title: "importent",
        body: const Text("pleas Add image in Note"),
      ).show();
    }
    if (fromstate.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      // ignore: unused_local_variable
      var respones = await posrRequestwithFile(
          linkAddNotes,
          {
            "title": title.text,
            "content": content.text,
            "id": sharedPre.getString("id"),
          },
          myFile!);
      isLoading = false;
      setState(() {});
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacementNamed("home");
      // if (respones['status'] == "success") {
      //   // ignore: use_build_context_synchronously
      //   Navigator.of(context).pushReplacementNamed("home");
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Note"),
      ),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: fromstate,
                child: ListView(
                  children: [
                    CustomTextFormSign(
                        hint: "title",
                        mycontroller: title,
                        valid: (val) {
                          return validInput(val!, 1, 40);
                        }),
                    CustomTextFormSign(
                        hint: "content",
                        mycontroller: content,
                        valid: (val) {
                          return validInput(val!, 10, 255);
                        }),
                    Container(height: 20),
                    MaterialButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SizedBox(
                            height: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    "Please Choose Image",
                                    style: TextStyle(fontSize: 22),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    XFile? xfile = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    Navigator.of(context).pop();
                                    myFile = File(xfile!.path);
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      "From Gallery",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    XFile? xfile = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    Navigator.of(context).pop();
                                    myFile = File(xfile!.path);
                                    setState(() {});
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    padding: const EdgeInsets.all(10),
                                    child: const Text(
                                      "From Camera",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      textColor: Colors.white,
                      color: myFile == null ? Colors.blue : Colors.green,
                      child: const Text("Choose Image"),
                    ),
                    Container(height: 20),
                    MaterialButton(
                      onPressed: () async {
                        await addNotes();
                      },
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: const Text("Add"),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
