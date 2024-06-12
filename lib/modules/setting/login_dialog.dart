import 'dart:async';
import 'package:flutter/material.dart';
import '../../component/notify_dialog.dart';
import '../../models/database.dart';
import '../../models/config_app.dart';
import '../../component/text_button_app.dart';
import '../../models/enum_app.dart';

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
  String _msg = '';

  Future<bool> uploadData() async {
    ResultConnect ret = await _database.uploadDataToServer(_username.text, _password.text);

    if(ret == ResultConnect.error) {
      _msg = 'Fail to upload data from server!';
      return false;
    } else if (ret == ResultConnect.invalid) {
      _msg = 'Username or password is incorrect.\n'
          'If you do not have an account, please contact the administrator for support.';
      return false;
    } else {
      _msg = 'Upload data to server successfully!';
      _database.setAccount(_username.text, _password.text);
      return true;
    }
  }

  Future<bool> downloadData() async {
    ResultConnect ret = await _database.getDataFromServer(_username.text, _password.text);
    if(ret == ResultConnect.error) {
      _msg = 'Fail to download data from server!';
      return false;
    } else if (ret == ResultConnect.invalid) {
      _msg = 'Username or password is incorrect.\n'
           'If you do not have an account, please contact the administrator for support.';
      return false;
    } else {
      _msg = 'Download data to server successfully!';
      _database.setAccount(_username.text, _password.text);
      return true;
    }
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

    return Dialog( child: Container(
      height: 350,
      padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 40.0),
      child: Column(
        children: [
          const Text('Login', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.blueGrey)),
          const SizedBox(height: 25),
          TextField(
            controller: _username,
            decoration: const InputDecoration(
                hintText: 'User name',
                icon: Icon(Icons.person)
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _password,
            obscureText: _isHidePassword,
            decoration: InputDecoration(
                hintText: 'Password',
                icon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                    icon: const Icon(Icons.visibility),
                    onPressed: () {
                      setState(() {_isHidePassword = !_isHidePassword;});
                    }
                )
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButtonApp(
                label: 'Cancel',
                backgroundColor: Colors.white30,
                onPressed: () async {Navigator.of(context).pop();},
              ),
              const SizedBox(width: 16),
              TextButtonApp(
                label: 'OK',
                backgroundColor: Colors.blueGrey,
                onPressed: () async {
                  setState(() {_isLoading = true;});
                  bool ret = widget.isDownload ? (await downloadData()) : (await uploadData());
                  Navigator.of(context).pop();
                  await showDialog(
                    context: context, builder: (BuildContext context) {
                      return NotifyDialog(isSuccess: ret, message: _msg);
                    }
                  );
                },
              )
            ]
          )
        ]
      )
    ));
  }
}