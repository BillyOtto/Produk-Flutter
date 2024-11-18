import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:crudproduk/models/api.dart';
import 'package:crudproduk/models/mproduk.dart';
import 'package:http/http.dart' as http;
import 'addform.dart';
import 'details.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<ProdukModel>> _produkListFuture;

  @override
  void initState() {
    super.initState();
    _produkListFuture = _fetchProdukList();
  }

  Future<List<ProdukModel>> _fetchProdukList() async {
    final response = await http.get(Uri.parse(BaseUrl.data));

    if (response.statusCode == 200) {
      final List<dynamic> items = json.decode(response.body);
      return items.map<ProdukModel>((json) => ProdukModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Data Barang"),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body: Center(
        child: FutureBuilder<List<ProdukModel>>(
          future: _produkListFuture,
          builder: (BuildContext context, AsyncSnapshot<List<ProdukModel>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Text("No data available");
            }

            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var produk = snapshot.data![index];
                return Card(
                  child: ListTile(
                    leading: Icon(Icons.inventory_2_rounded),
                    trailing: Icon(Icons.view_list),
                    title: Text(
                      '${produk.kode} ${produk.nama}',
                      style: TextStyle(fontSize: 20),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Details(sw: produk),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FormTambah(),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
