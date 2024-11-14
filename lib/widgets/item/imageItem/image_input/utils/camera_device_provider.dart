import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';
import 'package:permission_handler/permission_handler.dart';

class CameraDeviceProvider {
  CameraDeviceProvider._internal();

  static final CameraDeviceProvider _instance = CameraDeviceProvider._internal();

  factory CameraDeviceProvider() {
    return _instance;
  }

  Future<CameraDevice?> getPreferredCameraDevice(BuildContext context) async {
    var status = await Permission.camera.request();
    if (status.isDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Allow Camera Permission"),
        ),
      );
      return null;
    }
    return showDialog<CameraDevice>(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              child: const Text("Rear"),
              onPressed: () {
                Navigator.of(context).pop(CameraDevice.rear);
              },
            ),
            SimpleDialogOption(
                child: const Text("Front"),
                onPressed: () {
                  Navigator.of(context).pop(CameraDevice.front);
                }),
          ],
        );
      },
    ).then(
      (value) {
        return value ?? CameraDevice.rear;
      },
    );
  }

}