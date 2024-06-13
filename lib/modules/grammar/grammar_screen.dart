import 'package:flutter/material.dart';
import 'managa_dialog.dart';
import '../../models/grammar_model.dart';

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({Key? key}) : super(key: key);

  @override
  _GrammarScreenState createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  final GrammarModel _grammarModel = GrammarModel();
  List<GrammarItem> _data = [];

  void _onSearch(String query) {
    if(query.isEmpty) {
      _data = _grammarModel.data;
    } else {
      _data = [];
      for (GrammarItem item in _grammarModel.data) {
        if (item.form.contains(query) || item.structure.contains(query)) {
          _data.add(item);
        }
      }
    }
    setState(() {});
  }

  @override
  void initState() {
    _data = _grammarModel.data;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          'Dictionary',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          Container(
            width: 160,
            height: 35,
            child: TextField(
              style: TextStyle(color: Colors.black87, fontSize: 17),
              onSubmitted: _onSearch,
              decoration: const InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.black26),
                filled: true,
                fillColor: Colors.white70,
                contentPadding: EdgeInsets.only(top: 15, left: 15),
                suffixIcon: Icon(Icons.search, color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: BorderSide.none,
                ),
              )
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
              onPressed: () async {
                await showDialog(context: context, builder: (BuildContext context) {
                  return ManageDialog(form: '', structure: '', index: 0, isAdd: true);
                });
                setState(() {});
              }
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {FocusScope.of(context).unfocus();},
        child: Container(
          padding: const EdgeInsets.all(25.0),
          child:  ListView.builder(
            itemCount: _data.length,
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
                                  _data[index].form,
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                              ),
                              Text(
                                  _data[index].structure,
                                  style: TextStyle(fontSize: 17)
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () async {
                            await showDialog(context: context, builder: (BuildContext context) {
                              return ManageDialog(form: _data[index].form, structure: _data[index].structure, index: index, isAdd: false);
                            });
                            setState(() {});
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
        ),
      ),
    );
  }
}