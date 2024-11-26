import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UtilFunction {
  String generateChatID({required String uid1, required String uid2}) {
    List uids = [uid1, uid2];
    uids.sort();
    String chatID = uids.fold("", (id, uid) => '$id$uid');
    return chatID;
  }

  Future<File?> chooseFile(
      {FileType type = FileType.any, List<String>? allowedExtensions}) async {
    try {
      final result = await FilePicker.platform
          .pickFiles(type: type, allowedExtensions: allowedExtensions);
      debugPrint('$result');

      if (result != null && result.files.isNotEmpty) {
        debugPrint(result.files.single.path!);
        return File(result.files.single.path!);
      }
    } catch (e) {
      debugPrint('chooseFile error:$e');
    }
    return null;
  }
}
