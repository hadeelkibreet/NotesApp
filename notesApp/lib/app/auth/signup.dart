import 'package:flutter/material.dart';
import 'package:notesapp/app/auth/Login.dart';
import 'package:notesapp/app/home.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/components/valid.dart';
import 'package:notesapp/constant/linkapi.dart';

import '../../components/customtextfrom.dart';

class signUp extends StatefulWidget {
  const signUp({Key? key}) : super(key: key);

  @override
  State<signUp> createState() => _signUpState();
}

class _signUpState extends State<signUp> {
  Crud _crud = Crud();
  bool isLoading = false;
  var username = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  GlobalKey<FormState> formstate = GlobalKey();

  signUp() async {
    isLoading = true;
    setState(() {});
    var response = await _crud.postRequest(linkSignUp, {
      "userName": username.text,
      "email": email.text,
      "password": password.text,
    });
    isLoading = false;
    setState(() {});
    if (response['status'] == "success") {
      print("signUp success");
      Navigator.pushAndRemoveUntil(
          context, MaterialPageRoute(builder: (context) => const home()),
          (route) {
        return false;
      });
    } else {
      print("signUp Fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading == true
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  Form(
                    key: formstate,
                    child: Column(
                      children: [
                        Image.asset(
                          "images/loginImage.png",
                          width: 300,
                          height: 300,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        CustTextFormSign(
                          mycontroller: username,
                          text: "Username",
                          fixIcon: Icons.person,
                          valid: (val) {
                            return validInput(val!, 3, 20);
                          },
                          type: TextInputType.text,
                        ),
                        CustTextFormSign(
                          mycontroller: email,
                          text: "email",
                          fixIcon: Icons.email,
                          valid: (val) {
                            return validInput(val!, 10, 25);
                          },
                          type: TextInputType.emailAddress,
                        ),
                        CustTextFormSign(
                            mycontroller: password,
                            text: "Password",
                            fixIcon: Icons.password,
                            valid: (val) {
                              return validInput(val!, 3, 12);
                            },
                            type: TextInputType.visiblePassword),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: MaterialButton(
                            onPressed: () async {
                              if (formstate.currentState!.validate()) {
                                await signUp();
                              }
                            },
                            color: Colors.blue,
                            textColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            child: const Text("signUp"),
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: MaterialButton(
                            onPressed: () {},
                            textColor: Colors.blue,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            child: InkWell(
                              child: Text('Login'),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
