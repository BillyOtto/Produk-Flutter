import 'package:flutter/material.dart';
import 'package:radio_group_v2/radio_group_v2.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class AppForm extends StatefulWidget {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController namaController,
      kodeController,
      jumlahController,
      statusController;

  AppForm(
      { required this.formkey,
        required this.namaController,
        required this.kodeController,
        required this.jumlahController,
        required this.statusController,
      });

  @override
  AppFormState createState() => AppFormState();
}

class AppFormState extends State<AppForm> {
  String _statusProduk= "";
  final _status = ["1", "2"];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formkey,
      autovalidateMode: AutovalidateMode.always,
      child: SingleChildScrollView(
        child: Column(
          children: [
            txtNama(),
            txtKode(),
            txtJumlah(),
            txtStatus(),
          ],
        ),
      ),
    );
  }

  txtNama(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.namaController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Student Name",
          prefixIcon: Icon(Icons.backpack), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Masukan Nama Produk.';
          }
          return null;
        },
      ),

    );
  }
  txtStatus() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.check),
              SizedBox(width: 10.0),
              Text(
                "Status Barang",
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          // Menggunakan Radio Button untuk Status Produk
          Column(
            children: _status.map((status) {
              return RadioListTile<String>(
                title: Text(
                  status == "1" ? "Bagus" : "Rusak",  // Label sesuai dengan status
                ),
                value: status,
                groupValue: widget.statusController.text,
                onChanged: (String? value) {
                  setState(() {
                    _statusProduk = value ?? '';  // Mengganti _genderWarga menjadi statusProduk
                    widget.statusController.text = _statusProduk; // Update controller dengan status yang dipilih
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }



  txtKode(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.kodeController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Item Code",
          prefixIcon: Icon(Icons.shopping_bag),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
      ),
    );
  }
  txtJumlah(){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white, // Warna latar belakang
        borderRadius: BorderRadius.circular(10.0), // Membuat sudut melengkung
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Warna shadow
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: TextFormField(
        controller: widget.jumlahController,
        keyboardType: TextInputType.text,
        decoration: const InputDecoration(
          labelText: "Item Code",
          prefixIcon: Icon(Icons.shopping_bag),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
      ),
    );
  }
}