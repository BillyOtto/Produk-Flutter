import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:crudproduk/models/api.dart';
import 'package:crudproduk/models/mproduk.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

import 'appform.dart';

class Edit extends StatefulWidget {
  final ProdukModel sw;

  Edit({required this.sw});

  @override
  EditState createState() => EditState();
}

class EditState extends State<Edit> {
  final formKey = GlobalKey<FormState>();

  late TextEditingController namaController;
  late TextEditingController kodeController;
  late TextEditingController jumlahController;
  late TextEditingController statusController;

  // Fungsi untuk melakukan update produk
  Future<http.Response> editSw() async {
    return await http.post(
      Uri.parse(BaseUrl.ubah),
      body: {
        "id": widget.sw.id.toString(),
        "nama": namaController.text,
        "kode": kodeController.text,
        "jumlah": jumlahController.text,
        "status": statusController.text,
      },
    );
  }

  // Menampilkan toast setelah perubahan disimpan
  void showMessage() {
    Fluttertoast.showToast(
      msg: "Perubahan Data Disimpan",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

  // Fungsi untuk konfirmasi perubahan
  void _onConfirm(BuildContext context) async {
    final response = await editSw();
    final data = json.decode(response.body);

    if (data['success']) {
      showMessage();
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    }
  }

  // Inisialisasi controller dengan data yang ada
  @override
  void initState() {
    super.initState();
    namaController = TextEditingController(text: widget.sw.nama);
    kodeController = TextEditingController(text: widget.sw.kode);
    jumlahController = TextEditingController(text: widget.sw.jumlah.toString());
    statusController = TextEditingController(text: widget.sw.status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Produk"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          child: Text("Update"),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            backgroundColor: Colors.green,
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          onPressed: () {
            _onConfirm(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: AppForm(
            formkey: formKey,
            namaController: namaController,
            kodeController: kodeController,
            jumlahController: jumlahController,
            statusController: statusController,
          ),
        ),
      ),
    );
  }
}
