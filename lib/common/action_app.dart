import 'dart:async';
import 'package:flutter/material.dart';
import 'enum.dart';

class ActionApp {
  static OverlayEntry? _overlayEntry;
  static Timer? _timer;

  static String message(StatusApp e) {
    String msg = '';
    switch (e) {
      case StatusApp.ERROR:
        msg = 'An error occurred!';
        break;
      case StatusApp.TEXT_EMPTY:
        msg = 'Text is empty!';
        break;
      case StatusApp.SPECIAL_CHAR:
        msg = 'Text contains special characters!';
        break;
      case StatusApp.ADD_WORD_SUCCESS:
        msg = 'Add word successfully!';
        break;
      case StatusApp.MODIFY_WORD_SUCCESS:
        msg = 'Modify word successfully!';
        break;
      case StatusApp.REMOVE_WORD_SUCCESS:
        msg = 'Remove word successfully!';
        break;
      case StatusApp.ADD_GRAMMAR_SUCCESS:
        msg = 'Add grammar successfully!';
        break;
      case StatusApp.MODIFY_GRAMMAR_SUCCESS:
        msg = 'Modify grammar successfully!';
        break;
      case StatusApp.REMOVE_GRAMMAR_SUCCESS:
        msg = 'Remove grammar successfully!';
        break;
      case StatusApp.START_GAME_FAIL:
        msg = 'At least 4 word groups are required to play this game!';
        break;
      case StatusApp.UPLOAD_SUCCESS:
        msg = 'Upload data to server successfully!';
        break;
      case StatusApp.CONNECT_FAIL:
        msg = 'Unable to connect to the server, please check your internet connection!';
        break;
      case StatusApp.ACCOUNT_INVALID:
        msg = 'Username or password is incorrect.'
          'If you do not have an account, please contact the administrator for support.';
        break;
      case StatusApp.DOWNLOAD_SUCCESS:
        msg = 'Download data from server successfully!';
        break;
        case StatusApp.IMPORT_SUCCESS:
        msg = 'Import file successfully!';
        break;
        case StatusApp.EXPORT_SUCCESS:
        msg = 'Export file successfully!';
        break;
        case StatusApp.FILE_NOT_FOUND:
        msg = 'Please import json file!';
        break;
      default:
        break;
    }
    return msg;
  }

  static void showNotify(BuildContext context, MessageType msgType, StatusApp msg) {
    IconData icon;
    String title;
    Color color;
    switch (msgType) {
      case MessageType.SUCCESS:
        title = 'SUCCESS';
        icon = Icons.done;
        color = Colors.green.withOpacity(0.6);
        break;
      case MessageType.ERROR:
        title = 'ERROR';
        icon = Icons.error_outline;
        color = Colors.red.withOpacity(0.6);
        break;
      default:
        title = 'WARNING';
        icon = Icons.warning;
        color = Colors.blue.withOpacity(0.6);
        break;
    }
    _overlayEntry?.remove();
    _timer?.cancel();

    _overlayEntry = OverlayEntry(builder: (context) => Positioned(
      bottom: 60.0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        color: color,
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15, decoration: TextDecoration.none)
                  ),
                  SizedBox(height: 5),
                  Text(
                       message(msg),
                      style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.normal, decoration: TextDecoration.none),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));

    Overlay.of(context).insert(_overlayEntry!);

    _timer = Timer(Duration(seconds: 5), () {
      _overlayEntry?.remove();
      _overlayEntry = null;
    });
  }
}