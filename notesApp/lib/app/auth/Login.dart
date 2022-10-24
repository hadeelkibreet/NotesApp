import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:notesapp/app/auth/signup.dart';
import 'package:notesapp/app/home.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../components/customtextfrom.dart';
import '../../components/valid.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var email = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();
  var curd = Crud();
  bool isLoading = false;

  login() async {
    if (formKey.currentState!.validate()) {
      isLoading = true;
      setState(() {});
      var respons = await curd.postRequest(
          linkLogin, {"email": email.text, "password": password.text});
      isLoading = false;
      setState(() {});
      if (respons['status'] == "success") {

        sharedPref.setString("id", respons['data']['id'].toString());
        sharedPref.setString("userName", respons['data']['userName']);
        sharedPref.setString("email", respons['data']['email'].toString());

        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context, MaterialPageRoute(builder: (context) => const home()),
            (route) {
          return false;
        });
      } else {
        AwesomeDialog(
                context: context,
                title: "تنبيه",
                body: const Text(
                    "البريد الإلكتروني او كلمة السر خطأ او ان الحساب غير موجود"))
            .show();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading == true
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  Form(
                    key: formKey,
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
                          mycontroller: email,
                          text: "email",
                          fixIcon: Icons.email,
                          valid: (val) {
                            return validInput(val!, 11, 25);
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
                              await login();
                            },
                            color: Colors.blue,
                            textColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 70, vertical: 10),
                            child: const Text("Login"),
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
                              child: const Text("Sign Up"),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const signUp()));
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
