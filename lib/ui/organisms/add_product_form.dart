import 'package:flutter/material.dart';
import '../atoms/primary_button.dart';
import '../molecules/app_text_field.dart';

class AddProductForm extends StatefulWidget {
  // 1. Fixed the callback type to Flutter's native ValueChanged
  final ValueChanged<Map<String, dynamic>> onSubmit;

  const AddProductForm({super.key, required this.onSubmit});

  @override
  State<AddProductForm> createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  // 2. Guaranteed GlobalKey type
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  String _selectedCategory = 'Electronics';

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _handleValidationAndSubmit() {
    if (_formKey.currentState!.validate()) {
      // 3. Forced the Map to be strictly typed
      final Map<String, dynamic> newProduct = {
        'name': _nameController.text,
        'price': double.parse(_priceController.text),
        'category': _selectedCategory,
        'icon': Icons.inventory_2,
        'description': _descriptionController.text,
      };

      widget.onSubmit(newProduct);

      _nameController.clear();
      _priceController.clear();
      _descriptionController.clear();
      setState(() {
        _selectedCategory = 'Electronics';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppTextField(
            controller: _nameController,
            labelText: 'Product Name',
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Product name is required';
              return null;
            },
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: _priceController,
            labelText: 'Price',
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.trim().isEmpty) return 'Price is required';
              final parsed = double.tryParse(value);
              if (parsed == null) return 'Price must be a number';
              if (parsed <= 0) return 'Price must be greater than zero';
              return null;
            },
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: _selectedCategory,
            decoration: const InputDecoration(labelText: 'Category'),
            items: ['Electronics', 'Home', 'Office', 'Accessories']
                .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                .toList(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value ?? 'Electronics';
              });
            },
          ),
          const SizedBox(height: 12),
          AppTextField(
            controller: _descriptionController,
            labelText: 'Description',
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          PrimaryButton(
            onPressed: _handleValidationAndSubmit,
            text: 'Submit Product',
          ),
        ],
      ),
    );
  }
}