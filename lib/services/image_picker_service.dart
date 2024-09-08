import 'package:b2clients/services/firebase_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ImagePickerService {
  FirebaseUtils firebaseUtils = FirebaseUtils();
  final currentUserUID = FirebaseAuth.instance.currentUser!.uid;
  // OPEN USER GALLERY
  void submitImage() async {
    Uint8List? img = await chooseImage(ImageSource.gallery);

    if (img != null) {
      saveData(img);
    }
  }

  // CHOOSE IMAGE FROM USER GALLERY
  chooseImage(ImageSource source) async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: source);
    if (file != null) {
      return await file.readAsBytes();
    }
  }

  // UPLOAD CHOOSEN IMAGE TO CLOUD STORAGE AND RETURN URL FOR ADDING TO USER ACCOUNT DATA
  Future<String> uploadImageToCloudStorage(
      String childName, Uint8List file) async {
    Reference reference = FirebaseStorage.instance.ref().child(childName);
    UploadTask uploadTask = reference.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future saveData(Uint8List file) async {
    String imageURL = await uploadImageToCloudStorage(
        '${currentUserUID}_profile_image', file);

    firebaseUtils.updateUserAccountData(
        {'profile_image': imageURL, 'update_time': Timestamp.now()});
    FirebaseAuth.instance.currentUser!.updatePhotoURL(imageURL);
  }
}
