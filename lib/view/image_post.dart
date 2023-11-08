// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class UploadImage extends StatefulWidget {
  const UploadImage({super.key});

  @override
  State<UploadImage> createState() => _ImagePostState();
}

class _ImagePostState extends State<UploadImage> {
  File? image;
  final picker = ImagePicker();
  bool isLoading = false;

  Future<void> getImage() async {
    setState(() {
      isLoading = true;
    });

    final picked =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      setState(() {
        image = File(picked.path);
        isLoading = false;
      });
    } else {
      setState(() {
        // image = File(picked.path);
        isLoading = false;
      });
      print("image not selected");
    }
  }

  Future<void> uploadImage() async {
    var stream = http.ByteStream(image!.openRead());
    stream.cast();
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = http.MultipartRequest('POST', uri);

    request.fields['title'] = 'product11';
    request.fields['price'] = '1221';
    var multpart = http.MultipartFile('image', stream, length);

    request.files.add(multpart);
    var response = await request.send();

    print('response ====> ${response.stream.toString()}');

    if (response.statusCode == 200) {
      print('image uploaded');
    } else {
      print('image failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              await getImage();
            },
            child: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: image == null
                        ? const Center(
                            child: Text("pick image"),
                          )
                        : SizedBox(
                            height: 200,
                            width: 200,
                            child: Image.file(File(image!.path).absolute),
                          ),
                  ),
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              await uploadImage();
            },
            child: const Text('Upload'),
          )
        ],
      ),
    );
  }
}
