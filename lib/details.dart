import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:crudproduk/models/api.dart';
import 'package:crudproduk/models/mproduk.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'edit.dart';

// Enum untuk status produk
enum StatusProduk {
  baik, // Status 1
  rusak, // Status 2
  tidakDiketahui // Status default
}

class Details extends StatefulWidget {
  final ProdukModel sw;

  Details({required this.sw});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  // Fungsi untuk menghapus produk
  Future<void> deleteProduk(BuildContext context) async {
    int productId = int.tryParse(widget.sw.id.toString()) ?? 0; // Jika ID adalah String, coba konversi ke int

    final response = await http.post(
      Uri.parse(BaseUrl.hapus),
      body: {'id': productId.toString()}, // pastikan body menerima String
    );

    final data = json.decode(response.body);
    if (data['success']) {
      _showSuccessMessage();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  // Menampilkan pesan sukses setelah penghapusan
  void _showSuccessMessage() {
    Fluttertoast.showToast(
      msg: "Menghapus Data Berhasil",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Fungsi konfirmasi sebelum menghapus
  void _confirmDelete(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text('Apakah Anda Yakin?'),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Icon(Icons.cancel),
            ),
            ElevatedButton(
              onPressed: () => deleteProduk(context),
              child: Icon(Icons.check_circle),
            ),
          ],
        );
      },
    );
  }

  // Fungsi untuk mengonversi status enum menjadi String
  String _mapStatus(StatusProduk status) {
    switch (status) {
      case StatusProduk.baik:
        return 'Baik';
      case StatusProduk.rusak:
        return 'Rusak';
      default:
        return 'Tidak Diketahui';
    }
  }

  // Fungsi untuk mengonversi String menjadi enum StatusProduk
  StatusProduk _parseStatus(String status) {
    switch (status) {
      case '1':
        return StatusProduk.baik;
      case '2':
        return StatusProduk.rusak;
      default:
        return StatusProduk.tidakDiketahui;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Parsing status menggunakan fungsi _parseStatus untuk mengonversi String ke enum
    StatusProduk statusEnum = _parseStatus(widget.sw.status);

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Produk"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        actions: [
          // Tombol Delete dihapus dari app bar
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID: ${widget.sw.id}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Code: ${widget.sw.kode}",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Jumlah: ${widget.sw.jumlah}",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Status: ${_mapStatus(statusEnum)}",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: statusEnum == StatusProduk.baik ? Colors.green : Colors.red,
                    ),
                  ),
                  SizedBox(height: 25),
                  // Tombol Edit
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.indigoAccent, // Background color
                        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => Edit(sw: widget.sw),
                          ),
                        );
                      },
                      child: Text(
                        "Edit Produk",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _confirmDelete(context), // Tombol delete yang ada di bawah
        backgroundColor: Colors.red,
        child: Icon(Icons.delete),
      ),
    );
  }
}
