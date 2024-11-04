import 'package:flutter/material.dart';
import 'upload_dialog.dart';
import 'pet_record.dart';
import 'view_file_screen.dart';
import 'pet_screen1.dart'; // Import Pet Screen 1
import 'pet_screen2.dart'; // Import Pet Screen 2

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pet Health Records',
      theme: ThemeData(
        brightness: Brightness.dark, // Set to dark mode
        primarySwatch: Colors.green,
        scaffoldBackgroundColor: const Color(0xFF121212), // Dark background color
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B1B1B), // Darker app bar
          elevation: 0,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), // Use appropriate text styles
          bodyMedium: TextStyle(color: Colors.white70),
          headlineMedium: TextStyle(color: Colors.white), // Update headline style
        ),
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // Define the screens
  final List<Widget> _screens = [
    ManageMedicalRecordsScreen(),
    PetScreen1(),
    PetScreen2(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1B1B1B), // Same color as the app bar
        selectedItemColor: const Color(0xFFEDB200),
        unselectedItemColor: Colors.white54,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Pet Screen 1',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pets),
            label: 'Pet Screen 2',
          ),
        ],
      ),
    );
  }
}

class ManageMedicalRecordsScreen extends StatefulWidget {
  const ManageMedicalRecordsScreen({super.key});

  @override
  _ManageMedicalRecordsScreenState createState() =>
      _ManageMedicalRecordsScreenState();
}

class _ManageMedicalRecordsScreenState
    extends State<ManageMedicalRecordsScreen> with SingleTickerProviderStateMixin {
  final Color customGreen = const Color(0xFFEDB200);
  List<PetRecord> petRecords = [];
  bool _isLoading = false;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCirc,
      ),
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCirc,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addPetRecord(PetRecord record) {
    setState(() {
      petRecords.add(record);
    });
  }

  Future<void> _showUploadDialog() async {
    final result = await showDialog<PetRecord>(
      context: context,
      builder: (context) => UploadDialog(),
    );
    if (result != null) {
      setState(() {
        _isLoading = true;
      });

      await Future.delayed(const Duration(seconds: 2));

      _addPetRecord(result);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Report Uploaded Successfully. You can now view the report."),
        ),
      );

      _controller.reverse();

      setState(() {
        _isLoading = false;
      });
    }

    _controller.reverse();
  }

  void _onUploadButtonPressed() {
    _controller.forward().then((_) => _showUploadDialog());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(180),
        child: AppBar(
          backgroundColor: customGreen,
          elevation: 0,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(height: 10),
                  const Text('Manage Medical',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                  const Text('Records',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            color: const Color(0xFF1B1B1B), // Dark container background
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Manage your pet's health records all in one place.",
                    style: TextStyle(fontSize: 16, color: Colors.white70)), // Adjusted text color
                const SizedBox(height: 20),

                Center(
                  child: ScaleTransition(
                    scale: _scaleAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: SizedBox(
                        width: 260,
                        child: ElevatedButton.icon(
                          onPressed: _onUploadButtonPressed,
                          icon: const Icon(Icons.upload_file, color: Colors.white),
                          label: const Text('Upload Records', style: TextStyle(fontSize: 18, color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: customGreen,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            shadowColor: Colors.black45,
                            elevation: 5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                if (_isLoading) ...[
                  const Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10),
                        Text('Updating Records', style: TextStyle(fontSize: 16, color: Colors.white)), // Adjusted text color
                      ],
                    ),
                  ),
                ] else ...[
                  if (petRecords.isEmpty)
                    const Center(
                      child: Column(
                        children: [
                          SizedBox(height: 16),
                          Text(
                            'No records history yet',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Adjusted text color
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Your uploaded records will appear here.',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Uploaded Records',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)), // Adjusted text color
                        const SizedBox(height: 10),
                        Wrap(
                          spacing: 16,
                          children: petRecords
                              .map((record) => GestureDetector(
                                    onTap: () => _showPetFiles(record),
                                    child: Column(
                                      children: [
                                        Hero(
                                          tag: record.petName,
                                          child: const CircleAvatar(
                                            radius: 30,
                                            backgroundImage: AssetImage(
                                                'assets/images/dummy_dog_face.png'),
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(record.petName,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)), // Adjusted text color
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
                      ],
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showPetFiles(PetRecord record) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('${record.petName} Files', style: const TextStyle(color: Colors.white)), // Adjusted text color
          content: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ViewFileScreen(filePath: record.filePath),
              ));
            },
            child: ListTile(
              leading: const Icon(Icons.insert_drive_file, color: Colors.blue),
              title: Text(
                record.fileName,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white, // Adjusted text color
                ),
              ),
              trailing: const Icon(Icons.arrow_forward, color: Colors.grey),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close', style: TextStyle(color: Colors.white)), // Adjusted text color
            ),
          ],
        );
      },
    );
  }
}