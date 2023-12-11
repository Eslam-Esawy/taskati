import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taskati/core/app_colors.dart';
import 'package:taskati/core/app_local_storage.dart';
import 'package:taskati/feature/home/home_view.dart';

String? imagePath;
String name = '';

class UploadView extends StatefulWidget {
  const UploadView({super.key});

  @override
  State<UploadView> createState() => _UploadViewState();
}

var nameCon = TextEditingController();

class _UploadViewState extends State<UploadView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                if (imagePath != null && name.isNotEmpty) {
                  AppLocal.cacheData(AppLocal.nameKey, name);
                  AppLocal.cacheBool(AppLocal.isUpload, true);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomeView()));
                } else if (imagePath == null && name.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content:
                          Text('Please Upload an image and enter your name')));
                } else if (imagePath == null) {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Please Upload an image')));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Please enter your name')));
                }
              },
              child: Text(
                'Done',
                style: TextStyle(color: AppColors.primaryColor),
              ))
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //The image
                CircleAvatar(
                  radius: 75,
                  backgroundImage: (imagePath != null)
                      ? FileImage(File(imagePath!)) as ImageProvider
                      : const AssetImage('assets/user.png'),
                ),
                const SizedBox(height: 20),

                //The line under the screen
                Divider(
                  color: AppColors.primaryColor,
                  thickness: 1,
                  indent: 30,
                  endIndent: 30,
                ),

                const SizedBox(height: 10),

                //The name box
                TextFormField(
                  onChanged: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  controller: nameCon,
                  decoration: InputDecoration(
                    hintText: 'Enter your name here',
                    hintStyle: TextStyle(color: AppColors.primaryColor),
                    fillColor: AppColors.primaryColor,
                    suffixIcon: Icon(
                      Icons.edit,
                      color: AppColors.primaryColor,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.primaryColor),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    border: InputBorder.none,
                  ),
                ),
                const SizedBox(height: 20),

                //Upload from Camera button
                GestureDetector(
                  onTap: () {
                    getImageFromCamera();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Upload from Camera',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                //Upload from Gallery button
                GestureDetector(
                  onTap: () {
                    getImageFromGallery();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 40,
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(15)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          color: Colors.white,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Upload from Gallery',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getImageFromCamera() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedImage != null) {
      AppLocal.cacheData(AppLocal.imageKey, pickedImage.path);
      setState(() {
        imagePath = pickedImage.path;
      });
    }
  }

  getImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      AppLocal.cacheData(AppLocal.imageKey, pickedImage.path);
      setState(() {
        imagePath = pickedImage.path;
      });
    }
  }
}
