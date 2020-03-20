import 'dart:async';
import 'dart:html' as html;

class WebImagePicker {
  Future<html.File> pickFile(String type) async {
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input..accept = '$type/*';
    input.click();
    await input.onChange.first;
    if (input.files.isEmpty) return null;
    return input.files[0];
  }

  Future<Map<String, dynamic>> pickImage() async {
    final Map<String, dynamic> data = {};
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input..accept = 'image/*';
    input.click();
    await input.onChange.first;
    if (input.files.isEmpty) return null;
    final reader = html.FileReader();
    reader.readAsDataUrl(input.files[0]);
    await reader.onLoad.first;
    final encoded = reader.result as String;
    final stripped =
        encoded.replaceFirst(RegExp(r'data:image/[^;]+;base64,'), '');
    final videoName = input.files?.first?.name;
    final videoPath = input.files?.first?.relativePath;
    data.addAll({
      'name': videoName,
      'data': stripped,
      'data_scheme': encoded,
      'path': videoPath
    });
    return data;
  }

  Future<Map<String, dynamic>> pickVideo() async {
    final Map<String, dynamic> data = {};
    final html.FileUploadInputElement input = html.FileUploadInputElement();
    input..accept = 'video/*';
    input.click();
    await input.onChange.first;
    if (input.files.isEmpty) return null;
    final reader = html.FileReader();
    reader.readAsDataUrl(input.files[0]);
    await reader.onLoad.first;
    final encoded = reader.result as String;
    final stripped =
        encoded.replaceFirst(RegExp(r'data:video/[^;]+;base64,'), '');
    final videoName = input.files?.first?.name;
    final videoPath = input.files?.first?.relativePath;
    data.addAll({
      'name': videoName,
      'data': stripped,
      'data_scheme': encoded,
      'path': videoPath
    });
    return data;
  }
}
