import 'package:flutter/material.dart';

import '../../model/read_data_json.dart';

class ListData extends StatelessWidget {
  const ListData({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> dataList = ['hello', 'hi', 'goodbye'];

    return Scaffold(
      appBar: AppBar(
        title: Text('Count: ${dataList.length}'),
        centerTitle: true,
      ),
      body: const JsonListView(),
      // body: ListView.builder(
      //   itemCount: dataList.length,
      //   itemExtent: 50.0,
      //   itemBuilder: (context, index) {
      //
      //     return ListTile(
      //       title: Container(
      //         height: 40,
      //         padding: const EdgeInsets.all(2.0),
      //         decoration: BoxDecoration(
      //           border: Border.all(),
      //           borderRadius:
      //               BorderRadius.circular(8.0),
      //         ),
      //         child: Text(dataList[index], style: const TextStyle(fontSize: 20),
      //           textAlign: TextAlign.center,),
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
