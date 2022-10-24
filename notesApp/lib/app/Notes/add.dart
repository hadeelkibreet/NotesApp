import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/components/customtextfrom.dart';
import 'package:notesapp/components/valid.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';

import '../home.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  State<AddNotes> createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> with Crud {
  File? myfile;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  TextEditingController title = TextEditingController();
  TextEditingController content = TextEditingController();

  bool isLoading = false;
  AddNotes() async {
    if (myfile == null) {
      return AwesomeDialog(
          context: context, title: "هام", body: Text("الرجاء اضافة صورة"))
        ..show();
    }
    if (formkey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var response = await postRequestWithFile(
          linkAddNotes,
          {
            "title": title.text,
            "content": content.text,
            "id": sharedPref.getString("id")
          },
          myfile!);
      isLoading = false;
      setState(() {});
      if (response['status'] == "success") {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => const home()),
            (route) {
          return false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("add"), centerTitle: true),
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              padding: const EdgeInsets.all(10),
              child: Form(
                key: formkey,
                child: ListView(
                  children: [
                    CustTextFormSign(
                        text: "title",
                        fixIcon: Icons.title,
                        valid: (val) {
                          return validInput(val!, 1, 20);
                        },
                        type: TextInputType.text,
                        mycontroller: title),
                    CustTextFormSign(
                        text: "content",
                        fixIcon: Icons.text_rotation_none_sharp,
                        valid: (val) {
                          return validInput(val!, 1, 50);
                        },
                        type: TextInputType.text,
                        mycontroller: content),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: MaterialButton(
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => Container(
                                    height: 100,
                                    child: Column(
                                      children: [
                                        InkWell(
                                          onTap: () async {
                                            XFile? xfile = await ImagePicker()
                                                .pickImage(
                                                    source:
                                                        ImageSource.gallery);
                                            Navigator.of(context).pop;

                                            myfile = File(xfile!.path);
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              "choose Image From Gallery",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () async {
                                            XFile? xfile = await ImagePicker()
                                                .pickImage(
                                                    source: ImageSource.camera);
                                            Navigator.of(context).pop();
                                            myfile = File(xfile!.path);
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: double.infinity,
                                            padding: EdgeInsets.all(10),
                                            child: Text(
                                              "choose Image From Camera",
                                              style: TextStyle(
                                                fontSize: 20,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                        },
                        color: myfile == null ? Colors.blue : Colors.green,
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 10),
                        child: const Text("Choose image"),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: MaterialButton(
                        onPressed: () async {
                          await AddNotes();
                        },
                        color: Colors.blue,
                        textColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 70, vertical: 10),
                        child: const Text("Add"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
