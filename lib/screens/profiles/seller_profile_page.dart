import 'package:flutter/material.dart';

class SellerProfilePage extends StatefulWidget {
  @override
  _SellerProfilePageState createState() => _SellerProfilePageState();
}

class _SellerProfilePageState extends State<SellerProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final companyController = TextEditingController(text: "Prime Vision Co.");
  final emailController = TextEditingController(text: "primevision@email.com");
  final phoneController = TextEditingController(text: "+91 9876543210");

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Profile updated!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Profile"),
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              CircleAvatar(radius: 40, child: Icon(Icons.person, size: 40)),
              SizedBox(height: 24),
              TextFormField(
                controller: companyController,
                decoration: InputDecoration(labelText: "Company Name"),
                validator: (val) => val!.isEmpty ? "Required" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                readOnly: true,
                decoration: InputDecoration(labelText: "Email"),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: "Phone Number"),
                validator: (val) => val!.isEmpty ? "Required" : null,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text("Save Changes"),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
              )
            ],
          ),
        ),
      ),
    );
  }
}
