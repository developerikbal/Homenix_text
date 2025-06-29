import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:homeonix/services/firebase_storage_service.dart';
import 'package:homeonix/utils/file_compressor.dart';

class ImageUploadWidget extends StatefulWidget {
  final Function(String) onUploadComplete; // Upload শেষে parent callback
  final bool compressBeforeUpload;         // আপলোডের আগে compress করা হবে কি না

  const ImageUploadWidget({
    Key? key,
    required this.onUploadComplete,
    this.compressBeforeUpload = true,
  }) : super(key: key);

  @override
  State<ImageUploadWidget> createState() => _ImageUploadWidgetState();
}

class _ImageUploadWidgetState extends State<ImageUploadWidget> {
  File? _imageFile;
  bool _isUploading = false;

  // গ্যালারি বা ক্যামেরা থেকে ছবি নেয়
  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);

      if (pickedFile != null) {
        File selectedFile = File(pickedFile.path);

        if (widget.compressBeforeUpload) {
          selectedFile = await FileCompressor.compressImage(selectedFile);
        }

        setState(() {
          _imageFile = selectedFile;
        });

        await _uploadImage(selectedFile);
      }
    } catch (e) {
      debugPrint('Image picking failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image selection failed')),
      );
    }
  }

  // Firebase-এ ছবি আপলোড করে এবং URL ফেরত দেয়
  Future<void> _uploadImage(File image) async {
    try {
      setState(() => _isUploading = true);

      final downloadUrl = await FirebaseStorageService.uploadImage(image);
      widget.onUploadComplete(downloadUrl);

    } catch (e) {
      debugPrint('Image upload failed: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image upload failed')),
      );
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (_imageFile != null)
          Image.file(
            _imageFile!,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
          ),
        const SizedBox(height: 12),
        if (_isUploading)
          const CircularProgressIndicator()
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                icon: const Icon(Icons.photo),
                label: const Text("Gallery"),
                onPressed: () => _pickImage(ImageSource.gallery),
              ),
              const SizedBox(width: 10),
              ElevatedButton.icon(
                icon: const Icon(Icons.camera_alt),
                label: const Text("Camera"),
                onPressed: () => _pickImage(ImageSource.camera),
              ),
            ],
          ),
      ],
    );
  }
}