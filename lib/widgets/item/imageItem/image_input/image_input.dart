import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';
import 'package:note_taking_app/widgets/item/imageItem/image_input/utils/camera_device_provider.dart';
import 'package:note_taking_app/widgets/item/imageItem/image_input/utils/image_source_provider.dart';

class MyImageInput extends StatefulWidget {
  final Function(Uint8List) setImage;

  const MyImageInput({super.key, required this.setImage});

  @override
  State<MyImageInput> createState() => _MyImageInputState();
}

class _MyImageInputState extends State<MyImageInput> {
  final List<XFile> _imageInputImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: ImageInput(
              images: _imageInputImages,
              allowEdit: true,
              allowMaxImage: 1,
              getPreferredCameraDevice: () async =>
                  await CameraDeviceProvider().getPreferredCameraDevice(context),
              getImageSource: () async =>
                  await ImageSourceProvider().getImageSource(context),
              onImageSelected: _onImageSelected,
              onImageRemoved: _onImageRemoved,
              loadingBuilder: (context, progress) => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onImageSelected(image) async {
    var b = await image.readAsBytes();
    setState(() {
      _imageInputImages.add(image);
      widget.setImage(b);
    });
  }

  void _onImageRemoved(image, index) {
    setState(() {
      _imageInputImages.remove(image);
    });
  }
}