class Produk {
  String? id;
  String? kodeProduk;
  String? namaProduk;
  int? hargaProduk;

  Produk({this.id, this.kodeProduk, this.namaProduk, this.hargaProduk});

  factory Produk.fromJson(Map<String, dynamic> obj) {
    return Produk(
      // Konversi paksa ke String agar aman
      id: obj['id'].toString(),

      kodeProduk: obj['kode_produk'],
      namaProduk: obj['nama_produk'],

      // Konversi paksa ke String dulu, baru diubah ke Integer
      // Ini mengatasi masalah jika API mengirim angka sebagai teks
      hargaProduk: int.tryParse(obj['harga'].toString()) ?? 0,
    );
  }
}
