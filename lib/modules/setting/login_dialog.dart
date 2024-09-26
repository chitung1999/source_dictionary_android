import 'dart:async';
import 'package:flutter/material.dart';
import '../../common/action_app.dart';
import '../../models/database.dart';
import '../../models/config_app.dart';
import '../../common/text_box_btn.dart';
import '../../common/enum.dart';
import '../../server/mongo_helper.dart';

class LoginDialog extends StatefulWidget {
  const LoginDialog({Key? key, required this.isDownload}) : super(key: key);
  final bool isDownload;

  @override
  _LoginDialogState createState() => _LoginDialogState();
}

class _LoginDialogState extends State<LoginDialog> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final Database _database = Database();
  final ConfigApp _config = ConfigApp();
  bool _isHidePassword = true;
  bool _isLoading = false;

  Future<StatusApp> uploadData() async {
    if(_username.text.isEmpty || _password.text.isEmpty) {
      return StatusApp.TEXT_EMPTY;
    }

    MongoHelper mongo = MongoHelper();
    Map<String, dynamic> data = await _database.readFileLocal();
    StatusApp ret = await mongo.upload(_username.text, _password.text, data["grammar"], data["words"]);

    if(ret == StatusApp.UPLOAD_SUCCESS) {
      _database.setAccount(_username.text, _password.text);
    }
    return ret;
  }

  Future<StatusApp> downloadData() async {
    if(_username.text.isEmpty || _password.text.isEmpty) {
      return StatusApp.TEXT_EMPTY;
    }

    MongoHelper mongo = MongoHelper();
    StatusApp ret = await mongo.download(_username.text, _password.text);

    if(ret == StatusApp.DOWNLOAD_SUCCESS) {
      _database.setAccount(_username.text, _password.text);
    }
    return ret;
  }

  @override
  void initState() {
    _username.text = _config.username;
    _password.text = _config.password;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if(_isLoading)
      return Center(child: CircularProgressIndicator());

    return Dialog(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                    'Login',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueGrey)
                ),
                const SizedBox(height: 25),
                TextField(
                  controller: _username,
                  style:TextStyle(fontSize:20),
                  decoration: InputDecoration(
                      hintText: 'User name',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.grey.withOpacity(0.3)),
                      icon: Icon(Icons.person)
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _password,
                  obscureText: _isHidePassword,
                  style:TextStyle(fontSize:20),
                  decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(fontSize: 20, color: Colors.grey.withOpacity(0.3)),
                      icon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                          icon: const Icon(Icons.visibility),
                          onPressed: () {
                            setState(() {_isHidePassword = !_isHidePassword;});
                          }
                      )
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                    widget.isDownload ? 'Get data from server!' : 'Push data to server!',
                    style: TextStyle(fontSize: 17, color: Colors.deepPurple)
                ),
                const SizedBox(height: 20),
                Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded (
                        child: TextBoxBtn(
                          title: 'Cancel',
                          radius: 10,
                          textColor: Colors.blueGrey,
                          bgColor: Colors.white,
                          onPressed: () async {Navigator.of(context).pop();},
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded (
                        child: TextBoxBtn(
                          title: 'OK',
                          radius: 10,
                          bgColor: Colors.blueGrey,
                          onPressed: () async {
                            setState(() {_isLoading = true;});
                            StatusApp ret = widget.isDownload ? (await downloadData()) : (await uploadData());
                            setState(() {_isLoading = false;});
                            if(ret == StatusApp.UPLOAD_SUCCESS || ret == StatusApp.DOWNLOAD_SUCCESS) {
                              ActionApp.showNotify(context, MessageType.SUCCESS, ret);
                              Navigator.of(context).pop();
                            } else {
                              ActionApp.showNotify(context, MessageType.ERROR, ret);
                            }
                          },
                        ),
                      )
                    ]
                )
              ]
          ),
        )
    );
  }
}