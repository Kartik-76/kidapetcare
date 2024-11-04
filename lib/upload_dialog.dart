import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'pet_record.dart';

class UploadDialog extends StatefulWidget {
  const UploadDialog({super.key});

  @override
  _UploadDialogState createState() => _UploadDialogState();
}

class _UploadDialogState extends State<UploadDialog>
    with SingleTickerProviderStateMixin {
  String fileName = '';
  String filePath = '';
  String selectedPet = '';
  final List<String> petOptions = ['Buddy', 'Max', 'Bella', 'Charlie', 'Rocky'];

  bool isUploading = false;
  bool isFilePicked = false;
  bool isUploadCompleted = false;

  late AnimationController _controller;
  late Animation<double> _arrowPosition;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _arrowPosition = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            isUploadCompleted = true;
          });
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf', 'doc', 'txt']);

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
        filePath = result.files.single.path!;
        isFilePicked = true;
        isUploadCompleted = false;
      });
    }
  }

  Future<void> _uploadFile() async {
    setState(() {
      isUploading = true;
      isUploadCompleted = false;
    });

    _controller.forward(); // Start the arrow animation

    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      isUploading = false;
      isUploadCompleted = true;
    });

    await Future.delayed(const Duration(seconds: 1));
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
                  ? (isUploadCompleted ? const Icon(Icons.check_circle, color: Colors.green) : null)
                  : null,
            ),
            controller: TextEditingController(text: fileName),
            onTap: _pickFile,
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
        GestureDetector(
          onTap: () {
            if (fileName.isNotEmpty && selectedPet.isNotEmpty && filePath.isNotEmpty && !isUploading) {
              _uploadFile();
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            width: 220,  // Increased width for the button
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: Colors.amber, // Retains amber color throughout
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Center Text
                Text(
                  isUploadCompleted ? 'Uploaded' : 'Upload',
                  style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                // Circular Icon integrated on the Right Edge
                Positioned(
                  right: 0, // Positioned exactly on the right edge
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Colors.amber,
                      shape: BoxShape.circle,
                    ),
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, _arrowPosition.value * 30),
                          child: Icon(
                            isUploadCompleted ? Icons.check : Icons.arrow_upward,
                            color: Colors.white,
                            size: 20,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}