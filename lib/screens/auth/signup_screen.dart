import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../dashboard/seller_dashboard_with_sidebar_logout.dart';

class SellerSignupScreen extends StatefulWidget {
  @override
  _SellerSignupScreenState createState() => _SellerSignupScreenState();
}

class _SellerSignupScreenState extends State<SellerSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final companyController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => SellerDashboardWithSidebar()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Eyewear Seller"),
        backgroundColor: Colors.indigo,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12),
            child: Icon(Icons.account_circle, color: Colors.white),
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("User Registration and Profiles",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Create an account to sell your products",
                      style: TextStyle(fontSize: 16, color: Colors.grey.shade700)),
                  SizedBox(height: 32),
                  TextFormField(
                    controller: companyController,
                    decoration: InputDecoration(labelText: "Company Name", border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(labelText: "Email", border: OutlineInputBorder()),
                    validator: (value) => value!.isEmpty ? "Required" : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Password", border: OutlineInputBorder()),
                    validator: (value) => value!.length < 6 ? "At least 6 characters" : null,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: confirmController,
                    obscureText: true,
                    decoration: InputDecoration(labelText: "Confirm Password", border: OutlineInputBorder()),
                    validator: (value) => value != passwordController.text ? "Passwords don't match" : null,
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 14),
                        backgroundColor: Colors.indigo,
                      ),
                      child: Text("Sign Up", style: TextStyle(fontSize: 16)),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => SellerLoginScreen()),
                          );
                        },
                        child: Text("Log in"),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
