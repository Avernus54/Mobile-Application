import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AddReminderPage extends StatefulWidget {
  const AddReminderPage({super.key});

  @override
  State<AddReminderPage> createState() => _AddReminderPageState();
}

class _AddReminderPageState extends State<AddReminderPage> {
  final SupabaseClient supabase = Supabase.instance.client;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _remindAt;

  Future<void> _pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          _remindAt = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  Future<void> _saveReminder() async {
    if (_titleController.text.isEmpty || _remindAt == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter title and time")),
      );
      return;
    }

    await supabase.from('reminders').insert({
      'title': _titleController.text,
      'description': _descriptionController.text,
      'remind_at': _remindAt!.toIso8601String(),
    });

    Navigator.pop(context, true); // return true to refresh list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Reminder"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Title Input
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Reminder Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Description Input
            TextField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: "Description",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Date Time Picker
            Row(
              children: [
                Expanded(
                  child: Text(
                    _remindAt != null
                        ? "Remind at: ${_remindAt.toString()}"
                        : "No time selected",
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: _pickDateTime,
                  icon: const Icon(Icons.access_time),
                  label: const Text("Pick Time"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const Spacer(),

            // Save Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveReminder,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text(
                  "Save Reminder",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
