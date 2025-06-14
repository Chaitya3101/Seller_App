
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
        title: Text("Inventory"),
        backgroundColor: Colors.indigo,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _navigateToAddProduct,
          )
        ],
      ),
      body: products.isEmpty
          ? Center(child: Text("No products added yet."))
          : Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 12, mainAxisSpacing: 12, childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return GestureDetector(
              onTap: () => _editProduct(index),
              onLongPress: () => _deleteProduct(index),
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                        child: product["image"] != null
                            ? Image.file(product["image"], fit: BoxFit.cover)
                            : Container(
                          color: Colors.grey[200],
                          child: Icon(Icons.image_not_supported, size: 40),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product["name"], style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("₹${product["price"]} • Stock: ${product["stock"]}"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
