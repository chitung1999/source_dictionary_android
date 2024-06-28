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
  // final Database database = Database();
  // final WordSearchModel wordSearch = WordSearchModel();
  // WordModifyModel wordModify = WordModifyModel();
  TextEditingController _key = TextEditingController();
  TextEditingController _mean = TextEditingController();
  TextEditingController _note = TextEditingController();

  Future<bool> changeGroup() async {
    if(_key.text.isEmpty || _mean.text.isEmpty) {
      return false;
    }

    // if(wordModify.type == ModifyType.add) {
    //   await database.addGroup(addKey, addMean, addNote);
    // } else {
    //   wordSearch.modify(addKey, addMean, addNote, wordModify.index);
    //   await database.modifyGroup(addKey, addMean, addNote, wordModify.query, wordModify.isEng, wordModify.index);
    // }

    return true;
  }

  @override
  void initState() {
    // super.initState();
    // int count = (wordModify.keys.length > 1 ? wordModify.keys.length : 1);
    // for (int i = 0; i < count; i++) {
    //   key.add(TextEditingController());
    //   if(i < wordModify.keys.length) {
    //     key[i].text = wordModify.keys[i];
    //   }
    // }
    //
    // count = (wordModify.means.length > 1 ? wordModify.means.length : 1);
    // for (int i = 0; i < count; i++) {
    //   mean.add(TextEditingController());
    //   if(i < wordModify.means.length) {
    //     mean[i].text = wordModify.means[i];
    //   }
    // }
    //
    // note.text = wordModify.note;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
        child: IntrinsicHeight(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Synonyms', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              TextField(
                controller: _key,
                minLines: 1,
                maxLines: 4,
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
                minLines: 1,
                maxLines: 4,
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
                minLines: 1,
                maxLines: 4,
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
              // if(!widget.isAdd) Row(
              //   mainAxisAlignment: MainAxisAlignment.end,
              //   children: [
              //     TextButton(
              //       child: Text(('Delete this grammar')),
              //       onPressed: () async {
              //         String msg = 'Fail to delete grammar!';
              //         bool ret = true;
              //         ret = await _database.removeGrammar(widget.index);
              //         if (ret) {
              //           msg = 'Delete grammar successfully!';
              //         }
              //         Navigator.of(context).pop();
              //         await showDialog(
              //             context: context, builder: (BuildContext context) {
              //           return NotifyDialog(isSuccess: ret, message: msg);
              //         }
              //         );
              //       },
              //     ),
              //   ],
              // ),
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
                        //msg = widget.isAdd ? 'Add grammar successfully!' : 'Modify grammar successfully!';

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
              ],
            ),
        )
      )
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Dialog(
  //     insetPadding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
  //     child: Container(
  //       padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
  //       child: Column(
  //         children: [
  //           Expanded(child: ListView( children: [
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 const Text(
  //                   'Key',
  //                   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                 ),
  //                 IconButton(
  //                   icon: const Icon(Icons.playlist_add),
  //                   onPressed:(){
  //                     setState((){
  //                       key.add(TextEditingController());
  //                     });
  //                   },
  //                 ),
  //               ]
  //             ),
  //
  //             for (int i = 0; i < key.length; i++)
  //               TextField(
  //                 controller: key[i],
  //                 decoration: InputDecoration(hintText: 'Key ${i + 1}'),
  //               ),
  //
  //             const SizedBox(height: 20),
  //             Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   const Text(
  //                     'Mean',
  //                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  //                   ),
  //                   IconButton(
  //                     icon: const Icon(Icons.playlist_add),
  //                     onPressed:(){
  //                       setState((){
  //                         mean.add(TextEditingController());
  //                       });
  //                     },
  //                   ),
  //                 ]
  //             ),
  //
  //             for (int i = 0; i < mean.length; i++)
  //               TextField(
  //                 controller: mean[i],
  //                 decoration: InputDecoration(hintText: 'Mean ${i + 1}'),
  //               ),
  //
  //             const SizedBox(height: 20),
  //             const Text(
  //                 'Note',
  //                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
  //             ),
  //             TextField(
  //                 controller: note,
  //                 decoration: const InputDecoration(hintText: 'Note')
  //             ),
  //             const SizedBox(height: 20),
  //             if(wordModify.type == ModifyType.modify) Row(
  //               mainAxisAlignment: MainAxisAlignment.end,
  //               children: [
  //                 TextButton(
  //                   child: Text(('Delete this group')),
  //                   onPressed: () async {
  //                     String msg = 'Fail to Delete group!';
  //                     bool ret = true;
  //                     ret = await database.removeGroup(wordSearch.query, wordSearch.isEng, wordModify.index);
  //                     if (ret) {
  //                       wordSearch.data.removeAt(wordModify.index);
  //                       msg = 'Delete words successfully!';
  //                     }
  //                     Navigator.of(context).pop();
  //                     await showDialog(
  //                       context: context, builder: (BuildContext context) {
  //                         return NotifyDialog(isSuccess: ret, message: msg);
  //                       }
  //                     );
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ])),
  //
  //           const SizedBox(height: 20),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               TextButtonApp(
  //                 label: 'Cancel',
  //                 backgroundColor: Colors.white30,
  //                 onPressed: (){Navigator.of(context).pop();},
  //               ),
  //               const SizedBox(width: 16),
  //               TextButtonApp(
  //                 label: 'OK',
  //                 backgroundColor: Colors.blueGrey,
  //                 onPressed: () async {
  //                   String msg = 'Key or Mean cannot be empty and contain special characters!';
  //                   bool ret = await changeGroup();
  //                   if(ret)
  //                     msg = wordModify.type == ModifyType.add ? 'Add words successfully!' : 'Modify words successfully!';
  //
  //                   Navigator.of(context).pop();
  //                   await showDialog(
  //                     context: context, builder: (BuildContext context) {
  //                       return NotifyDialog(isSuccess: ret, message: msg);
  //                     }
  //                   );
  //                 },
  //               )
  //             ]
  //           )
  //         ]
  //       )
  //     )
  //   );
  // }
}