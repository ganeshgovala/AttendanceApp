import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TermsAndConditionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Updated: 1/11/2024',
              style: GoogleFonts.ubuntu(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              'Welcome to our Attendance App! Before you start using our app, please read these Terms and Conditions carefully. By using the app, you agree to comply with these terms.',
              style: GoogleFonts.ubuntu(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '1. User Data and Privacy',
              style: GoogleFonts.ubuntu(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '• We collect your password solely for authentication purposes to ensure secure access to your account. We do not store or share your password with third parties.\n'
              '• Your data, including attendance records and settings, are stored securely and will only be accessible to you.',
              style: GoogleFonts.ubuntu(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '2. Security of Your Information',
              style: GoogleFonts.ubuntu(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '• We take the security of your information seriously and use standard security practices to protect your data.\n'
              '• Although we strive to safeguard your information, we cannot guarantee absolute security. Please keep your password confidential and avoid sharing it with others.',
              style: GoogleFonts.ubuntu(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '3. Use of the App',
              style: GoogleFonts.ubuntu(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '• This app is intended to help you track your attendance. You agree to use the app only for this purpose and in compliance with all applicable laws.\n'
              '• We reserve the right to limit or revoke access to the app if we detect unauthorized or harmful use.',
              style: GoogleFonts.ubuntu(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '4. Predicted Bunkable Classes',
              style: GoogleFonts.ubuntu(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '• The predicted bunkable classes feature is solely based on the attendance data retrieved from the ECAP website. We are not responsible for any discrepancies or inaccuracies if the ECAP attendance is not updated.',
              style: GoogleFonts.ubuntu(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '5. Limitation of Liability',
              style: GoogleFonts.ubuntu(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '• We are not liable for any data loss or unauthorized access that may occur due to factors beyond our control. Please ensure you use strong passwords and secure your device.',
              style: GoogleFonts.ubuntu(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '6. Modifications to Terms',
              style: GoogleFonts.ubuntu(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              '• We may update these Terms and Conditions periodically. If we make significant changes, we will notify you via the app. Your continued use of the app implies acceptance of the updated terms.',
              style: GoogleFonts.ubuntu(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.0),
            Text(
              '7. Contact Us',
              style: GoogleFonts.ubuntu(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              'If you have any questions regarding our Terms and Conditions or privacy practices, please contact us at [Your Email].\n'
              'Thank you for using the Attendance App responsibly!',
              style: GoogleFonts.ubuntu(
                fontSize: 13,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
