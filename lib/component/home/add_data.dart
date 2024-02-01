import 'package:flutter/material.dart';

class AddData extends StatefulWidget {
  const AddData({Key? key}) : super(key: key);

  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddData> {
  List<TextField> key = [];
  List<TextField> mean = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 4; i++) {
      key.add(
        TextField(
          decoration: InputDecoration(
              labelText: 'Key ${i + 1}',
              floatingLabelBehavior: FloatingLabelBehavior.never),
        ),
      );
      mean.add(
        TextField(
          decoration: InputDecoration(
              labelText: 'Mean ${i + 1}',
              floatingLabelBehavior: FloatingLabelBehavior.never),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(vertical: 50.0),
        child: Dialog( child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            child: Column(
                children: [
                  Expanded(child: ListView( children: [
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Key',
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                            icon: const Icon(Icons.playlist_add),
                            onPressed:(){
                              setState((){
                                key.add(
                                  TextField(
                                    decoration: InputDecoration(
                                        labelText: 'Key ${key.length + 1}',
                                        floatingLabelBehavior: FloatingLabelBehavior.never
                                    ),
                                  ),
                                );
                              });
                            },
                          ),
                        ]
                    ),
                    for (var item_key in key) item_key,
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Mean',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: const Icon(Icons.playlist_add),
                          onPressed:(){
                            setState((){
                              mean.add(
                                TextField(
                                  decoration: InputDecoration(
                                      labelText: 'Mean ${mean.length + 1}',
                                      floatingLabelBehavior: FloatingLabelBehavior.never
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ]
                    ),
                    for (var item_mean in mean) item_mean,
                    const SizedBox(height: 20),
                    const Text(
                        'Note',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)
                    ),
                    const TextField( decoration: InputDecoration(
                        labelText: 'Note',
                        floatingLabelBehavior: FloatingLabelBehavior.never
                    ))
                  ])),
                  const SizedBox(height: 20),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded( child: ElevatedButton(
                          onPressed: (){ Navigator.of(context).pop();},
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                          child: const Text('Cancel', style: TextStyle(color: Colors.black)),
                        )),
                        const SizedBox(width: 16),
                        Expanded( child: ElevatedButton(
                          onPressed: () {
                            // Xử lý khi nhấn nút OK
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom( backgroundColor: Colors.blueAccent),
                          child: const Text('OK', style: TextStyle(color: Colors.black)),
                        ))
                      ]
                  )
                ]
            )
        ))
    );
  }
}