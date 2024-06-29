import 'package:flutter/material.dart';
import 'package:source_dictionary_mobile/models/word_model.dart';
import '../../models/word_action.dart';
import '../../component/notify_dialog.dart';
import '../../component/text_button_app.dart';
import '../../models/database.dart';

class ManageDialog extends StatefulWidget {
  const ManageDialog({Key? key}) : super(key: key);

  @override
  _ManageDialogState createState() => _ManageDialogState();
}

class _ManageDialogState extends State<ManageDialog> {
  final Database _database = Database();
  final WordAction _wordAction = WordAction();
  String _msg = '';
  TextEditingController _key = TextEditingController();
  TextEditingController _mean = TextEditingController();
  TextEditingController _note = TextEditingController();

  Future<bool> changeGroup() async {
    List<String> keys = _key.text.split(',').map((word) => word.trim().toLowerCase()).toSet().toList();
    keys.sort();
    List<String> means = _mean.text.split(',').map((word) => word.trim().toLowerCase()).toSet().toList();
    means.sort();

    bool ret;
    if(_wordAction.isModify) {
      ret = await _database.modifyGroup(keys, means, _note.text, _wordAction.indexModify);
      if(ret) {
        WordItem wordItem = WordItem();
        wordItem.keys = keys;
        wordItem.means = means;
        wordItem.note = _note.text;
        _wordAction.resultSearch[_wordAction.indexModify] = wordItem;
        _msg = 'Modify group successfully!';
      } else {
        _msg = 'Fail to modify group!';
      }
    } else {
      ret = await _database.addGroup(keys, means, _note.text);
      _msg = ret ? "Add group successfully!" : 'Fail to add group!';
    }
    return ret;
  }

  @override
  void initState() {
    super.initState();
    if(_wordAction.isModify) {
      _key.text = _wordAction.resultSearch[_wordAction.indexModify]!.keysToString();
      _mean.text = _wordAction.resultSearch[_wordAction.indexModify]!.meansToString();
      _note.text = _wordAction.resultSearch[_wordAction.indexModify]!.note;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Synonyms', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            TextField(
              controller: _key,
              style: TextStyle(fontSize: 20),
              minLines: 1,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Key',
                hintText: 'Enter words here',
                labelStyle: TextStyle(fontSize: 20, color: Colors.deepPurple.shade900),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple.shade900)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple.shade900))
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _mean,
              style: TextStyle(fontSize: 20),
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Mean',
                hintText: 'Enter means here',
                labelStyle: TextStyle(fontSize: 20, color: Colors.deepPurple),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple))
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _note,
              style: TextStyle(fontSize: 20),
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Note',
                hintText: 'Enter notes here',
                labelStyle: TextStyle(fontSize: 20, color: Colors.deepPurple),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple))
              ),
            ),
            SizedBox(height: 10),
            if(_wordAction.isModify) Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(('Delete this group')),
                  onPressed: () async {
                    bool ret = await _database.removeGroup(_wordAction.indexModify);
                    if(ret) {
                      _wordAction.resultSearch.remove(_wordAction.indexModify);
                      _msg = 'Delete group successfully!';

                    } else {
                      _msg = 'Fail to delete group!';

                    }
                    Navigator.of(context).pop();
                    await showDialog(
                      context: context, builder: (BuildContext context) {
                        return NotifyDialog(isSuccess: ret, message: _msg);
                      }
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 10),
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
                    RegExp regex = RegExp(r'[^a-zA-Z,\s]');
                    if(_key.text.isEmpty || _mean.text.isEmpty
                        || _key.text.contains('\n') || _mean.text.contains('\n')
                        || regex.hasMatch(_key.text) || regex.hasMatch(_mean.text)) {
                      _msg = 'Key or Mean cannot be empty, contain number and special characters. Words separated by (,)!';
                      await showDialog(
                        context: context, builder: (BuildContext context) {
                          return NotifyDialog(isSuccess: false, message: _msg);
                        }
                      );
                    } else {
                      bool ret = await changeGroup();
                      Navigator.of(context).pop();
                      await showDialog(
                        context: context, builder: (BuildContext context) {
                          return NotifyDialog(isSuccess: ret, message: _msg);
                        }
                      );
                    }
                  },
                )
              ]
            )
            ],
          ),
      )
    );
  }
}