import 'package:flutter/material.dart';
import 'package:source_dictionary_mobile/models/database.dart';
import 'package:source_dictionary_mobile/modules/grammar/grammar_item.dart';
import '../../common/action_app.dart';
import '../../common/change_data.dart';
import '../../common/enum.dart';
import '../../common/search_bar.dart';

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({Key? key}) : super(key: key);

  @override
  _GrammarScreenState createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  void _onModifySuccess() {
    database.grammarModel.textTyping = '';
    database.grammarModel.search();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dictionary', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)),
        flexibleSpace: database.configApp.banner,
        actions: [
          SearchBarApp(
            onTyping: (String str) {
              database.grammarModel.textTyping = str;
              database.grammarModel.search();
              setState(() {});
            },
          ),
          SizedBox(width: 10),
          Builder(
            builder: (context) {
              return Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: IconButton(
                  icon: const Icon(Icons.add, color: Colors.black),
                  onPressed: () async {
                    await showDialog(context: context, builder: (BuildContext context) {
                      return ChangeData(
                        isHome: false,
                        isAddNew: true,
                        onSuccess: () {
                          database.grammarModel.search();
                          setState(() {});
                        }
                      );
                    });
                  }
                ),
              );
            }
          ),
          SizedBox(width: 20)
        ]
      ),
      body: Container(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                database.grammarModel.data.length != database.grammarModel.resultSearch.length ? GestureDetector(
                  child: Icon(Icons.filter_alt_off, color: Colors.deepPurple, size: 20),
                  onTap: () {
                    database.grammarModel.textTyping = '';
                    database.grammarModel.search();
                    setState(() {});
                  },
                ) : SizedBox(),
                Text(
                  'Result: ${database.grammarModel.resultSearch.length}',
                  style: const TextStyle(fontSize: 15, fontStyle: FontStyle.italic, color: Colors.deepPurple)
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: database.grammarModel.resultSearch.length,
                itemBuilder: (context, index) {
                  return GrammarItem(
                    onModify: () async {
                      await showDialog(context: context, builder: (BuildContext context) {
                        return ChangeData(onSuccess: _onModifySuccess, isHome: false, isAddNew: false,
                          grammarItem: database.grammarModel.data[database.grammarModel.listIndex[index]], index: index);
                      });
                      setState(() {});
                    },
                    onDelete: () async {
                      StatusApp ret = await database.removeGrammar(database.grammarModel.listIndex[index]);
                      ActionApp.showNotify(context, MessageType.SUCCESS, ret);
                      _onModifySuccess();
                    },
                    form: database.grammarModel.resultSearch[index].form,
                    structure: database.grammarModel.resultSearch[index].structure
                  );
                }
              ),
            ),
          ],
        )
      )
    );
  }
}