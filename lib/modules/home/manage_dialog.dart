import 'package:flutter/material.dart';
import '../../models/database.dart';
import '../../models/word_search_model.dart';
import '../../models/word_modify_model.dart';
import '../../component/notify_dialog.dart';
import '../../component/text_button_app.dart';

class ManageDialog extends StatefulWidget {
  const ManageDialog({Key? key}) : super(key: key);

  @override
  _ManageDialogState createState() => _ManageDialogState();
}

class _ManageDialogState extends State<ManageDialog> {
  final Database database = Database();
  final WordSearchModel wordSearch = WordSearchModel();
  WordModifyModel wordModify = WordModifyModel();
  List<TextEditingController> key = [];
  List<TextEditingController> mean = [];
  TextEditingController note = TextEditingController();

  Future<bool> changeGroup() async {
    List<String> addKey = key.map((controller) => controller.text).where((text) => text.isNotEmpty).toList();
    List<String> addMean = mean.map((controller) => controller.text).where((text) => text.isNotEmpty).toList();
    String addNote = note.text;

    if(addKey.isEmpty || addMean.isEmpty) {
      return false;
    }

    for(var item in addKey) {
      if(item.contains(',')) {
        return false;
      }
    }
    for(var item in addMean) {
      if(item.contains(',')) {
        return false;
      }
    }

    if(wordModify.type == ModifyType.add) {
      await database.addGroup(addKey, addMean, addNote);
    } else {
      wordSearch.modify(addKey, addMean, addNote, wordModify.index);
      await database.modifyGroup(addKey, addMean, addNote, wordModify.query, wordModify.isEng, wordModify.index);
    }

    return true;
  }

  @override
  void initState() {
    super.initState();
    int count = (wordModify.keys.length > 4 ? wordModify.keys.length : 4);
    for (int i = 0; i < count; i++) {
      key.add(TextEditingController());
      if(i < wordModify.keys.length) {
        key[i].text = wordModify.keys[i];
      }
    }

    count = (wordModify.means.length > 4 ? wordModify.means.length : 4);
    for (int i = 0; i < count; i++) {
      mean.add(TextEditingController());
      if(i < wordModify.means.length) {
        mean[i].text = wordModify.means[i];
      }
    }

    note.text = wordModify.note;
  }

  @override
  void dispose() {
    for (var controller in key) {
      controller.dispose();
    }
    for (var controller in mean) {
      controller.dispose();
    }
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Column(
          children: [
            Expanded(child: ListView( children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Key',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.playlist_add),
                    onPressed:(){
                      setState((){
                        key.add(TextEditingController());
                      });
                    },
                  ),
                ]
              ),

              for (int i = 0; i < key.length; i++)
                TextField(
                  controller: key[i],
                  decoration: InputDecoration(hintText: 'Key ${i + 1}'),
                ),

              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Mean',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.playlist_add),
                      onPressed:(){
                        setState((){
                          mean.add(TextEditingController());
                        });
                      },
                    ),
                  ]
              ),

              for (int i = 0; i < mean.length; i++)
                TextField(
                  controller: mean[i],
                  decoration: InputDecoration(hintText: 'Mean ${i + 1}'),
                ),

              const SizedBox(height: 20),
              const Text(
                  'Note',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              ),
              TextField(
                  controller: note,
                  decoration: const InputDecoration(hintText: 'Note')
              ),
              const SizedBox(height: 20),
              if(wordModify.type == ModifyType.modify) Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    child: Text(('Delete this group')),
                    onPressed: () async {
                      String msg = 'Fail to Delete group!';
                      bool ret = true;
                      ret = await database.removeGroup(wordSearch.query, wordSearch.isEng, wordModify.index);
                      if (ret) {
                        wordSearch.data.removeAt(wordModify.index);
                        msg = 'Delete words successfully!';
                      }
                      Navigator.of(context).pop();
                      await showDialog(
                        context: context, builder: (BuildContext context) {
                          return NotifyDialog(isSuccess: ret, message: msg);
                        }
                      );
                    },
                  ),
                ],
              ),
            ])),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButtonApp(
                  label: 'Cancel',
                  backgroundColor: Colors.white30,
                  onPressed: (){Navigator.of(context).pop();},
                ),
                const SizedBox(width: 16),
                TextButtonApp(
                  label: 'OK',
                  backgroundColor: Colors.blueGrey,
                  onPressed: () async {
                    String msg = 'Key or Mean cannot be empty and contain special characters!';
                    bool ret = await changeGroup();
                    if(ret)
                      msg = wordModify.type == ModifyType.add ? 'Add words successfully!' : 'Modify words successfully!';

                    Navigator.of(context).pop();
                    await showDialog(
                      context: context, builder: (BuildContext context) {
                        return NotifyDialog(isSuccess: ret, message: msg);
                      }
                    );
                  },
                )
              ]
            )
          ]
        )
      )
    );
  }
}