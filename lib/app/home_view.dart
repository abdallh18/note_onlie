import 'package:flutter/material.dart';
import 'package:notephp/app/components/cardnote.dart';
import 'package:notephp/app/crud.dart';
import 'package:notephp/app/constant/linkapo.dart';
import 'package:notephp/app/notes/edit.dart';
import 'package:notephp/main.dart';
import 'package:notephp/model/notemodel.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with Curd {
  getNotes() async {
    var respones =
        await postRequset(linkViewNotes, {"id": sharedPre.getString("id")});
    return respones;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: [
          IconButton(
              onPressed: () {
                sharedPre.clear();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil("login", (route) => false);
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
      body: Container(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            FutureBuilder(
              future: getNotes(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data['status'] == 'fail') {
                    return const Center(
                        child: Text(
                      "not Found Notes",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ));
                  }
                  return ListView.builder(
                      itemCount: snapshot.data['data'].length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CardNote(
                          onDelete: () async {
                            // ignore: unused_local_variable
                            var response = await postRequset(linkDeleteNote, {
                              "id": snapshot.data['data'][index]['notes_id']
                                  .toString(),
                              "imagename": snapshot.data['data'][index]
                                      ['notes_image']
                                  .toString(),
                            });
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushReplacementNamed("home");
                          },
                          ontap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  EditNote(notes: snapshot.data['data'][index]),
                            ));
                          },
                          noteModel:
                              NoteModel.fromJson(snapshot.data['data'][index]),
                        );
                      });
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: Text("Loading ...."),
                  );
                }
                return const Center(
                  child: Text("Loading ...."),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
