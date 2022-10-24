import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notesapp/app/Notes/edit.dart';
import 'package:notesapp/app/auth/Login.dart';
import 'package:notesapp/components/cardnote.dart';
import 'package:notesapp/components/crud.dart';
import 'package:notesapp/constant/linkapi.dart';
import 'package:notesapp/main.dart';
import 'package:notesapp/model/notesModel.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> with Crud {
  getNotes() async {
    var response =
        await postRequest(linkViewNotes, {"id": sharedPref.getString("id")});
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HOME"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                sharedPref.clear();
                // ignore: use_build_context_synchronously
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) {
                  return false;
                });
              },
              icon: const Icon(Icons.exit_to_app))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("addnotes");
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            FutureBuilder(
                future: getNotes(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data['status'] == 'fail') {
                      return const Center(
                          child: Text(
                        'you don\'t have a notes ',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ));
                    }
                    return ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, i) {
                          return CardNotes(
                            ontap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => EditNotes(
                                        note: snapshot.data['data'][i],
                                      )));
                            },
                            notesModel: NotesModel.fromJson(snapshot.data['data'][i])  ,
                            onDelete: () async {
                              var response = await postRequest(
                                  linkDeleteNotes, {
                                "id": snapshot.data['data'][i]['notes_id'].toString(),
                                "imgname" : snapshot.data['data'][i]['image'].toString()
                              });
                              if (response['status'] == "success") {
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const home()),
                                    (route) {
                                  return false;
                                });
                              }
                            },
                          );
                        });
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Text("Loading... "),
                    );
                  }
                  return const Center(
                    child: Text("Loading... "),
                  );
                })
          ],
        ),
      ),
    );
  }
}
