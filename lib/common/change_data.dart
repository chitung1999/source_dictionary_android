import 'package:flutter/material.dart';
import 'package:source_dictionary_mobile/common/enum.dart';
import '../common/text_box_btn.dart';
import '../common/action_app.dart';
import '../models/database.dart';
import '../models/word_model.dart';
import '../models/grammar_model.dart';

class ChangeData extends StatefulWidget {
  const ChangeData({Key? key, required this.isHome, required this.isAddNew,
    this.wordItem = null, this.grammarItem = null, this.index = null, this.onSuccess}) : super(key: key);

  final bool isHome;
  final bool isAddNew;
  final WordItem? wordItem;
  final GrammarItem? grammarItem;
  final int? index;
  final Function()? onSuccess;

  @override
  _ChangeDataState createState() => _ChangeDataState();
}

class _ChangeDataState extends State<ChangeData> {
  TextEditingController _box1 = TextEditingController();
  TextEditingController _box2 = TextEditingController();
  TextEditingController _box3 = TextEditingController();

  @override
  void initState() {
    if(!widget.isAddNew) {
      if(widget.isHome) {
        _box1.text = widget.wordItem!.keysToString();
        _box2.text = widget.wordItem!.meansToString();
        _box3.text = widget.wordItem!.note;
      } else {
        _box1.text = widget.grammarItem!.form;
        _box2.text = widget.grammarItem!.structure;
      }
    }
    super.initState();
  }

  Future<StatusApp> changeData() async {
    StatusApp ret;
    if(widget.isHome) {
      List<String> keys = _box1.text.split(',').map((word) =>
          word.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase()).where((
          word) => word.isNotEmpty).toSet().toList();
      keys.sort();
      List<String> means = _box2.text.split(',').map((word) =>
          word.trim().replaceAll(RegExp(r'\s+'), ' ').toLowerCase()).where((
          word) => word.isNotEmpty).toSet().toList();
      means.sort();
      if (widget.isAddNew) {
        ret = await database.addGroup(keys, means, _box3.text);
      } else {
        ret = await database.modifyGroup(keys, means, _box3.text, widget.index!);
      }
    } else {
      if (widget.isAddNew) {
        ret = await database.addGrammar(_box1.text, _box2.text);
      } else {
        ret = await database.modifyGrammar(_box1.text, _box2.text, widget.index!);
      }
    }
  return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                controller: _box1,
                style: TextStyle(fontSize: 20, color: Colors.blueGrey[800]),
                decoration: InputDecoration(
                  labelText: widget.isHome ? 'English' : 'Form',
                  labelStyle: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  hintText: 'Enter here',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.blueGrey.withOpacity(0.4)),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple))
                ),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _box2,
                style: TextStyle(fontSize: 20, color: Colors.blueGrey[800]),
                decoration: InputDecoration(
                  labelText: widget.isHome ? 'Vietnamese' : 'Structure',
                  labelStyle: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  hintText: 'Enter here',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.blueGrey.withOpacity(0.4)),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple))
                ),
              ),
              if(widget.isHome) const SizedBox(height: 30),
              if(widget.isHome) TextField(
                controller: _box3,
                style: TextStyle(fontSize: 20, color: Colors.blueGrey[800]),
                minLines: 1,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Note',
                  labelStyle: TextStyle(fontSize: 20, color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  hintText: 'Enter here',
                  hintStyle: TextStyle(fontSize: 20, color: Colors.blueGrey.withOpacity(0.4)),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurple))
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextBoxBtn (
                      title: 'Cancel',
                      radius: 5,
                      bgColor: Colors.white,
                      textColor: Colors.blueGrey,
                      onPressed: (){Navigator.of(context).pop();},
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: TextBoxBtn (
                      title: 'OK',
                      width: 150,
                      height: 40,
                      radius: 5,
                      bgColor: Colors.blueGrey,
                      onPressed: () async {
                        if(_box1.text.isEmpty || _box2.text.isEmpty) {
                          ActionApp.showNotify(context, MessageType.ERROR, StatusApp.TEXT_EMPTY);
                          return;
                        }
                        RegExp regex = RegExp(r'[^a-zA-Z, àáảãạâầấẩẫậăằắẳẵặèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđ]');
                        if(widget.isHome && (regex.hasMatch(_box1.text.toLowerCase()) || regex.hasMatch(_box2.text.toLowerCase()))) {
                          ActionApp.showNotify(context, MessageType.ERROR, StatusApp.SPECIAL_CHAR);
                          return;
                        }
                        StatusApp ret = await changeData();
                        if(ret == StatusApp.ERROR) {
                          ActionApp.showNotify(context, MessageType.ERROR, ret);
                        } else {
                          ActionApp.showNotify(context, MessageType.SUCCESS, ret);
                          if (widget.onSuccess != null) {widget.onSuccess!();};
                          Navigator.of(context).pop();
                        }
                      },
                    ),
                  )
                ]
              )
            ],
          ),
        ),
      ),
    );
  }
}