import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class EditProfilePage extends StatelessWidget {
  var userName;

  EditProfilePage({Key? key, required this.userName}) : super(key: key);

  late final TextEditingController _nameController = TextEditingController(
    text: userName,
  );
  final TextEditingController _mobileController = TextEditingController(
    text: "+91 9967019467",
  );
  final TextEditingController _emailController = TextEditingController(
    text: "priyasatim@example.com",
  );
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _anniversaryController = TextEditingController();

  String? _selectedGender;
  File? _profileImage;
  //  ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView (child: Column(
          children: [
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      // onTap: _showImagePickerOptions,
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[300],
                            backgroundImage:
                            _profileImage != null ? FileImage(_profileImage!) : null,
                            child: _profileImage == null
                                ? Icon(Icons.person, size: 50, color: Colors.grey[700])
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              padding: EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Color(0xFFE23744),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(Icons.edit, color: Colors.white, size: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16),
                    // Name field
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: "Name",
                        prefixIcon: Icon(Icons.person),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Mobile field
                    TextField(
                      controller: _mobileController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Mobile",
                        prefixIcon: Icon(Icons.phone),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    // Email field
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        prefixIcon: Icon(Icons.email),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),

                    SizedBox(height: 16),

                    // Date of Birth field
                    TextField(
                      controller: _dobController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Date of Birth",
                        suffixIcon: Icon(Icons.calendar_today),
                        isDense: true,
                        border: OutlineInputBorder(),
                      ),
                      onTap: () => _selectDate(context, _dobController),
                    ),

                    SizedBox(height: 16),

                    // Anniversary
                    TextField(
                      controller: _anniversaryController,
                      readOnly: true,
                      decoration: InputDecoration(
                        labelText: "Anniversary",
                        suffixIcon: Icon(Icons.calendar_today),
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      onTap: () => _selectDate(context, _anniversaryController),
                    ),

                    SizedBox(height: 16),

                    // Gender
                    DropdownButtonFormField<String>(
                      value: _selectedGender,
                      decoration: InputDecoration(
                        labelText: "Gender",
                        border: OutlineInputBorder(),
                        isDense: true
                      ),
                      items: ["Male", "Female", "Other"]
                          .map(
                            (gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ),
                          )
                          .toList(),
                      onChanged: (value) {

                      },
                    ),
                  ],
                ),
              ),

            SizedBox(height: 24),

            // Save button
            SizedBox(
              height: 48,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  saveUserData();
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text("Profile saved!")));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFE23744),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text("Update Profile", style: TextStyle(fontSize: 12,color: Colors.white)),
              ),
            ),
          ],
        ),),
      ),
    );
  }

  Future<void> _selectDate(
    BuildContext context,
    TextEditingController controller,
  ) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      controller.text =
          "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
    }
  }


  Future<void> saveUserData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("name", _nameController.text);
    await prefs.setString("mobile", _mobileController.text);
    await prefs.setString("dob", _dobController.text);
    await prefs.setString("gender", _selectedGender ?? "");
  }
}
