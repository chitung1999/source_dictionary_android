import 'package:flutter/material.dart';
import '../../models/word_model.dart';
import '../../models/word_search_model.dart';
import '../../models/word_modify_model.dart';
import '../../component/NotifyDialog.dart';

class AddDialog extends StatefulWidget {
  const AddDialog({Key? key}) : super(key: key);

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {
  WordModifyModel wordModify = WordModifyModel();
  List<TextEditingController> key = [];
  List<TextEditingController> mean = [];
  TextEditingController note = TextEditingController();

  bool changeGroup() {
    final WordModel word = WordModel();
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
      word.addGroup(addKey, addMean, addNote);
    } else {
      final WordSearchModel wordSearch = WordSearchModel();
      wordSearch.modify(addKey, addMean, addNote, wordModify.index);
      word.modifyGroup(addKey, addMean, addNote, wordModify.query, wordModify.isEng, wordModify.index);
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
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 50.0),
      child: Dialog( child: Container(
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
                decoration: InputDecoration(
                  labelText: 'Key ${i + 1}',
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                ),
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
                  decoration: InputDecoration(
                    labelText: 'Mean ${i + 1}',
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                  ),
                ),

              const SizedBox(height: 20),
              const Text(
                'Note',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
              ),
              TextField(
                controller: note,
                decoration: const InputDecoration(
                  labelText: 'Note',
                  floatingLabelBehavior: FloatingLabelBehavior.never
                )
              )
            ])),

            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded( child: ElevatedButton(
                  onPressed: (){Navigator.of(context).pop();},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                  child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                )),
                const SizedBox(width: 16),
                Expanded( child: ElevatedButton(
                  onPressed: () async {
                    bool ret = changeGroup();
                    Navigator.of(context).pop();
                    await showDialog(
                      context: context, builder: (BuildContext context) {
                        return NotifyDialog(
                          message: (ret ? (wordModify.type == ModifyType.add ?
                          'Add words successfully!' : 'Modify words successfully!') :
                          'Error: Key or Mean cannot be empty and contain special characters!')
                        );
                      }
                    );
                  },
                  style: ElevatedButton.styleFrom( backgroundColor: Colors.blueAccent),
                  child: const Text('OK', style: TextStyle(color: Colors.black)),
                ))
              ]
            )
          ]
        )
      ))
    );
  }
}