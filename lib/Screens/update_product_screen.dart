import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/product.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {

  late TextEditingController _productNameTE = TextEditingController();
  late TextEditingController _unitPriceTE = TextEditingController();
  late TextEditingController _totalPriceTE = TextEditingController();
  late TextEditingController _productCodeTE = TextEditingController();
  late TextEditingController _productQuantityTE = TextEditingController();
  late TextEditingController _productImageTE = TextEditingController();
  late GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Product product;
  bool _inProgress = false;

  @override
  void initState() {
    product = widget.product;
    _productNameTE = TextEditingController(text: product.productName);
     _unitPriceTE = TextEditingController(text: product.unitPrice);
     _totalPriceTE = TextEditingController(text: product.totalPrice);
  _productCodeTE = TextEditingController(text: product.productCode);
    _productQuantityTE = TextEditingController(text: product.quantity);
    _productImageTE = TextEditingController(text: product.productImage);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        centerTitle: true,
        title: Text('Update Product', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildNewProductForm(),
      ),
    );
  }

  // the add new product form
  Widget _buildNewProductForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
            controller: _productNameTE,
            decoration: InputDecoration(
              hintText: 'Enter Product Name',
              labelText: 'Product Name',
            ),
          ),
          TextFormField(
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
            controller: _unitPriceTE,
            decoration: InputDecoration(
              hintText: 'Unit Price',
              labelText: 'Unit Price',
            ),
          ),
          TextFormField(
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
            controller: _totalPriceTE,
            decoration: InputDecoration(
              hintText: 'Total Price',
              labelText: 'Total Price',
            ),
          ),
          TextFormField(
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
            controller: _productCodeTE,
            decoration: InputDecoration(
              hintText: 'Product Code',
              labelText: 'Product Code',
            ),
          ),
          TextFormField(
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
            controller: _productQuantityTE,
            decoration: InputDecoration(
              hintText: 'Product Quantity',
              labelText: 'Product Quantity',
            ),
          ),
          TextFormField(
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Enter a valid value';
              }
              return null;
            },
            controller: _productImageTE,
            decoration: InputDecoration(
              hintText: 'Image',
              labelText: 'Product Image',
            ),
          ),
          SizedBox(
            height: 16,
          ),
          _inProgress ? Center(
            child: CircularProgressIndicator(),
          ) : ElevatedButton(
            onPressed: _onTapUpdateProductButton,
            child: Text('Update'),
            style: ElevatedButton.styleFrom(
                fixedSize: Size.fromWidth(double.maxFinite)),
          ),
        ],
      ),
    );
  }

  // add button function
  void _onTapUpdateProductButton() {
    if (_formKey.currentState!.validate()) {
      updateExistingProduct();
    }
  }


  Future<void> updateExistingProduct() async {
    _inProgress = true;
    setState(() {});
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/UpdateProduct/${product.id}');
    Map<String, dynamic> requestBody = {
      "Img": _productImageTE.text,
      "ProductCode": _productCodeTE.text,
      "ProductName": _productNameTE.text,
      "Qty": _productQuantityTE.text,
      "TotalPrice": _totalPriceTE.text,
      "UnitPrice": _unitPriceTE.text,
    };
    Response response = await post(uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      _clearTextFields();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product Updated'),
        ),
      );
    }
    _inProgress = false;
    setState(() {});
  }

  void _clearTextFields() {
    _productNameTE.clear();
    _unitPriceTE.clear();
    _totalPriceTE.clear();
    _productCodeTE.clear();
    _productQuantityTE.clear();
    _productImageTE.clear();
  }

  @override
  void dispose() {
    _productNameTE.dispose();
    _unitPriceTE.dispose();
    _totalPriceTE.dispose();
    _productCodeTE.dispose();
    _productQuantityTE.dispose();
    _productImageTE.dispose();
    super.dispose();
  }
}
