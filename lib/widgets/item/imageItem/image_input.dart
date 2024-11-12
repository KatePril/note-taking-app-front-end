import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';
import 'package:note_taking_app/widgets/item/imageItem/utils/camera_device_provider.dart';
import 'package:note_taking_app/widgets/item/imageItem/utils/image_source_dialog.dart';

class MyImageInput extends StatefulWidget {
  final Function(Uint8List) setImage;

  const MyImageInput({super.key, required this.setImage});

  @override
  State<MyImageInput> createState() => _MyImageInputState(setImage);
}

class _MyImageInputState extends State<MyImageInput> {
  List<XFile> imageInputImages = [];
  final Function(Uint8List) setImage;

  _MyImageInputState(this.setImage);

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
              images: imageInputImages,
              allowEdit: true,
              allowMaxImage: 1,
              getPreferredCameraDevice: () async =>
                  await CameraDeviceProvider().getPreferredCameraDevice(context),
              getImageSource: () async => await ImageSourceProvider().getImageSource(context),

              onImageSelected: (image) async {
                var b = await image.readAsBytes();

                setState(() {
                  imageInputImages.add(image);
                  setImage(b);
                });
              },

              onImageRemoved: (image, index) {
                setState(() {
                  imageInputImages.remove(image);
                });
              },
              loadingBuilder: (context, progress) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}