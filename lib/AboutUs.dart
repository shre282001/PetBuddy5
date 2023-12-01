import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text(
              'About Us',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Your application description goes here.',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsInfoPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Your privacy policy content goes here.',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyPage()),
              );
            },
          ),
          Divider(),
          ListTile(
            title: Text(
              'Terms of Use',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Your terms of use content goes here.',
              style: TextStyle(fontSize: 16),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsOfUsePage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

class AboutUsInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: Center(
        child: Text('About Us Page Content'),
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSection('🐾 Introduction', 'Welcome to PetBuddy! We are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy explains how we collect, use, and protect your data when you use our application. By using [Your App Name], you consent to the practices described in this policy.'),
          _buildSection('🐾 Information We Collect', 'We collect the following types of information:\n\nPersonal Information: This may include your name, email address, phone number, and other information you provide when you register, complete a profile, or use our services.\n\nPet Information: Information you provide about your pets, including names, breeds, and medical records.\n\nLocation Information: We may collect and process information about your location, either through the IP address of your device or through GPS, if you provide your consent.\n\nUsage Data: We collect information on how you use our services, including browsing history, app usage, and interactions with other users.'),
          _buildSection('🐾 How We Use Your Information', 'We use your information for the following purposes:\n\nPet Adoption: Facilitating the adoption process, including connecting pet owners with potential adopters.\n\nService Provision: Providing services such as doctor consultation, pet salon booking, pet training, and mating partner matching.\n\nCommunication: Sending notifications, updates, and information related to our services.\n\nImprovements: Analyzing user data to improve our services, user experience, and app performance.'),
          _buildSection('🐾 Sharing Your Information', 'We may share your information with:\n\nService Providers: Third-party service providers who help us operate the application and deliver our services.\n\nOther Users: Certain information, such as your profile and pet listings, may be visible to other users of the application.'),
          _buildSection('🐾 Your Choices', 'You can control your data in the following ways:\n\nAccount Information: You can update or delete your account information at any time.\n\nLocation Data: You can disable location services through your device settings.'),
          _buildSection('🐾 Security', 'We take security seriously and have implemented measures to protect your data from unauthorized access and use.'),
          _buildSection('🐾 Changes to this Privacy Policy', 'We may update this Privacy Policy from time to time. Any changes will be posted on this page, and the updated policy will be effective upon posting.'),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(fontSize: 16),
        ),
        Divider(),
      ],
    );
  }
}

class TermsOfUsePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms of Use'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          _buildSection('🐾 Privacy', 'Address how user data is collected, stored, and used.'),
          _buildSection('🐾 User Conduct', 'Specify acceptable and prohibited behavior on the platform.'),
          _buildSection('🐾 Intellectual Property', 'Clarify ownership of content shared on the platform.'),
          _buildSection('🐾 Liability', 'Disclaim responsibility for the behavior of pet adopters and pet owners. PETBUDDY team is not responsible at all for any mishandling of pets done by Pet Adopters and Pet owners.'),
          _buildSection('🐾 Add Pet', 'Pet Ownership: Pet Owners must confirm that they have legal ownership documents for adding a pet. Accurate Information: Pet Owners must provide accurate and up-to-date information about the pet. Prohibited Content: Prohibit the listing of dangerous or illegal pets. Photo Rights: The user uploading a pet\'s photo should have the rights to that image.'),
          _buildSection('🐾 Pet Adopter', 'Adoption Process: Specify the process for adopting a pet, including any fees and checks. Age Restrictions: Define the age limit for adopting a pet. Background Checks: Mention if adopters will undergo any background checks.'),
          _buildSection('🐾 Doctor Consult', 'Medical Advice: PetBuddy does not replace professional veterinary advice. Liability: PetBuddy app is not responsible for the consequences of medical advice.'),
          _buildSection('🐾 Pet Salon', 'Service Quality: Ensure that pet salons meet a certain quality standard. Liability: PetBuddy application is not responsible for salon services and any mishandling of pets.'),
          _buildSection('🐾 Pet Trainer', 'Trainer Qualifications: Ensure that trainers are certified and qualified. Liability: PetBuddy is not responsible for the effectiveness of training.'),
          _buildSection('🐾 Mating Partner', 'Responsible Ownership: Pet Owners must understand the importance of responsible breeding. Legal Compliance: Pet Owners and Pet Adopters must comply with all relevant breeding laws. Liability: PetBuddy is not responsible for anything after connecting them.'),
          _buildSection('🐾 Rescue and NGO', 'Accreditation: Specify that only registered and accredited rescues and NGOs can participate.'),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Text(
          content,
          style: TextStyle(fontSize: 16),
        ),
        Divider(),
      ],
    );
  }
}