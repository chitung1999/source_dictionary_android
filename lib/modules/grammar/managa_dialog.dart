import 'package:flutter/material.dart';
import '../../models/database.dart';
import '../../component/NotifyDialog.dart';

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
      child: Container(
        height: 400,
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Form', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(),
            TextField(
              controller: _form,
              decoration: InputDecoration(hintText: 'Form'),
            ),
            SizedBox(height: 30),
            const Text('Structure', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(),
            TextField(
              controller: _structure,
              decoration: InputDecoration(hintText: 'Structure'),
            ),
            SizedBox(height: 20),
            if(!widget.isAdd) Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  child: Text(('Delete this grammar')),
                  onPressed: () async {
                    String msg = 'Fail to delete!';
                    bool ret = true;
                    ret = await _database.removeGrammar(widget.index);
                    if (ret) {
                      msg = 'Delete grammar successfully!';
                    }
                    Navigator.of(context).pop();
                    await showDialog(
                      context: context, builder: (BuildContext context) {
                        return NotifyDialog(message: msg);
                      }
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded( child: ElevatedButton(
                  onPressed: (){Navigator.of(context).pop();},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white30),
                  child: const Text('Cancel', style: TextStyle(color: Colors.black, fontSize: 13)),
                )),
                const SizedBox(width: 16),
                Expanded( child: ElevatedButton(
                  onPressed: () async {
                    String msg = 'Error: Form or Structure cannot be empty!';
                    bool ret = await changeGroup();
                    if(ret)
                      msg = widget.isAdd ? 'Add grammar successfully!' : 'Modify grammar successfully!';

                    Navigator.of(context).pop();
                    await showDialog(
                      context: context, builder: (BuildContext context) {
                        return NotifyDialog(message: msg);
                      }
                    );
                  },
                  style: ElevatedButton.styleFrom( backgroundColor: Colors.blueGrey),
                  child: const Text('OK', style: TextStyle(color: Colors.black)),
                ))
              ]
            )
          ]
        )
      )
    );
  }
}