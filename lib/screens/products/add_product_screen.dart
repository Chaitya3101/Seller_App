import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import '../inventory/inventory_screen.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final stockController = TextEditingController();
  final descController = TextEditingController();
  String? selectedCategory;
  File? _image;

  Future<void> _pickImage() async {
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  Future<bool> addProductWithImage({
    required String name,
    required double price,
    required int stock,
    required String category,
    required String description,
    File? imageFile,
  }) async {
    var uri = Uri.parse('http://localhost:5001/api/products');
    var request = http.MultipartRequest('POST', uri);

    request.fields['name'] = name;
    request.fields['price'] = price.toString();
    request.fields['stock'] = stock.toString();
    request.fields['category'] = category;
    request.fields['description'] = description;

    if (imageFile != null) {
      request.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));
    }

    var response = await request.send();
    return response.statusCode == 201;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate() && selectedCategory != null) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => Center(child: CircularProgressIndicator()),
      );

      bool success = await addProductWithImage(
        name: nameController.text,
        price: double.parse(priceController.text),
        stock: int.parse(stockController.text),
        category: selectedCategory!,
        description: descController.text,
        imageFile: _image,
      );

      Navigator.pop(context); // Close loading dialog

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => InventoryScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add product')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please complete all required fields."),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Product"),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.indigo.shade200),
                    image: _image != null
                        ? DecorationImage(
                            image: FileImage(_image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _image == null
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo,
                                size: 40, color: Colors.indigo),
                            SizedBox(height: 8),
                            Text(
                              "Tap to add product image",
                              style: TextStyle(color: Colors.indigo.shade600),
                            ),
                          ],
                        )
                      : null,
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: "Product Name *",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.shopping_bag),
                ),
                validator: (value) =>
                    value!.isEmpty ? "Product name is required" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: priceController,
                decoration: InputDecoration(
                  labelText: "Price *",
                  border: OutlineInputBorder(),
                  prefixText: "₹",
                  prefixIcon: Icon(Icons.attach_money),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return "Price is required";
                  if (double.tryParse(value) == null)
                    return "Please enter a valid price";
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: stockController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Stock Quantity *",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.inventory),
                ),
                validator: (val) {
                  if (val!.isEmpty) return "Stock quantity is required";
                  if (int.tryParse(val) == null)
                    return "Please enter a valid number";
                  return null;
                },
              ),
              SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: selectedCategory,
                items: ["Men", "Women", "Kids", "Essentials"]
                    .map(
                        (cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                    .toList(),
                onChanged: (val) => setState(() => selectedCategory = val),
                decoration: InputDecoration(
                  labelText: "Category *",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.category),
                ),
                validator: (val) =>
                    val == null ? "Please select a category" : null,
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: descController,
                decoration: InputDecoration(
                  labelText: "Description *",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? "Description is required" : null,
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.indigo,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    "Add Product",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    stockController.dispose();
    descController.dispose();
    super.dispose();
  }
}
