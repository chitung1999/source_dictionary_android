import 'package:flutter/material.dart';
import '../../models/database.dart';
import '../../component/notify_dialog.dart';
import '../../component/text_button_app.dart';

class ManageDialog extends StatefulWidget {
  const ManageDialog({Key? key, required this.form, required this.structure,
  required this.index, required this.isAdd}) : super(key: key);

  final String form;
  final String structure;
  final int index;
  final bool isAdd;
  @override
  _ManageDialogState createState() => _ManageDialogState();
}

class _ManageDialogState extends State<ManageDialog> {
  final Database _database = Database();
  TextEditingController _form = TextEditingController();
  TextEditingController _structure = TextEditingController();

  Future<bool> changeGroup() async {
    if(_form.text.isEmpty || _structure.text.isEmpty) {
      return false;
    }

    if(widget.isAdd) {
      await _database.addGrammar(_form.text, _structure.text);
    } else {
      await _database.modifyGrammar(_form.text, _structure.text, widget.index);
    }

    return true;
  }

  @override
  void initState() {
    _form.text = widget.form;
    _structure.text = widget.structure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Grammar', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              TextField(
                controller: _form,
                style: TextStyle(fontSize: 20),
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Form',
                  hintText: 'Ex: Xin chào + S!',
                  labelStyle: TextStyle(fontSize: 20, color: Colors.deepPurple.shade900),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple.shade900)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple.shade900))
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _structure,
                style: TextStyle(fontSize: 20),
                minLines: 1,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Structure',
                  hintText: 'Ex: Hello + S!',
                  labelStyle: TextStyle(fontSize: 20, color: Colors.deepPurple),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple))
                ),
              ),
            SizedBox(height: 10),
            if(!widget.isAdd) Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(('Delete this grammar')),
                  onPressed: () async {
                    String msg = 'Fail to delete grammar!';
                    bool ret = true;
                    ret = await _database.removeGrammar(widget.index);
                    if (ret) {
                      msg = 'Delete grammar successfully!';
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
                    String msg = 'Form or Structure cannot be empty!';
                    bool ret = await changeGroup();
                    if(ret)
                      msg = widget.isAdd ? 'Add grammar successfully!' : 'Modify grammar successfully!';

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
        ),
      )
    );
  }
}