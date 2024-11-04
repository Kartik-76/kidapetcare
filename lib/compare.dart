

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'pet_record.dart';

class UploadDialog extends StatefulWidget {
  const UploadDialog({super.key});

  @override
  _UploadDialogState createState() => _UploadDialogState();
}

class _UploadDialogState extends State<UploadDialog> {
  String fileName = '';
  String filePath = '';
  String selectedPet = '';
  final List<String> petOptions = ['Buddy', 'Max', 'Bella', 'Charlie', 'Rocky'];

  bool isUploading = false; // To track the upload state
  bool isFilePicked = false; // To track if the file is picked
  bool isUploadCompleted = false; // To track if upload is completed

  Future<void> _pickFile() async {
    // Open the file picker
    final result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc', 'txt']);
    
    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
        filePath = result.files.single.path!;
        isFilePicked = true; // Set the file picked state
        isUploadCompleted = false; // Reset upload completion state
      });
    }
  }

  Future<void> _uploadFile() async {
    // Start the uploading state
    setState(() {
      isUploading = true; // Set uploading state
      isUploadCompleted = false; // Reset upload completed state
    });

    // Simulate a network request or upload process
    await Future.delayed(const Duration(seconds: 2)); // Simulate delay for upload

    // Once the upload is complete
    setState(() {
      isUploading = false; // Stop uploading state
      isUploadCompleted = true; // Set upload completed state
    });

    // After a delay, navigate back with the PetRecord
    await Future.delayed(const Duration(seconds: 1)); // Delay before popping
    Navigator.of(context).pop(PetRecord(petName: selectedPet, fileName: fileName, filePath: filePath));
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(16),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(''),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.upload_file, size: 40, color: Colors.grey),
          const SizedBox(height: 10),
          const Text('Upload Records', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          TextField(
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'File Name:',
              hintText: 'Choose a file',
              suffixIcon: isFilePicked
                  ? (isUploadCompleted ? const Icon(Icons.check_circle, color: Colors.green) : null) // Show green tick if upload is completed
                  : null,
            ),
            controller: TextEditingController(text: fileName),
            onTap: _pickFile, // Open file picker when tapped
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: selectedPet.isNotEmpty ? selectedPet : null,
            items: petOptions.map((pet) => DropdownMenuItem(value: pet, child: Text(pet))).toList(),
            onChanged: (value) {
              setState(() {
                selectedPet = value!;
              });
            },
            decoration: const InputDecoration(labelText: 'Pet Name:'),
          ),
          const SizedBox(height: 20),
        ],
      ),
      actions: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: isUploading
              ? const CircularProgressIndicator() // Show a progress indicator while uploading
              : Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (fileName.isNotEmpty && selectedPet.isNotEmpty && filePath.isNotEmpty) {
                            _uploadFile(); // Call the upload function
                          }
                        },
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 40), // Placeholder for icon
                            Text(
                              'Upload',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      child: Container(
                        height: 50, // Set the height of the icon box
                        width: 50, // Set the width of the icon box
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.amber.shade700, // Slightly darker color
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(Icons.cloud_upload, color: Colors.white),
                      ),
                    ),
                  ],
                ),
        ),
      ],
    );
  }
}
