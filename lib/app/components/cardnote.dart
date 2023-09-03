import 'package:flutter/material.dart';
import 'package:notephp/app/constant/linkapo.dart';
import 'package:notephp/model/notemodel.dart';

class CardNote extends StatelessWidget {
  const CardNote(
      {super.key,
      required this.ontap,
      required this.noteModel,
      required this.onDelete});
  final void Function() ontap;
  final NoteModel noteModel;
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
                "$linkImageRoot/${noteModel.notesImage}",
                width: 100,
                height: 100,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              flex: 2,
              child: ListTile(
                title: Text("${noteModel.notesTitle}"),
                subtitle: Text("${noteModel.notesContent}"),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: onDelete,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
