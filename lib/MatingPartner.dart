import 'package:flutter/material.dart';

class MatingPartnerPage extends StatefulWidget {
  @override
  _MatingPartnerPageState createState() => _MatingPartnerPageState();
}

class _MatingPartnerPageState extends State<MatingPartnerPage> {
  String selectedBreed = '';
  String selectedGender = '';
  int selectedAge = 0; // Change this data type based on your requirements
  // Other variables for search criteria

  final List<String> breeds = ['Breed 1', 'Breed 2', 'Breed 3']; // Sample breed list
  final List<String> genders = ['Male', 'Female']; // Sample gender list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mating Partner'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Find a Mating Partner',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedBreed,
              items: breeds.map((breed) {
                return DropdownMenuItem<String>(
                  value: breed,
                  child: Text(breed),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedBreed = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Breed',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            DropdownButtonFormField<String>(
              value: selectedGender,
              items: genders.map((gender) {
                return DropdownMenuItem<String>(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedGender = value!;
                });
              },
              decoration: InputDecoration(
                labelText: 'Select Gender',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  selectedAge = int.tryParse(value) ?? 0;
                });
              },
              decoration: InputDecoration(
                labelText: 'Enter Age',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement search functionality based on selected criteria
                // Use selectedBreed, selectedGender, selectedAge, etc., for filtering
                // Update the UI with search results in a list
              },
              child: Text('Search'),
            ),
            SizedBox(height: 20),
            // Display search results in a list view
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Replace with the number of search results
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('Mating Partner ${index + 1}'),
                    subtitle: Text('Details of the potential partner'),
                    onTap: () {
                      // Implement action when selecting a partner from the list
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}


