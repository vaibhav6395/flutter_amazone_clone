import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void Showsnackbar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
}

void httperrorhandler({
  required BuildContext context,
  required http.Response response,
  required VoidCallback onsucess,
}) {
  switch (response.statusCode) {
    case 200:
      onsucess();
      break;
    case 400:
      Showsnackbar(context, jsonDecode(response.body)['msg']);
      break;
    case 500:
      Showsnackbar(context, jsonDecode(response.body)['error']);
    default:
      Showsnackbar(context, response.body);
  }
}

Future<List<File>> pickimages() async {
  List<File> images = [];
  try {
    var files = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: true,
    );
    if (files != null && files.files.isNotEmpty) {
      for (int i = 0; i < files.files.length; i++) {
        images.add(File(files.files[i].path!));
      }
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;  
}
