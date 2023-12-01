import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(ProfileApp());
}

class ProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage: CachedNetworkImageProvider(
                    'https://example.com/your_profile_picture_url.jpg', // Replace with your profile picture URL
                  ),
                ),
                SizedBox(height: 16),
                IconButton(
                  // ignore: deprecated_member_use
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Implement edit functionality for the profile picture
                  },
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Name',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('John Doe'),
          ),
          ListTile(
            title: Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('johndoe@example.com'),
          ),
          ListTile(
            title: Text(
              'Phone',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('+1 (123) 456-7890'),
          ),
          ListTile(
            title: Text(
              'Address',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('123 Main St, City, Country'),
          ),
          ListTile(
            title: Text(
              'Gov ID',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('XXX-XXX-XXXX'),
          ),
          ListTile(
            title: Text(
              'Gender',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text('Male'),
          ),
          ElevatedButton(
            onPressed: () {
              // Implement edit request functionality
            },
            child: Text('Edit Request'),
          ),
        ],
      ),
    );
  }
}
