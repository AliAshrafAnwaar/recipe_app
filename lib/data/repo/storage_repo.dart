import 'dart:io';
import 'package:recipe_app/data/services/storage_services/storage_services.dart';

class StorageRepo {
  final StorageService _storageService = StorageService();

  // Upload an image and get the download URL
  Future<String> uploadImage(File imageFile, String path) async {
    return await _storageService.uploadImage(imageFile, path);
  }

  // Compress an image to a target size
  Future<File> compressImageToTargetSize(File imageFile, int size) async {
    return await _storageService.compressImageToTargetSize(imageFile, size);
  }
}
