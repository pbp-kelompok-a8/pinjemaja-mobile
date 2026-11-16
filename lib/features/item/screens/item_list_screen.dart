import 'package:flutter/material.dart';

class ItemListScreen extends StatelessWidget {
  const ItemListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Barang')),
      body: const Center(child: Text('Halaman Barang')),
    );
  }
}