import 'package:flutter/material.dart';


class PrivacyPolicyPage extends StatelessWidget {
  final String privacyText = '''
PetPal Privacy Policy

Effective Date: September 9, 2025

PetPal (“we,” “our,” or “us”) respects your privacy and is committed to protecting your personal information. This Privacy Policy explains how we collect, use, and share information when you use the PetPal mobile app (“App”). By using PetPal, you agree to the terms of this Privacy Policy.

1. Information We Collect
a. Personal Information
- Name and email address
- Profile information for your pets (name, type, breed, age)

b. Usage Information
- App activity and preferences
- Notifications and reminders settings
- Device information (model, OS version, app version)

c. Cookies and Analytics
- We may use analytics tools to understand App usage and improve the user experience. These tools do not personally identify you.

2. How We Use Your Information
- Provide and personalize the App experience
- Send reminders and notifications about your pets
- Improve App features and performance
- Communicate important updates, offers, or support messages

3. How We Share Your Information
- We do not sell your personal information. We may share information:
  - With service providers who help us operate the App
  - When required by law or to protect rights and safety
  - In aggregated or anonymized form for analytics or research

4. Security
- We take reasonable measures to protect your information, but no method is 100% secure. You are responsible for keeping your login credentials safe.

5. Your Choices
- Update or delete your profile information
- Disable notifications in the App
- Contact us to request data deletion

6. Children’s Privacy
- PetPal is not intended for children under 13. We do not knowingly collect personal information from children.

7. Changes to This Policy
- We may update this Privacy Policy occasionally. We will notify you within the App or by email if significant changes occur.

8. Contact Us
- If you have questions or concerns about this Privacy Policy, please contact us at:
  Email: support@petpalapp.com
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Text(
            privacyText,
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      ),
    );
  }
}
