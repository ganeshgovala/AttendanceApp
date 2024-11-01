import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutDeveloperPage extends StatelessWidget {
  final String linkedInUrl = 'https://www.linkedin.com/in/yourprofile';
  final String githubUrl = 'https://github.com/yourprofile';
  final String instagramUrl = 'https://instagram.com/yourprofile';

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About the Developer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              // backgroundImage: AssetImage('assets/profile.jpg'), // Add your profile picture here
            ),
            SizedBox(height: 16),
            Text(
              'Govala Sri Ram Ganesh',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'B.Tech Student | Web and App Developer | UI/UX Enthusiast',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
            SizedBox(height: 24),
            Text(
              'I am a passionate developer with a focus on web and mobile app development. '
              'I enjoy solving real-world problems through technology and continuously strive to improve my skills. '
              'Feel free to connect with me on my social profiles below!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.linkedin, color: Colors.blue),
                  onPressed: () => _launchURL(linkedInUrl),
                ),
                SizedBox(width: 16),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.github, color: Colors.black),
                  onPressed: () => _launchURL(githubUrl),
                ),
                SizedBox(width: 16),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.instagram, color: Colors.pink),
                  onPressed: () => _launchURL(instagramUrl),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
