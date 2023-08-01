import 'dart:io';
import 'package:brush/constant/widget/loading.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePickerController extends GetxController {
  PickedFile? pickedFile;
  List<File> selectedImages = <File>[].obs;
  List<String> images = <String>[].obs;
  var downloadURL = ''.obs;

  Future<List<String>> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickImage(source: source);

    if (pickedFiles != null) {
      pickedFile = PickedFile(pickedFiles.path);
      selectedImages = [File(pickedFiles.path)];
      update();
    }
    return uploadImagesToFirebase(selectedImages);
  }

  Future<List<String>> pickMulti() async {
    final picker = ImagePicker();
    final pickedFiles = await picker.pickMultiImage();
    if (pickedFiles.isNotEmpty) {
      selectedImages.assignAll(
          pickedFiles.map((pickedFile) => File(pickedFile.path)).toList());
    }
    if (selectedImages.isEmpty) {
      return [];
    }
    return uploadImagesToFirebase(selectedImages);
  }

  Future<List<String>> uploadImagesToFirebase(List selectedImages) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(
          text: ' ... تحميل ',
        );
      },
    );
    final storage = FirebaseStorage.instance;
    List<String> listImages = <String>[].obs;
    for (var image in selectedImages) {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference = storage.ref().child('images/$fileName');
      final uploadTask = reference.putFile(image);

      final snapshot =
          await uploadTask.whenComplete(() => print('Image uploaded'));
      final imageUrl = await snapshot.ref.getDownloadURL();
      listImages.add(imageUrl);
      update();
    }
    SmartDialog.dismiss();
    return listImages;
  }

  Future<void> uploadAssetImages(List<String> assetPaths) async {
    SmartDialog.showLoading(
      animationBuilder: (controller, child, animationParam) {
        return Loading(
          text: ' ... تحميل ',
        );
      },
    );
    for (String assetPath in assetPaths) {
      // Read the asset image as bytes
      ByteData byteData = await rootBundle.load(assetPath);

      // Create a reference to the location in Firebase Storage where you want to store the image
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.png');
      UploadTask uploadTask =
          storageReference.putData(byteData.buffer.asUint8List());
      await uploadTask.whenComplete(() async {
        downloadURL.value = await storageReference.getDownloadURL();
        SmartDialog.dismiss();
      });
    }
  }
}
