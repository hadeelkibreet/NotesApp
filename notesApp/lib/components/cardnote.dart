import 'package:flutter/material.dart';
import 'package:notesapp/constant/linkapi.dart';

import '../model/notesModel.dart';

class CardNotes extends StatelessWidget {
  const CardNotes({
    super.key,
    required this.ontap,
    required this.onDelete,
    required this.notesModel,
  });

  final void Function()? ontap;
  final NotesModel notesModel;
  final void Function()? onDelete;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.network(
                  "$linkImageRoot/${notesModel.image}",
                  width: 100,
                  height: 100,
                  fit: BoxFit.fill,
                )),
            Expanded(
                flex: 2,
                child: ListTile(
                  title: Text(notesModel.notesTitle.toString()),
                  subtitle: Text(notesModel.notesContent.toString()),
                )),
            IconButton(onPressed: onDelete, icon: Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }
}
