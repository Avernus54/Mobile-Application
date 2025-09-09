import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/reminder.dart';
import 'package:flutter_application_1/services/SessionManager.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// import your AddReminderPage


class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final SupabaseClient supabase = Supabase.instance.client;

  List<Map<String, dynamic>> pets = [];
  List<Map<String, dynamic>> reminders = [];

  @override
  void initState() {
    super.initState();
    _fetchPets();
    _fetchReminders();
  }

  Future<void> _fetchPets() async {
    final response = await supabase.from('pets').select();
    setState(() {
      pets = List<Map<String, dynamic>>.from(response);
    });
  }

  Future<void> _fetchReminders() async {
    final response =
        await supabase.from('reminders').select().order('remind_at');
    setState(() {
      reminders = List<Map<String, dynamic>>.from(response);
    });
  }

  @override
  Widget build(BuildContext context) {
    final session = Provider.of<SessionManager>(context);
    final fullname = session.fullname ?? "User";

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFFF7F8FA),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.teal[100],
                  child: const Icon(Icons.person, color: Colors.teal, size: 32),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Hello, $fullname",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Welcome back to PetPal',
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Pet cards
            pets.isEmpty
                ? const Center(
                    child: Text("No pets found. Add some pets!"),
                  )
                : Column(
                    children: pets.map((pet) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 28,
                              backgroundColor: Colors.grey[200],
                              child: const Icon(Icons.pets,
                                  color: Colors.grey, size: 32),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    pet['name'] ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "${pet['type']} • ${pet['age']} years old",
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

            const SizedBox(height: 28),

            // Upcoming Reminders Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Upcoming Reminders',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                TextButton.icon(
                  onPressed: () async {
                    // Open the add reminder page
                    final added = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AddReminderPage (),
                      ),
                    );

                    // Refresh list if user created a reminder
                    if (added == true) {
                      _fetchReminders();
                    }
                  },
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Add'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.teal,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Reminder Cards
            reminders.isEmpty
                ? const Center(
                    child: Text("No reminders yet."),
                  )
                : Column(
                    children: reminders.map((reminder) {
                      final remindAt = DateTime.tryParse(reminder['remind_at']);
                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 6,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.alarm, color: Colors.teal),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    reminder['title'] ?? '',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    remindAt != null
                                        ? "${remindAt.toLocal()}"
                                        : "No time set",
                                    style: const TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
          ],
        ),
      ),
    );
  }
}
