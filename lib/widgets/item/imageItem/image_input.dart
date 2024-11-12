import 'package:flutter/material.dart';
import 'package:image_input/image_input.dart';
import 'package:note_taking_app/widgets/item/imageItem/utils/camera_device_provider.dart';
import 'package:note_taking_app/widgets/item/imageItem/utils/image_source_dialog.dart';

class MyImageInput extends StatefulWidget {
  const MyImageInput({super.key});

  @override
  State<MyImageInput> createState() => _MyImageInputState();
}

class _MyImageInputState extends State<MyImageInput> {
  List<XFile> imageInputImages = [];
  List<Image> images = [];

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
                print(image.path);
                print(image.name);

                var img = Image.memory(b, fit: BoxFit.contain);


                setState(() {
                  imageInputImages.add(image);
                  images.add(img);
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

          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: images,
          //   ),
          // ),

        ],
      ),
    );
  }
}