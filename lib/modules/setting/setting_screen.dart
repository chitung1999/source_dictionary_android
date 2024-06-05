import 'package:flutter/material.dart';
import 'login_dialog.dart';
import '../../models/config_app.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key, required this.onChangedTheme}) : super(key: key);

  final Function(bool) onChangedTheme;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  //final ConfigApp config = ConfigApp();
  bool _isLight = true;

  void _changedTheme(bool value) async {
    setState(() {
      _isLight = value;
    });
    //await config.setTheme(value);
    widget.onChangedTheme(value);
  }

  // void _getTheme() async {
  //   setState(() {_isLight = (config.theme == ThemeApp.light);});
  // }

  @override
  Widget build(BuildContext context) {
    // _getTheme();

    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: const Text(
                'Dictionary',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white)
            )
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                      border: Border.all(width: 2, color: Colors.blueGrey)
                  ),
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          SizedBox(width: 20),
                          Text('Theme', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Dark', style: TextStyle(fontSize: 15)),
                          const SizedBox(width: 10),
                          Switch(value: _isLight, onChanged: _changedTheme, activeColor: Colors.blueGrey),
                          const SizedBox(width: 10),
                          const Text('Light', style: TextStyle(fontSize: 15)),
                          const SizedBox(width: 20)
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
                  height: 100,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          SizedBox(width: 20),
                          Text('DataBase', style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20)),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.upload,
                                  color: Colors.blueGrey,
                                ),
                                onPressed: () async {
                                  await showDialog(context: context, builder: (BuildContext context) {
                                    return const LoginDialog(isDownload: false);
                                  });
                                },
                              ),
                              const Text('Upload', style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          const SizedBox(width: 30),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(
                                  Icons.download,
                                  color: Colors.blueGrey,
                                ),
                                onPressed: () async {
                                  await showDialog(context: context, builder: (BuildContext context) {
                                    return const LoginDialog(isDownload: true);
                                  });
                                },
                              ),
                              const Text('Download', style: TextStyle(fontSize: 15)),
                            ],
                          ),
                          const SizedBox(width: 20)
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
        )
    );
  }
}