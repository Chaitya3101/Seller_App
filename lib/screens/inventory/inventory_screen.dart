import 'dart:io';
import 'package:flutter/material.dart';
import '../products/add_product_screen.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  List<Map<String, dynamic>> products = [];

  void _navigateToAddProduct() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddProductScreen()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        products.add(result);
      });
    }
  }
  void _editProduct(int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => AddProductScreen()),
    );

    if (result != null && result is Map<String, dynamic>) {
      setState(() {
        products[index] = result;
      });
    }
  }

  void _deleteProduct(int index) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Delete Product"),
        content: Text("Are you sure you want to delete this product?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                products.removeAt(index);
              });
              Navigator.pop(context);
            },
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Inventory Management"),
        backgroundColor: Colors.indigo,
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.indigo.shade100,
                child: Icon(Icons.shopping_bag, color: Colors.indigo),
              ),
              title: Text(product["name"]),
              subtitle: Text("₹${product["price"]} • Stock: ${product["stock"]}"),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _editProduct(index),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteProduct(index),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddProduct,
        backgroundColor: Colors.indigo,
        child: Icon(Icons.add),
      ),
    );
  }
}
