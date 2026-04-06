import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

Future<void> requestPermissionsAndOpenCamera(
    Function(File image) onImageSelected) async {

  // Camera permission
  var cameraStatus = await Permission.camera.request();

  // Storage permission
  PermissionStatus storageStatus;

  if (Platform.isAndroid) {
    storageStatus = await Permission.storage.request();
  } else {
    storageStatus = await Permission.photos.request();
  }

  // If granted
  if (cameraStatus.isGranted && storageStatus.isGranted) {

    final ImagePicker picker = ImagePicker();

    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80,
    );

    if (image != null) {
      File imageFile = File(image.path);

      // 🔥 RETURN IMAGE VIA CALLBACK
      onImageSelected(imageFile);
    }
  }

  // ❌ Denied
  else if (cameraStatus.isDenied || storageStatus.isDenied) {
    print("Permission denied ❌");
  }

  // ⚠️ Permanently denied
  else if (cameraStatus.isPermanentlyDenied ||
      storageStatus.isPermanentlyDenied) {
    Fluttertoast.showToast(
      msg: "Please enable permission from settings",
      gravity: ToastGravity.BOTTOM,
    );
    await openAppSettings();
  }
}