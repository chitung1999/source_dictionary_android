import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../component/notify_dialog.dart';
import '../../models/database.dart';
import '../../models/config_app.dart';
import '../../models/enum_app.dart';
import 'login_dialog.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key, required this.onChangedTheme}) : super(key: key);

  final Function() onChangedTheme;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  Database _database = Database();
  ConfigApp _config = ConfigApp();

  void _changedTheme(bool value) async {
    bool ret = await _database.setTheme(value);
    if(ret) {
      widget.onChangedTheme();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text(
              'Dictionary',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)
            ),
          ],
        )
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 15.0),
        child:  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(width: 2, color: Colors.blueGrey)
              ),
              height: 100,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Theme', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                  Row(
                    children: [
                      const Text('Dark', style: TextStyle(fontSize: 15)),
                      const SizedBox(width: 10),
                      Switch(value: (_config.theme == ThemeApp.light), onChanged: _changedTheme, activeColor: Colors.blueGrey),
                      const SizedBox(width: 10),
                      const Text('Light', style: TextStyle(fontSize: 15)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(width: 2, color: Colors.blueGrey)
              ),
              height: 200,
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Server', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 80,
                            child: Column(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.send_to_mobile_rounded,
                                    color: Colors.blueGrey,
                                  ),
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return const LoginDialog(isDownload: false);
                                      }
                                    );
                                  },
                                ),
                                const Text('Push', style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            child: Column(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.install_mobile_rounded,
                                    color: Colors.blueGrey,
                                  ),
                                  onPressed: () async {
                                    await showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return const LoginDialog(isDownload: true);
                                      }
                                    );
                                  },
                                ),
                                const Text('Pull', style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Local', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 80,
                            child: Column(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.upload,
                                    color: Colors.blueGrey,
                                  ),
                                  onPressed: () async {
                                    Database dataBase = Database();
                                    Map<String, dynamic> data = await dataBase.readFileLocal();
                                    final strData = jsonEncode(data);
                                    String? path = await FilePicker.platform.saveFile(
                                      fileName: 'data.json',
                                      bytes: Uint8List.fromList(utf8.encode(strData))
                                    );
                                    if (path != null) {
                                      String msg = '';
                                      bool ret = await dataBase.exportData(path, strData);
                                      msg = ret ? 'Export file successfully!' : 'Fail to export file!';
                                      await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return NotifyDialog(isSuccess: ret, message: msg);
                                        }
                                      );
                                    }
                                  },
                                ),
                                const Text('Export', style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          ),
                          Container(
                            width: 80,
                            child: Column(
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.download,
                                    color: Colors.blueGrey,
                                  ),
                                  onPressed: () async {
                                    FilePickerResult? result = await FilePicker.platform.pickFiles();
                                    bool ret = false;
                                    if (result != null) {
                                      String path = result.files.single.path!;
                                      String msg = '';
                                      if(path.endsWith('.json')) {
                                        Database dataBase = Database();
                                        ret = await dataBase.importData(path);
                                        msg = ret ? 'Import file successfully!' : 'Fail to import file!';
                                      } else {
                                        msg = 'Please import json file!';
                                      }
                                      await showDialog(
                                        context: context, builder: (BuildContext context) {
                                          return NotifyDialog(isSuccess: ret, message: msg);
                                        }
                                      );
                                    }
                                  },
                                ),
                                const Text('Import', style: TextStyle(fontSize: 15)),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        )
      )
    );
  }
}