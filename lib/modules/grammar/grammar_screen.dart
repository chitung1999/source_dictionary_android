import 'package:flutter/material.dart';
import 'package:source_dictionary_mobile/models/database.dart';
import '../../common/change_data.dart';

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
    return Container(
      padding: const EdgeInsets.all(25.0),
      child:  ListView.builder(
        itemCount: database.grammarModel.resultSearch.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(width: 2, color: Colors.blueGrey)
                ),
                width: double.infinity,
                padding: const EdgeInsets.only(left: 15, right: 10, top: 20, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              database.grammarModel.resultSearch[index].form,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blueGrey[800])
                          ),
                          Text(
                              database.grammarModel.resultSearch[index].structure,
                            style: TextStyle(fontSize: 17, color: Colors.blueGrey[800])
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () async {
                          await showDialog(context: context, builder: (BuildContext context) {
                            return ChangeData(onSuccess: _onModifySuccess, isHome: false, isAddNew: false,
                                grammarItem: database.grammarModel.data[index], index: index);
                          });
                        }
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20)
            ],
          );
        }
      )
    );
  }
}