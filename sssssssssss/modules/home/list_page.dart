import 'package:flutter/material.dart';
import 'search_page.dart';

class ListPage extends StatefulWidget {
  final Map<String, List<int>>? data;
  final Function(SearchConfig) onClick;

  const ListPage({Key? key, this.data, required this.onClick}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Count: ${widget.data?.length}',
                style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Expanded( child: ListView.builder(
                itemCount: widget.data?.length,
                itemBuilder: (context, index) { return GestureDetector(
                  child: Column(children: [
                    const SizedBox(height: 10),
                    Container(
                        width: 230,
                        height: 40,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(width: 2, color: Colors.blueGrey)
                        ),
                        child: Center( child: Text(
                            widget.data!.keys.elementAt(index),
                            style: const TextStyle(fontSize: 20)
                        ))
                    )
                  ]),
                  onTap: () {
                    SearchConfig config = SearchConfig();
                    config.isSearch = true;
                    config.word = widget.data!.keys.elementAt(index);
                    config.group = widget.data![config.word]!;
                    widget.onClick(config);
                  },
                );}
            ))
          ],
        )
    );
  }
}