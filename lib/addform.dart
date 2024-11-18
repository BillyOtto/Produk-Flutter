import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/api.dart';
import 'dart:async';
import 'package:http/http.dart' as http;

class FormTambah extends StatefulWidget {
  const FormTambah({super.key});
  @override
  State<StatefulWidget> createState() => FormTambahState();
}

class FormTambahState extends State<FormTambah> {
  final formkey = GlobalKey<FormState>();
  TextEditingController namaController = TextEditingController();
  TextEditingController kodeController = TextEditingController();
  TextEditingController jumlahController = TextEditingController();
  TextEditingController statusController = TextEditingController();

  String? selectedValue;
  String? selectedReligion; // Menyimpan nilai yang dipilih
  Future createSw() async {
    return await http.post(Uri.parse(BaseUrl.tambah), body: {
      'nama': namaController.text,
      'kode': kodeController.text,
      "jumlah": jumlahController.text,
      "status": statusController.text,
    });
  }

  void _onConfirm(context) async {
    http.Response response = await createSw();
    final data = json.decode(response.body);
    if (data['success']) {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Produk",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4.0,
      ),
      body: Container(
        child: Column(
          children: [
            _textboxNama(),
            _textboxKode(),
            _textboxJumlah(),
            _textboxStatus(),
            const SizedBox(
                height: 20.0), // Memberikan jarak antara input form dan tombol
            _tombolSimpan(),
          ],
        ),
      ),
    );
  }

  _textboxNama() {
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
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Nama Produk",
          prefixIcon: Icon(
              Icons.shopping_bag), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        controller: namaController,
      ),
    );
  }

  _textboxKode() {
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
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Kode Barang",
          prefixIcon:
          Icon(Icons.shopping_bag), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        controller: kodeController,
      ),
    );
  }

  _textboxJumlah() {
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
      child: TextField(
        decoration: const InputDecoration(
          labelText: "Jumlah Barang",
          prefixIcon:
          Icon(Icons.add_shopping_cart_outlined), // Menambahkan ikon di dalam input form
          border: InputBorder.none, // Menghilangkan border default
          contentPadding: EdgeInsets.symmetric(
              vertical: 15.0, horizontal: 10.0), // Mengatur padding
        ),
        controller: jumlahController,
      ),
    );
  }

  _textboxStatus() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Posisi shadow
          ),
        ],
      ),
      child: DropdownButtonFormField<String>(
        decoration: const InputDecoration(
          labelText: 'Status',
          prefixIcon: Icon(Icons.check), // Anda bisa mengganti ikon jika perlu
          border: InputBorder.none,
          contentPadding:
          EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
        ),
        isExpanded: true,
        hint: const Text(
          'Status Barang',
          style: TextStyle(fontSize: 14),
        ),
        items: [
          DropdownMenuItem(
            value: '1', // ID untuk Laki-laki
            child: Text('Baik', style: const TextStyle(fontSize: 14)),
          ),
          DropdownMenuItem(
            value: '2', // ID untuk Perempuan
            child: Text('Rusak', style: const TextStyle(fontSize: 14)),
          ),
        ],
        // Menggunakan selectedValue jika ada, jika tidak, menggunakan nilai dari controller
        value: selectedValue ??
            (statusController.text.isNotEmpty
                ? statusController.text
                : null),
        onChanged: (String? value) {
          setState(() {
            selectedValue = value; // Set nilai yang dipilih
            statusController.text =
            selectedValue!; // Simpan ke controller
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Pilih Jenis Kelamin Anda.';
          }
          return null;
        },
      ),
    );
  }

  _tombolSimpan() {
    return ElevatedButton(
      onPressed: () {
        _onConfirm(context);
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.purple, // Warna teks
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(10.0), // Membuat sudut tombol melengkung
        ),
        padding: const EdgeInsets.symmetric(
            vertical: 15.0, horizontal: 30.0), // Padding di dalam tombol
        elevation: 5.0, // Efek shadow di bawah tombol
        shadowColor: Colors.grey.withOpacity(0.5), // Warna shadow
      ),
      child: const Text(
        'Submit',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}