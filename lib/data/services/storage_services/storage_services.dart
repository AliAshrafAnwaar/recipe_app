import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(File imageFile, String path) async {
    try {
      Reference storageReference = _storage
          .ref()
          .child('$path${DateTime.now().millisecondsSinceEpoch}.jpg');
      UploadTask uploadTask = storageReference.putFile(imageFile);
      TaskSnapshot taskSnapshot = await uploadTask;
      String downloadUrl = await taskSnapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      throw Exception('Error uploading image: $e');
    }
  }

  Future<File> compressImageToTargetSize(
      File imageFile, int maxSizeInKB) async {
    // Read the image file as bytes
    Uint8List imageBytes = await imageFile.readAsBytes();

    // Decode the image
    img.Image? decodedImage = img.decodeImage(imageBytes);
    if (decodedImage == null) {
      throw Exception("Failed to decode image");
    }

    // Initialize quality and compressed image bytes
    int quality = 100;
    List<int> compressedImageBytes;

    do {
      // Compress the image with current quality
      compressedImageBytes = img.encodeJpg(decodedImage, quality: quality);

      // Decrease quality for next iteration
      quality -= 10; // Adjust decrement step if needed
    } while (compressedImageBytes.length > maxSizeInKB * 1024 && quality > 0);

    // Write the compressed image to a new file
    final File compressedImageFile =
        File(imageFile.path.replaceFirst('.jpg', '_compressed.jpg'));
    await compressedImageFile.writeAsBytes(compressedImageBytes);

    return compressedImageFile;
  }
}
