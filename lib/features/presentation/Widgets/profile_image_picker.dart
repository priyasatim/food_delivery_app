import 'dart:io';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/features/presentation/Widgets/request_storage_permission.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File?> _openGallery() async {
  final picked = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  return picked != null ? File(picked.path) : null;
}


void showImagePickerOptions(

    BuildContext context, {
      required Function(File image) onImageSelected,
    }) {
  showModalBottomSheet(
    context: context,
    builder: (_) {
      return SafeArea(
        child: Wrap(
          children: [
            
            /// Camera
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text("Camera"),
              onTap: () {
                Navigator.pop(context);

                requestPermissionsAndOpenCamera((image) {
                  onImageSelected(image);
                });
              },
            ),

            /// Gallery
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
              onTap: () async {
                Navigator.pop(context);

                File? image = await _openGallery();

                if (image != null) {
                  onImageSelected(image);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}

Future<File> saveImageLocally(File image) async {
  final directory = await getApplicationDocumentsDirectory();

  final String path = directory.path;

  final String fileName = DateTime.now().millisecondsSinceEpoch.toString();

  final File newImage = await image.copy('$path/$fileName.jpg');

  return newImage;
}

