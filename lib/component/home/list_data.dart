import 'package:flutter/material.dart';

class ListData extends StatefulWidget {
  final Map<String, List<int>>? data;
  const ListData({Key? key, this.data}) : super(key: key);

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Count: ${widget.data?.length}',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
          Expanded( child: ListView.builder(
            itemCount: widget.data?.length,
            itemBuilder: (context, index) { return Column(children: [
              Text(widget.data!.keys.elementAt(index),
                style: const TextStyle(fontSize: 20)),
              Container(height: 2, width: 250, color: Colors.blueGrey)
            ]);}
          ))
        ],
      )
    );
  }
}
