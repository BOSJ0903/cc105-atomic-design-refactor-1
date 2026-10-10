import 'package:flutter/material.dart';

class CatalogTemplate extends StatelessWidget {
  final Widget searchSlot;
  final Widget catalogSlot;
  final Widget formSlot;
  final Widget searchHeaderSlot;
  final Widget catalogHeaderSlot;
  final Widget formHeaderSlot;

  const CatalogTemplate({
    super.key,
    required this.searchSlot,
    required this.catalogSlot,
    required this.formSlot,
    required this.searchHeaderSlot,
    required this.catalogHeaderSlot,
    required this.formHeaderSlot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messy Catalog',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.indigo,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchHeaderSlot,
            const SizedBox(height: 8),
            searchSlot,
            const SizedBox(height: 16),
            catalogHeaderSlot,
            const SizedBox(height: 8),
            catalogSlot,
            const Divider(height: 32, thickness: 1),
            formHeaderSlot,
            const SizedBox(height: 12),
            formSlot,
          ],
        ),
      ),
    );
  }
}