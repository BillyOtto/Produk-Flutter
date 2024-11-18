class ProdukModel {
  final int id;
  final int jumlah;
  final String nama, kode, status;
  ProdukModel({
    required this.id,
    required this.nama,
    required this.kode,
    required this.jumlah,
    required this.status,
  });

  factory ProdukModel.fromJson(Map<String, dynamic> json){
    return ProdukModel(
      id: json['id'],
      nama: json['nama'],
      kode: json['kode'],
      jumlah: json['jumlah'],
      status: json['status'],
    );
  }
  Map<String, dynamic> toJson() => {
    "nama": nama,
    "kode": kode,
    "jumlah": jumlah,
    "status": status,
  };
}