import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/privacypolicy.dart';
import 'package:flutter_application_1/LoginForms/login.dart';
void main() {
  runApp(PetPalApp());
}

class PetPalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PetPal',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.system,
      home: SettingsScreen(),
    );
  }
}

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _isDarkMode = false;
  String _selectedLanguage = 'English';

  final List<String> _languages = ['English', 'Spanish', 'French', 'German', 'Chinese'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Manage Pets'),
            leading: Icon(Icons.pets),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PetsPage()),
              );
            },
          ),
          SwitchListTile(
            title: Text('Enable Notifications'),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
            secondary: Icon(Icons.notifications),
          ),
          SwitchListTile(
            title: Text('Dark Mode'),
            value: _isDarkMode,
            onChanged: (bool value) {
              setState(() {
                _isDarkMode = value;
              });
            },
            secondary: Icon(Icons.dark_mode),
          ),
          ListTile(
            title: Text('Language'),
            subtitle: Text(_selectedLanguage),
            leading: Icon(Icons.language),
            onTap: () {
              _showLanguageDialog();
            },
          ),
          ListTile(
            title: Text('Privacy Policy'),
            leading: Icon(Icons.privacy_tip),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
              );
            },
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.logout),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInScreen()),
              );
              // Perform logout
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Language'),
          content: SingleChildScrollView(
            child: Column(
              children: _languages.map((language) {
                return RadioListTile<String>(
                  title: Text(language),
                  value: language,
                  groupValue: _selectedLanguage,
                  onChanged: (String? value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

// Pets Page
class PetsPage extends StatelessWidget {
  final List<String> pets = ['Buddy', 'Charlie', 'Max', 'Luna', 'Bella'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Pets'),
      ),
      body: ListView.builder(
        itemCount: pets.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(Icons.pets),
            title: Text(pets[index]),
            onTap: () {
              // Navigate to pet details if needed
            },
          );
        },
      ),
    );
  }
}
