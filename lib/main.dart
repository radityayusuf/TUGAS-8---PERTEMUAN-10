import 'package:flutter/material.dart';
import 'package:tokokita/ui/produk_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Kita',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // INI KUNCINYA:
        primarySwatch: Colors.blue, // Mengatur warna dasar menjadi biru
        useMaterial3:
            false, // Mematikan desain baru agar kembali ke gaya lama (sesuai modul)
      ),
      home: const ProdukPage(), // Pastikan ini mengarah ke halaman yang benar
    );
  }
}
