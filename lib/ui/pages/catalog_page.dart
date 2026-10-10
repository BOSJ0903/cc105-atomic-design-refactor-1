import 'package:flutter/material.dart';
import '../templates/catalog_template.dart';
import '../organisms/product_card.dart';
import '../organisms/add_product_form.dart';
import '../molecules/search_input.dart';
import '../atoms/section_header.dart';

class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  final List<Map<String, dynamic>> _products = [
    {'id': 1, 'name': 'Wireless Mouse', 'price': 599.0, 'category': 'Electronics', 'icon': Icons.mouse},
    {'id': 2, 'name': 'Mechanical Keyboard', 'price': 2499.0, 'category': 'Electronics', 'icon': Icons.keyboard},
    {'id': 3, 'name': 'Ceramic Mug', 'price': 149.0, 'category': 'Home', 'icon': Icons.coffee},
    {'id': 4, 'name': 'Notebook', 'price': 79.0, 'category': 'Office', 'icon': Icons.book},
    {'id': 5, 'name': 'Desk Lamp', 'price': 899.0, 'category': 'Home', 'icon': Icons.lightbulb},
    {'id': 6, 'name': 'Backpack', 'price': 1299.0, 'category': 'Accessories', 'icon': Icons.backpack},
    {'id': 7, 'name': 'Water Bottle', 'price': 299.0, 'category': 'Accessories', 'icon': Icons.local_drink},
  ];

  String _searchQuery = '';
  int _nextId = 8;

  void _addNewProduct(Map<String, dynamic> newProductData) {
    setState(() {
      // Safely extracting the map without using spread operators
      _products.add({
        'id': _nextId,
        'name': newProductData['name'],
        'price': newProductData['price'],
        'category': newProductData['category'],
        'icon': newProductData['icon'],
        'description': newProductData['description'],
      });
      _nextId++;
      _searchQuery = '';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${newProductData['name']} added to catalog!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _deleteProduct(int id) {
    setState(() {
      _products.removeWhere((p) => p['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = _products.where((p) {
      return p['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return CatalogTemplate(
      searchHeaderSlot: const SectionHeader(title: 'Search Products'),
      searchSlot: SearchInput(
        onChanged: (value) => setState(() => _searchQuery = value),
      ),
      catalogHeaderSlot: const SectionHeader(title: 'Catalog'),
      catalogSlot: Column(
        children: filteredProducts.map((product) {
          return ProductCard(
            product: product,
            onAddToCart: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Added ${product['name']} to cart')),
              );
            },
            onDelete: () => _deleteProduct(product['id'] as int),
          );
        }).toList(),
      ),
      formHeaderSlot: const SectionHeader(title: 'Add New Product'),
      formSlot: AddProductForm(onSubmit: _addNewProduct),
    );
  }
}