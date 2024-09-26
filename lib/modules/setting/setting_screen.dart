import 'dart:convert';
import 'dart:typed_data';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../../common/action_app.dart';
import '../../models/database.dart';
import '../../common/enum.dart';
import 'login_dialog.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key, required this.onChangedTheme}) : super(key: key);

  final Function() onChangedTheme;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  List<String> _title = [];
  List<IconData> _icon = [];

  void _changedTheme(bool value) async {
    bool ret = await database.setTheme(value);
    if(ret) {
      widget.onChangedTheme();
    }
  }

  Future<void> onAction(int index) async {
    switch(index) {
      case 0:
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const LoginDialog(isDownload: false);
          }
        );
        break;
      case 1:
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const LoginDialog(isDownload: true);
          }
        );
        break;
      case 2:
        Map<String, dynamic> data = await database.readFileLocal();
        final strData = jsonEncode(data);
        String? path = await FilePicker.platform.saveFile(
            fileName: 'data.json',
            bytes: Uint8List.fromList(utf8.encode(strData))
        );
        if (path != null) {
          StatusApp ret = await database.exportData(path, strData);
          if(ret == StatusApp.ERROR) {
            ActionApp.showNotify(context, MessageType.ERROR, ret);
          } else {
            ActionApp.showNotify(context, MessageType.SUCCESS, ret);
          }
      }
        break;
      case 3:
        FilePickerResult? result = await FilePicker.platform.pickFiles();
        if (result != null) {
          String path = result.files.single.path!;
          if(path.endsWith('.json')) {
            StatusApp ret = await database.importData(path);

            if(ret == StatusApp.ERROR) {
              ActionApp.showNotify(context, MessageType.ERROR, ret);
            } else {
              ActionApp.showNotify(context, MessageType.SUCCESS, ret);
            }
          } else {
            ActionApp.showNotify(context, MessageType.ERROR, StatusApp.FILE_NOT_FOUND);
          }
        }
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    _title = ['Upload to server', 'Download from server', 'Export json file', 'Import json file'];
    _icon = [Icons.send_to_mobile_rounded, Icons.install_mobile_rounded, Icons.upload, Icons.download];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  Text('Theme', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.blueGrey[800])),
                  Row(
                    children: [
                      const Text('Dark', style: TextStyle(fontSize: 15)),
                      const SizedBox(width: 10),
                      Switch(value: (database.configApp.theme == ThemeApp.LIGHT), onChanged: _changedTheme, activeColor: Colors.blueGrey),
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
              height: 300,
              padding: const EdgeInsets.only(top: 20, bottom: 20, left: 20, right: 55),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(children: [Text('Data', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.blueGrey[800]))]),
                  for (int i = 0; i < 4; i++)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('    ${_title[i]}', style: TextStyle(fontSize: 17, color: Colors.blueGrey[800])),
                        IconButton(
                          icon: Icon(_icon[i], color: Colors.blueGrey, size: 30),
                          onPressed: () async {await onAction(i);},
                        ),
                      ],
                    ),
                ],
              ),
            )
          ],
        )
    );
  }
}